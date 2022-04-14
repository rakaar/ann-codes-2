daqreset
param = loadNI;
%fcount=[trig_frame 1000000];
ai=analoginput('nidaq',1);
ao=analogoutput('nidaq',2);
chi=addchannel(ai,[0 1 2]);
cho=addchannel(ao,[1]);
set(ai,'SampleRate',10000)
set(ao,'SampleRate',10000)
set(ai,'InputType','SingleEnded')
set(ai,'SamplesPerTrigger',200*20000)%set time based on input
set(ai,'TimeOut',1000)
%set(ai,'Triggertype','HWDigital')
%set(ao,'Triggertype','HWDigital')
yy=[5*ones(1,2) zeros(1,98)];
yy=repmat(yy,1,20)';
figure
plot(yy)
%t_iters
  
    
    iLoopCount = 1000000;        %Number of times to check the counter's value
    %Hardware configuration
    counterNum1 = param.ND_COUNTER_0;    %The ID for the counter frame
    
    %Define pointers to get data back from the counter
    fmt = 'uint32Ptr';      % Pointer format string
    iStatus = GPCTR_Control(1, counterNum1, param.ND_RESET);
   pulCount1 = libpointer(fmt,0);
   iStatus = GPCTR_Set_Application(1, counterNum1, ...
        param.ND_SIMPLE_EVENT_CNT);
    iStatus = GPCTR_Change_Parameter(1, counterNum1, param.ND_SOURCE, ...
        param.ND_DEFAULT_PFI_LINE);
    iStatus = GPCTR_Change_Parameter(1, counterNum1, param.ND_SOURCE_POLARITY, ...
        param.ND_HIGH_TO_LOW);
    iStatus = Select_Signal(1,param.ND_GPCTR0_OUTPUT, param.ND_GPCTR0_OUTPUT, ...
        param.ND_DONT_CARE);
    iStatus = GPCTR_Change_Parameter(1, counterNum1, ...
        param.ND_INITIAL_COUNT, pulCount1.value);
    iStatus = GPCTR_Control(1, counterNum1, param.ND_PROGRAM);
%%%%%%%%%%%%%%%%% COUNTER1
     counterNum2 = param.ND_COUNTER_1;    %The ID for the counter line
%     iStatus = GPCTR_Control(1, counterNum2, param.ND_RESET);
%     iStatus = GPCTR_Set_Application(1, counterNum2, ...
%         param.ND_SIMPLE_EVENT_CNT);
%     iStatus = GPCTR_Change_Parameter(1, counterNum2, param.ND_SOURCE, ...
%         param.ND_DEFAULT_PFI_LINE);
%     iStatus = Select_Signal(1,param.ND_GPCTR1_OUTPUT, param.ND_GPCTR1_OUTPUT, ...
%         param.ND_LOW_TO_HIGH);
      iStatus = GPCTR_Set_Application(1, counterNum2, ...
        param.ND_SIMPLE_EVENT_CNT);
    iStatus = GPCTR_Change_Parameter(1, counterNum2, param.ND_SOURCE, ...
        param.ND_DEFAULT_PFI_LINE);
    iStatus = Select_Signal(1,param.ND_GPCTR1_OUTPUT, param.ND_GPCTR1_OUTPUT, ...
        param.ND_LOW_TO_HIGH);
    started=0;%armed_started=0;
    putdata(ao,yy)
    set(ai,'Triggertype','HWDigital')
    set(ao,'Triggertype','HWDigital')
    start([ai ao])
    current_count=pulCount1.value;
    frame=0;    
    for count=1:iLoopCount
        %Get the counter value
        iStatus = GPCTR_Watch(1, counterNum1, param.ND_COUNT, ...
            pulCount1);
        
        %%%%%%%%%%%%%% LOADING STIMULUS %%%%%%%%%%%%%%%%%% 
        %%%%%%%%%%%%%% GETTING TRIG INPUTS %%%%%%%%%%%%%%%
        %%%%%%%%%%%%%% AT 3 frames before trig frame %%%%%
        %pulCount1.value
        if (pulCount1.value==1)
            frame=frame+1
            if frame~=1
                stop(ai)
                eval(sprintf('dd.iter%i=getdata(ai,ai.SamplesAcquired);',frame-1))
                putdata(ao,yy)
                start([ai,ao])
            end
            start_line_counter(200,ao)
            fmt = 'uint32Ptr';      % Pointer format string
            iStatus = GPCTR_Control(1, counterNum1, param.ND_RESET);
            pulCount1 = libpointer(fmt,0);
            iStatus = GPCTR_Set_Application(1, counterNum1, ...
                param.ND_SIMPLE_EVENT_CNT);
            iStatus = GPCTR_Change_Parameter(1, counterNum1, param.ND_SOURCE, ...
                 param.ND_DEFAULT_PFI_LINE);
            iStatus = GPCTR_Change_Parameter(1, counterNum1, param.ND_SOURCE_POLARITY, ...
                param.ND_HIGH_TO_LOW);
%             iStatus = Select_Signal(1,param.ND_GPCTR0_OUTPUT, param.ND_GPCTR0_OUTPUT, ...
%                 param.ND_DONT_CARE);
            iStatus = GPCTR_Change_Parameter(1, counterNum1, ...
                param.ND_INITIAL_COUNT, pulCount1.value);
            iStatus = GPCTR_Control(1, counterNum1, param.ND_PROGRAM);
            
        end
        
        if frame==5
            pause(5)
            stop(ai)
                eval(sprintf('dd.iter%i=getdata(ai,ai.SamplesAcquired);',frame))
            break
        end
        
        pause(.00001);
    end



unloadNI
daqreset

