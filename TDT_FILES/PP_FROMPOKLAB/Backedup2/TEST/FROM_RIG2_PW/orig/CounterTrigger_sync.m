function CounterTrigger_sync(pcount,fcount,tfcount,dur,reps)

% pcount=[pcount(1) pcount(2)]
% pcount(1)=number of pulse trains; pcount(2)=number of pulses in each
% train
% fcount = length same as number of pulse trains
% tfcount = total number of frames in each rep
% gives the frames at which the pulse trian will be o/p
% dur = [dur(1) dur(2)]; dur(1) is duration of pulse and dur(2) = inter
% pulse interval in ms


%Initialize analogout
% ai = analoginput('nidaq',1);
% set(ai,'SampleRate',10000)
% set(ai,'InputType','SingleEnded')
% set(ai,'Triggertype','Immediate')
% chis=addchannel(ai,[0 1 2 3]);
% set(ai,'SamplesPerTrigger',4*10000)%set time based on input
daqreset
boardID=1;Fso=10000;amp=5;

ao = analogoutput('nidaq',boardID);
set(ao,'SampleRate',Fso)
set(ao,'Triggertype','HwDigital')

cho=addchannel(ao,1);
param = loadNI;
counterNum = param.ND_COUNTER_0;
sdur=fix(dur/1000*Fso);
siu_data=zeros(sdur(2),1);
siu_data(1:sdur(1))=amp;
siu_data=repmat(siu_data,pcount(2),1);
siu_data=[siu_data; zeros(fix(05*Fso),1)];
putdata(ao,siu_data)
fcount=[fcount 2000000];
figure
plot(siu_data)
% iStatus = Select_Signal(boardID,param.ND_OUT_START_TRIGGER, param.ND_GPCTR0_OUTPUT, ...
%         param.ND_HIGH_TO_LOW);
% iStatus = GPCTR_Change_Parameter(boardID, counterNum, param.ND_OUTPUT_MODE, ...
%         param.ND_PULSE);

for repn=1:reps
    iStatus = Select_Signal(boardID,param.ND_OUT_START_TRIGGER, param.ND_GPCTR0_OUTPUT, ...
        param.ND_HIGH_TO_LOW);
    iStatus = Select_Signal(boardID,param.ND_GPCTR0_OUTPUT, param.ND_GPCTR0_OUTPUT, ...
        param.ND_HIGH_TO_LOW);
    iStatus = GPCTR_Change_Parameter(boardID, counterNum, param.ND_OUTPUT_MODE, ...
        param.ND_PULSE);
    %Output is structure containing NI constants, from nidaqcns.h
    %param.ND_NO=10;
    iLoopCount = 1000000;        %Number of times to check the counter's value
    %Hardware configuration
    counterNum = param.ND_COUNTER_0;    %The ID for the counter
    %Define pointers to get data back from the counter
    fmt = 'uint32Ptr';      % Pointer format string
    pulCount = libpointer(fmt,2^24-1);  %The number of events counted by the counter (initialized)
    %2^24-1 terminalcount
    pulTCReached = libpointer(fmt,param.ND_NO); %Indicates whether the counter has reached terminal count

    %iStatus = GPCTR_Control(boardID, counterNum, param.ND_RESET);
    iStatus = GPCTR_Set_Application(boardID, counterNum, ...
        param.ND_SIMPLE_EVENT_CNT);
    iStatus = GPCTR_Change_Parameter(boardID, counterNum, param.ND_SOURCE, ...
        param.ND_DEFAULT_PFI_LINE);
    %     /* Load initial count. */
    iStatus = GPCTR_Change_Parameter(boardID, counterNum, ...
        param.ND_INITIAL_COUNT, pulCount.value);

    iStatus = GPCTR_Control(boardID, counterNum, param.ND_PROGRAM);
%     /* Loop iLoopCount times. */
    started=zeros(1,pcount(1));to_play_pt_num=1;playing=0;
    for count=1:iLoopCount        
        %Get the counter value
        iStatus = GPCTR_Watch(boardID, counterNum, param.ND_COUNT, ...
            pulCount);
        %to_play_pt_num
        if pulCount.value==(fcount(to_play_pt_num)-1)
            stop(ao)
            putdata(ao,siu_data)
            playing=0;
        end
        if pulCount.value==fcount(to_play_pt_num)&started(to_play_pt_num)==0&playing==0
            10000
            start(ao) %%% have to synchronize this with counter 0 internal output by making it reach terminal count
            started(to_play_pt_num)=1;
            to_play_pt_num=to_play_pt_num+1;
            playing=1;
            plot(siu_data)
            
        end
        %get(ao,'Running')
        %get(ao,'RepeatOutput')
        %get(ao,'TriggersExecuted')
        %pulCount.value
        if pulCount.value==tfcount
            stop(ao)
            break %%% have to synchronize this with internal output
        end
        
        pause(.00001);
    end
    iStatus = GPCTR_Control(boardID, counterNum, param.ND_RESET);
    disp(sprintf('Done rep # %i!',repn));
    %unloadNI
    %eval(sprintf('d.repnum%i=getdata(ai);',repn))
end
unloadNI
daqreset
ao=analogoutput('nidaq',1);
cho=addchannel(ao,1);
putdata(ao,zeros(1000,1))
start(ao)
stop(ao)
daqreset
