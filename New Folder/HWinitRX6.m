function [HW]=HWinitRX6(casenum)

%%%%  NBRC Code for Rig 1 Plexon ephys 32 channel 16 WB and 16 spk
%%% Initialize HARDWARE
SR=20000;
load AudStimPARAMS
if AudStimPARAMS.uf_check==0
    TDTSR=156250;
elseif AudStimPARAMS.uf_check==1
    TDTSR=260416.6667;
end
HW.boardID1='dev1';% 
HW.boardID2='dev2';% Right now no second board needed on ephys rig
if casenum==3|casenum==10 % only estim 
    HW.Fso=SR; % electrical stimulation sampling frequency
elseif casenum==12|casenum==13|casenum==14|casenum==15 | casenum==17%%% Pairing or pairing time course or audio visual
    HW.Fso1=TDTSR;
    HW.RX6.fso=TDTSR;%%% Auditory
    HW.Fso=TDTSR;
    HW.Fso2=SR;%%% Estim
else
    HW.Fso=TDTSR; % auditory stimulation sampling frequency
    HW.RX6.fso=TDTSR;%TDT supported frequency
end

HW.Fsi=SR; % analog input for triggers etc sampling frequency

%%% CREATE SESSION
HW.SS=daq.createSession('ni');

% Initialize analogoutput
% if casenum==3|casenum==10 % only estim
%     HW.ao = analogoutput('nidaq',HW.boardID1);
% elseif casenum==12|casenum==13
%     %HW.ao1 = analogoutput('nidaq',HW.boardID1);
%     HW.ao2 = analogoutput('nidaq',HW.boardID2);
% else
%     %HW.ao = analogoutput('nidaq',HW.boardID1);
% end
if casenum==12|casenum==13
    %set(HW.ao1,'SampleRate',HW.Fso1)
    HW.op_ch=HW.SS.addAnalogOutputChannel(HW.boardID1,0:1,'Voltage');
    HW.SS.Rate=HW.Fso2;
    
elseif casenum==3|casenum==10
    HW.op_ch=HW.SS.addAnalogOutputChannel(HW.boardID1,1,'Voltage');
    HW.SS.Rate=HW.Fso;
elseif casenum==14
    load VisLEDStimPARAMS
    if VisLEDStimPARAMS.check_vis_only==1
        1
        HW.op_ch=HW.SS.addAnalogOutputChannel(HW.boardID1,2,'Voltage');
        HW.SS.Rate=HW.Fso2;
    elseif VisLEDStimPARAMS.check_ep==1
        2
        HW.op_ch=HW.SS.addAnalogOutputChannel(HW.boardID1,1:2,'Voltage');
        HW.SS.Rate=HW.Fso2;
    elseif VisLEDStimPARAMS.check_avp==1
        3
        HW.op_ch=HW.SS.addAnalogOutputChannel(HW.boardID1,[0 2],'Voltage');
        HW.SS.Rate=HW.Fso2;
    end
 elseif casenum==15
    load OptoParams
    if OptoParams.check_none==1 || OptoParams.check_optoSSA==1
        HW.op_ch=HW.SS.addAnalogOutputChannel(HW.boardID1,1,'Voltage');
        HW.SS.Rate=HW.Fso2;
    elseif OptoParams.check_auditory==1
        HW.op_ch=HW.SS.addAnalogOutputChannel(HW.boardID1,[0 1],'Voltage');
        HW.SS.Rate=HW.Fso2;
    elseif OptoParams.check_visual==1
        HW.op_ch=HW.SS.addAnalogOutputChannel(HW.boardID1,[2 1],'Voltage');
        HW.SS.Rate=HW.Fso2;    
    elseif OptoParams.check_all==1
        HW.op_ch=HW.SS.addAnalogOutputChannel(HW.boardID1,0:2,'Voltage');
        HW.SS.Rate=HW.Fso2;   
    end   
 elseif casenum==17
    load Femto_Behaviour_params
    if Femto_Behaviour_params.reward_only==1 
        HW.op_ch=HW.SS.addAnalogOutputChannel(HW.boardID1,1,'Voltage');
        HW.SS.Rate=HW.Fso2;
    elseif Femto_Behaviour_params.auditory_only==1
        HW.op_ch=HW.SS.addAnalogOutputChannel(HW.boardID1,[0 1],'Voltage');
        HW.SS.Rate=HW.Fso2;
    elseif Femto_Behaviour_params.visual_only==1
        HW.op_ch=HW.SS.addAnalogOutputChannel(HW.boardID1,[2 1],'Voltage');
        HW.SS.Rate=HW.Fso2;    
    elseif Femto_Behaviour_params.multisensory==1
        HW.op_ch=HW.SS.addAnalogOutputChannel(HW.boardID1,0:2,'Voltage');
        HW.SS.Rate=HW.Fso2;   
    end 
    
    
