function CounterTrigger_pt_LS(pcount,fcount,tfcount,dur,reps)

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
boardID=1;Fso=10000;amp=5;counternum=1;

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

fcount=[fcount 1000000];
figure
plot(siu_data)

for repn=1:reps
        %ptnum
        %Output is structure containing NI constants, from nidaqcns.h
        %param.ND_NO=10;
        iLoopCount = 1000000000;        %Number of times to check the counter's value
        %Hardware configuration
        counterNum = param.ND_COUNTER_1;    %The ID for the counter
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
        putdata(ao,siu_data)
        ptnum=1;
        for count=1:iLoopCount   
            %Get the counter value
            iStatus = GPCTR_Watch(boardID, counterNum, param.ND_COUNT, ...
                pulCount);
            %to_play_pt_num
            %pulCount.value
            if pulCount.value<fcount(ptnum+1)&pulCount.value>(fcount(ptnum+1)-10)
                stop(ao)
                putdata(ao,siu_data)
                started=0;
                ptnum=ptnum+1;
            end
            if pulCount.value>fcount(ptnum)&started==0
                %10000
                start(ao) %%% have to synchronize this with counter 0 internal output by making it reach terminal count
                started=1;
                fprintf('Played Pulse Train # %i ... ',ptnum);
            end
            if pulCount.value<tfcount&pulCount.value>(tfcount-10)
                iStatus = GPCTR_Control(boardID, counterNum, param.ND_RESET);
                stop(ao)
                disp(sprintf('Done rep # %i!',repn));
                break
            end
                
                            
            pause(.00000001);
        end
end
unloadNI
daqreset
