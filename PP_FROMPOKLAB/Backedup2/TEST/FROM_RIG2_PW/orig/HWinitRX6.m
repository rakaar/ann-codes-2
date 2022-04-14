function [HW]=HWinitRX6(casenum)

%%%%  for version 2.1 %%%%%%%%%%%% (Hardware triggering now with CTR0OUT
%%%%  and CTR1OUT LINE SCANS WILL WORK - HAVE TO FURTHER CHANGE TO INCLUDE
%%%%  MAX SPEED SCANS
%%% Initialize HARDWARE
daqreset
HW.boardID1=1; % number of the NI board % maybe use a second board for AUD stim??
HW.boardID2=2;% maybe use a second board for AUD stim??
if casenum==3 % only estim
    HW.Fso=10000;  % electrical stimulation sampling frequency
else
    HW.Fso=156250; % auditory stimulation sampling frequency
    HW.RX6.fso=156250;%TDT supported frequency
end

HW.Fsi=10000; % analog input for triggers etc sampling frequency

% Initialize analogoutput
if casenum==3 % only estim
    HW.ao = analogoutput('nidaq',HW.boardID2);
else
    HW.ao = analogoutput('nidaq',HW.boardID1);
end
set(HW.ao,'SampleRate',HW.Fso)
set(HW.ao,'Triggertype','HWDigital') % later change to HWDigital - with HW trigger from counter
if casenum==3 % only estim
    HW.op_ch=addchannel(HW.ao,[1]);
else
    HW.op_ch=addchannel(HW.ao,[0 1]); % 0- Left ear 1- Right ear
end

% Initialize analoginput
HW.ai = analoginput('nidaq',HW.boardID1); % second board to acquire triggers
set(HW.ai,'SampleRate',HW.Fsi)
set(HW.ai,'InputType','Differential')
set(HW.ai,'Triggertype','HWDigital') % later change to HWDigital - with HW trigger from counter
if casenum==3|casenum==4
    load frame_max_speed
    if frame_max_speed==0
        HW.ip_ch=addchannel(HW.ai,[0 1]);
    elseif frame_max_speed==1
        HW.ip_ch=addchannel(HW.ai,[3 1 5])
    end
    
elseif casenum==6
    load frame_max_speed
    if frame_max_speed==0
        HW.ip_ch=addchannel(HW.ai,[0 1 2]);
    elseif frame_max_speed==1
        HW.ip_ch=addchannel(HW.ai,[3 1 2]);
    end
elseif casenum==7|casenum==8
    HW.ip_ch=addchannel(HW.ai,[2]);
end
set(HW.ai,'SamplesPerTrigger',200*HW.Fsi)%set time based on input
set(HW.ai,'TimeOut',1000)

% Initialize digital trigger line
HW.dio=digitalio('nidaq',HW.boardID1);
addline(HW.dio,0,'Out');%digital line to trigger ai and ao - this line is connected to PFI0 (of board2) and PFI6 (of board1)
putvalue(HW.dio.Line(1),[1]);

if casenum ==3
    HW.Amplitude=5;
else
    % Initialize Attenuator
    HW.atten_handle = figure;
    HW.PA_L = actxcontrol('PA5.x',[5 5 26 26]);
    HW.PA_R = actxcontrol('PA5.x',[5 5 26 26]);
    set(HW.atten_handle,'visible','off');
    HW.PA_L.ConnectPA5('USB',1);
    HW.PA_R.ConnectPA5('USB',2);
    HW.PA_L.SetAtten(80); 
    HW.PA_R.SetAtten(80);pause(1e-3); 
    HW.Amplitude=10;
end
