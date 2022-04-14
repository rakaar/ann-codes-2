function CounterTrigger_HWsync(pcount,fcount,tfcount,dur,reps)

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
tc=2^24-1;
cho=addchannel(ao,1);
param = loadNI;
counterNum = param.ND_COUNTER_0;%connected to frame triggers
sdur=fix(dur/1000*Fso);
siu_data=zeros(sdur(2),1);
siu_data(1:sdur(1))=amp;
siu_data=repmat(siu_data,pcount(2),1);
siu_data=[siu_data; zeros(fix(05*Fso),1)];
putdata(ao,siu_data)
fcount=[fcount 2000000];
figure
plot(siu_data)


    putdata(ao,siu_data)
    iStatus = GPCTR_Control(boardID, counterNum, param.ND_RESET);
    iStatus = GPCTR_Set_Application(boardID, counterNum, ...
        param.ND_SIMPLE_EVENT_CNT);
    iStatus = GPCTR_Change_Parameter(boardID, counterNum, param.ND_SOURCE, ...
        param.ND_DEFAULT_PFI_LINE);
    %     /* Load initial count. */
    fmt = 'uint32Ptr';      % Pointer format string
    pulCount = libpointer(fmt,tc-fcount(1));
    iStatus = GPCTR_Change_Parameter(boardID, counterNum, ...
            param.ND_INITIAL_COUNT, pulCount.value);
    iStatus = GPCTR_Change_Parameter(boardID, counterNum, ...
        param.ND_INITIAL_COUNT, pulCount.value);

    iStatus = GPCTR_Control(boardID, counterNum, param.ND_PROGRAM);
    iStatus = Select_Signal(boardID,param.ND_OUT_START_TRIGGER, param.ND_GPCTR0_OUTPUT, ...
        param.ND_HIGH_TO_LOW);
    iStatus = Select_Signal(boardID,param.ND_GPCTR0_OUTPUT, param.ND_GPCTR0_OUTPUT, ...
        param.ND_HIGH_TO_LOW);
    iStatus = GPCTR_Change_Parameter(boardID, counterNum, param.ND_OUTPUT_MODE, ...
        param.ND_PULSE);
    
    
    
    iStatus = GPCTR_Control(boardID, counterNum, param.ND_PROGRAM);
    start(ao)
    started_ao=0;
    while ao.TriggersExecuted==0&started_ao==0
        1+1
    end
    
unloadNI
daqreset
ao=analogoutput('nidaq',1);
cho=addchannel(ao,1);
putdata(ao,zeros(1000,1))
start(ao)
stop(ao)
daqreset