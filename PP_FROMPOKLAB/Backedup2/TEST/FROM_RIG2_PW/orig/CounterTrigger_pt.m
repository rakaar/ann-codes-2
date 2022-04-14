function CounterTrigger(pcount,fcount,tfcount,dur,reps)

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
set(ao,'Triggertype','Immediate')
cho=addchannel(ao,1);
param = loadNI;
sdur=fix(dur/1000*Fso);
siu_data=zeros(sdur(2),1);
siu_data(1:sdur(1))=amp;
siu_data=repmat(siu_data,pcount(2),1);
siu_data=[siu_data; zeros(fix(05*Fso),1)];

%fcount=[fcount];
figure
plot(siu_data)
fcount=[0 fcount];
last_frames=tfcount-fcount(end);

for repn=1:reps
    for ptnum=1:pcount(1)
        %ptnum
        %Output is structure containing NI constants, from nidaqcns.h
        %param.ND_NO=10;
        iLoopCount = 1000000;        %Number of times to check the counter's value
        %Hardware configuration
        counterNum = param.ND_COUNTER_0;    %The ID for the counter
        %Define pointers to get data back from the counter
        fmt = 'uint32Ptr';      % Pointer format string
        pulCount = libpointer(fmt,0);  %The number of events counted by the counter (initialized)
        %2^24-1 terminalcount
        pulTCReached = libpointer(fmt,param.ND_NO); %Indicates whether the counter has reached terminal count
        iStatus = GPCTR_Control(boardID, counterNum, param.ND_RESET);
        iStatus = GPCTR_Set_Application(boardID, counterNum, ...
            param.ND_SIMPLE_EVENT_CNT);
        iStatus = GPCTR_Change_Parameter(boardID, counterNum, param.ND_SOURCE, ...
            param.ND_DEFAULT_PFI_LINE);
        %     /* Load initial count. */
        iStatus = GPCTR_Change_Parameter(boardID, counterNum, ...
            param.ND_INITIAL_COUNT, pulCount.value);
        iStatus = GPCTR_Control(boardID, counterNum, param.ND_PROGRAM);
        %    /* Loop iLoopCount times. */
        started=0;
        stim_at_fnum=fcount(ptnum+1)-fcount(ptnum);
        putdata(ao,siu_data)
        for count=1:iLoopCount   
            %Get the counter value
            iStatus = GPCTR_Watch(boardID, counterNum, param.ND_COUNT, ...
                pulCount);
            %to_play_pt_num
            
            if pulCount.value==stim_at_fnum&started==0
                %10000
                start(ao) %%% have to synchronize this with counter 0 internal output by making it reach terminal count
                started=1;
                iStatus = GPCTR_Control(boardID, counterNum, param.ND_RESET);
                break
            end
            pause(.00001);
        end
        pause(.05)
        fprintf('Played Pulse Train # %i ... ',ptnum);
        stop(ao)
    end
    %Output is structure containing NI constants, from nidaqcns.h
    %param.ND_NO=10;
    iLoopCount = 1000000;        %Number of times to check the counter's value
    %Hardware configuration
    counterNum = param.ND_COUNTER_0;    %The ID for the counter
    %Define pointers to get data back from the counter
    fmt = 'uint32Ptr';      % Pointer format string
    pulCount = libpointer(fmt,0);  %The number of events counted by the counter (initialized)
    %2^24-1 terminalcount
    pulTCReached = libpointer(fmt,param.ND_NO); %Indicates whether the counter has reached terminal count
    iStatus = GPCTR_Control(boardID, counterNum, param.ND_RESET);
    iStatus = GPCTR_Set_Application(boardID, counterNum, ...
        param.ND_SIMPLE_EVENT_CNT);
    iStatus = GPCTR_Change_Parameter(boardID, counterNum, param.ND_SOURCE, ...
        param.ND_DEFAULT_PFI_LINE);
    %     /* Load initial count. */
    iStatus = GPCTR_Change_Parameter(boardID, counterNum, ...
        param.ND_INITIAL_COUNT, pulCount.value);
    iStatus = GPCTR_Control(boardID, counterNum, param.ND_PROGRAM);
    now_ct=0;
    for count=1:iLoopCount   
         %Get the counter value
         iStatus = GPCTR_Watch(boardID, counterNum, param.ND_COUNT, ...
            pulCount);
%         if pulCount.value>now_ct
%             pulCount.value
%             now_ct=pulCount.value;
%         end
        if pulCount.value==last_frames
            iStatus = GPCTR_Control(boardID, counterNum, param.ND_RESET);
            stop(ao)
            disp(sprintf('Done rep # %i!',repn));
            break
        end
        pause(.00001)
    end
end
unloadNI
daqreset
