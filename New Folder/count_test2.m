param = loadNI;
%fcount=[trig_frame 1000000];
% ai=analoginput('nidaq',1);
% ao=analogoutput('nidaq',1);
% chi=addchannel(ai,[0 1 2]);
% cho=addchannel(ao,[1]);
% set(ai,'SampleRate',10000)
% set(ao,'SampleRate',100000)
% set(ai,'InputType','SingleEnded')
% set(ai,'SamplesPerTrigger',200*20000)%set time based on input
% set(ai,'TimeOut',1000)
% set(ai,'Triggertype','HWDigital')
% set(ao,'Triggertype','HWDigital')
% yy=5*sin(2*pi*8000*[0:1/100000:.4])';
% figure
% plot(yy)
%t_iters

    
    
    iLoopCount = 1000000;        %Number of times to check the counter's value
    %Hardware configuration
    counterNum = param.ND_COUNTER_0;    %The ID for the counter
    %Define pointers to get data back from the counter
    fmt = 'uint32Ptr';      % Pointer format string
    iStatus = GPCTR_Control(1, counterNum, param.ND_RESET);
    pulCount = libpointer(fmt,0);  %The number of events counted by the counter (initialized)
    %2^24-1 terminalcount
    
   % pulTCReached = libpointer(fmt,param.ND_NO); %Indicates whether the counter has reached terminal count
    
    iStatus = GPCTR_Set_Application(1, counterNum, ...
        param.ND_SIMPLE_EVENT_CNT);
    iStatus = GPCTR_Change_Parameter(1, counterNum, param.ND_SOURCE, ...
        param.ND_DEFAULT_PFI_LINE);
    iStatus = GPCTR_Change_Parameter(1, counterNum, param.ND_SOURCE_POLARITY, ...
         param.ND_HIGH_TO_LOW);
    iStatus = Select_Signal(1,param.ND_GPCTR0_OUTPUT, param.ND_GPCTR0_OUTPUT, ...
        param.ND_LOW_TO_HIGH);
    iStatus = GPCTR_Change_Parameter(1, counterNum, param.ND_OUTPUT_MODE, ...
        param.ND_PULSE);
    %     /* Load initial count. */
    iStatus = GPCTR_Change_Parameter(1, counterNum, ...
        param.ND_INITIAL_COUNT, pulCount.value);
    iStatus = GPCTR_Control(1, counterNum, param.ND_PROGRAM);
    %    /* Loop iLoopCount times. */
    started=0;%armed_started=0;
%     putdata(ao,yy)
%     start([ai ao])

    for count=1:iLoopCount
        %Get the counter value
        iStatus = GPCTR_Watch(1, counterNum, param.ND_COUNT, ...
            pulCount);
        
        
        pulCount.value
        if pulCount.value==5
            pause(1)
            stop(ai)
            break
        end
            
        
        pause(.00001);
    end


unloadNI