else
    HW.op_ch=HW.SS.addAnalogOutputChannel(HW.boardID1,0,'Voltage');
    HW.SS.Rate=SR;
    
end


% Initialize analoginput
if casenum==7
    load AudStimPARAMS
    if AudStimPARAMS.mult_channel==1
        HW.ip_ch=HW.SS.addAnalogInputChannel(HW.boardID1,0:31,'Voltage');
        for kk=1:32
            HW.ip_ch(kk).InputType='SingleEndedNonReferenced';
        end
%         set(HW.ai,'InputType','NonReferencedSingleEnded')
%         HW.ip_ch=addchannel(HW.ai,[0:15]);
    else
        HW.ip_ch=HW.SS.addAnalogInputChannel(HW.boardID1,0,'Voltage');
        HW.ip_ch.InputType='SingleEndedNonReferenced';
%         HW.ai = analoginput('nidaq',HW.boardID1);
%         set(HW.ai,'SampleRate',HW.Fsi)
%         set(HW.ai,'InputType','Differential')
%         HW.ip_ch=addchannel(HW.ai,[2]);
    end
elseif casenum==10|casenum==12|casenum==13
    load EstimPARAMS
    if EstimPARAMS.mult_channel==1
        HW.ip_ch=HW.SS.addAnalogInputChannel(HW.boardID1,0:31,'Voltage');
        for kk=1:32
            HW.ip_ch(kk).InputType='SingleEndedNonReferenced';%
        end
%         HW.ai = analoginput('nidaq',HW.boardID2);
%         set(HW.ai,'SampleRate',HW.Fsi)
%         set(HW.ai,'InputType','NonReferencedSingleEnded')
%         HW.ip_ch=addchannel(HW.ai,[0:15]);
    else
        HW.ip_ch=HW.SS.addAnalogInputChannel(HW.boardID1,0,'Voltage');
        HW.ip_ch.InputType='SingleEndedNonReferenced';%
%         HW.ai = analoginput('nidaq',HW.boardID1);
%         set(HW.ai,'SampleRate',HW.Fsi)
%         set(HW.ai,'InputType','Differential')
%         HW.ip_ch=addchannel(HW.ai,[2]);
    end
elseif casenum==14| casenum==15
    load VisLEDStimPARAMS
    if VisLEDStimPARAMS.check_multiple_ch==1
        HW.ip_ch=HW.SS.addAnalogInputChannel(HW.boardID1,0:31,'Voltage');
        for kk=1:32
            HW.ip_ch(kk).InputType='SingleEndedNonReferenced';
        end
        
%         set(HW.ai,'InputType','NonReferencedSingleEnded')
%         HW.ip_ch=addchannel(HW.ai,[0:15]);
    else
        HW.ip_ch=HW.SS.addAnalogInputChannel(HW.boardID1,0,'Voltage');
        HW.ip_ch.InputType='SingleEndedNonReferenced';
%         HW.ai = analoginput('nidaq',HW.boardID1);
%         set(HW.ai,'SampleRate',HW.Fsi)
%         set(HW.ai,'InputType','Differential')
%         HW.ip_ch=addchannel(HW.ai,[2]);
    end
elseif casenum==15
    load OptoParams
    
        HW.ip_ch=HW.SS.addAnalogInputChannel(HW.boardID1,0:31,'Voltage');
        for kk=1:32
            HW.ip_ch(kk).InputType='SingleEndedNonReferenced';
        end
elseif casenum==17
    load Femto_Behaviour_params
    
%         HW.ip_ch=HW.SS.addAnalogInputChannel(HW.boardID1,0:31,'Voltage');
%         for kk=1:32
%             HW.ip_ch(kk).InputType='SingleEndedNonReferenced';
%         end
%    
%     HW.ai = analoginput('nidaq',HW.boardID1); % second board to acquire triggers
%     set(HW.ai,'SampleRate',HW.Fsi)
%     set(HW.ai,'InputType','Differential')
end

% if casenum~=11
%     set(HW.ai,'Triggertype','HWDigital') % later change to HWDigital - with HW trigger from counter
%     %set(HW.ai,'HwDigitalTriggerSource','PFI0') % pwatkins - externally route ai trigger from counter
% else
%     set(HW.ai,'Triggertype','Immediate')
% end

% if casenum==3|casenum==4|casenum==12|casenum==13
%     load frame_max_speed
%     if frame_max_speed==0
%         HW.ip_ch=addchannel(HW.ai,[0 1]);
%     elseif frame_max_speed==1
%         if casenum~=12
%             HW.ip_ch=addchannel(HW.ai,[3 1 5 6 7]);
%         elseif casenum==12|casenum==13
%             HW.ip_ch=addchannel(HW.ai,[3 1 5 6 7]);
%         end
%         
%     end
%     
% elseif casenum==6
%     load frame_max_speed
%     if frame_max_speed==0
%         HW.ip_ch=addchannel(HW.ai,[0 1 2]);
%     elseif frame_max_speed==1
%         HW.ip_ch=addchannel(HW.ai,[3 1 2]);
%     end
% elseif casenum==8
%     HW.ip_ch=addchannel(HW.ai,[2]);
% end
% set(HW.ai,'SamplesPerTrigger',200*HW.Fsi)%set time based on input
% set(HW.ai,'TimeOut',1000)

% Initialize digital trigger line
% HW.dio=digitalio('nidaq',HW.boardID1);
% addline(HW.dio,0,'Out');%digital line to trigger ai and ao - this line is connected to PFI0 (of board2) and PFI6 (of board1)
% putvalue(HW.dio.Line(1),[1]);
TTLAMP=5;
if casenum ==3|casenum==10
    HW.Amplitude=TTLAMP;
else
    % Initialize Attenuator
    HW.atten_handle = figure;
    HW.PA_L = actxcontrol('PA5.x',[5 5 26 26]);
    HW.PA_R = actxcontrol('PA5.x',[5 5 26 26]);
    set(HW.atten_handle,'visible','off');
    HW.PA_L.ConnectPA5('GB',1);
    HW.PA_R.ConnectPA5('GB',2);
    HW.PA_L.SetAtten(80); 
    HW.PA_R.SetAtten(80);pause(1e-3);
    if casenum==12|casenum==13
        HW.Amplitude1=10;
        HW.Amplitude2=TTLAMP;
    else
        HW.Amplitude=10;
    end
end

%%% FOR TRIGGERING TDT RX6 ALWAYS USE A 4 ms pulse starting after 1 ms of
%%% data acquisition start or analogout start - always correct for 5 ms
%%% delay
HW.delaysamps=fix(0.005*SR);
HW.triggerpulse=TTLAMP*ones(1,fix(0.005*SR));
HW.triggerpulse(1:fix(0.001*SR))=0;
% size(HW.triggerpulse)