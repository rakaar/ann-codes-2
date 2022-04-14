SR=20000;TDTSR=156250;
HW.boardID1='dev1';%
HW.Fso=TDTSR; % auditory stimulation sampling frequency
HW.RX6.fso=TDTSR;%TDT supported frequency
HW.Fsi=SR;
TTLAMP=5;
fdur=0.110533;
triggerframe=6;
triggerdur=1;
timetotrig=0.9;
totalframes=10;
stimdur=15;
fc=6000;

stimstartNI=triggerdur+(triggerframe-1)*fdur;
stimstartTDT=(triggerframe-1)*fdur;
totaltimetriggerpulse=triggerdur+(totalframes+2)*fdur;
totaltimeTDT=(totalframes-2)*fdur;
triggerpulse=zeros(1,fix(totaltimetriggerpulse*SR));
triggerpulse(1:fix(triggerdur*SR))=TTLAMP*ones(1,fix(triggerdur*SR));
triggerpulse(1:fix(timetotrig*SR))=TTLAMP*zeros(1,fix(timetotrig*SR));
%wfNI=zeros(1,length(triggerpulse));
%soundstimNI=10*sin(2*pi*fc*[0:1/SR:(stimdur-1/SR)]);
%wfNI(fix(stimstartNI*SR)+1:fix(stimstartNI*SR)+length(soundstimNI))=soundstimNI;
% if length(wfNI)>length(triggerpulse)
%     triggerpulsen=zeros(1,length(wfNI));
%     triggerpulsen(1:length(triggerpulse))=triggerpulse;
%     triggerpulse=triggerpulsen;
%     clear triggerpulsen
% end
wfTDT=zeros(1,fix(totaltimeTDT*TDTSR));
stimwf=10*sin(2*pi*fc*[0:1/TDTSR:(stimdur-1/TDTSR)]);
wfTDT(fix(stimstartTDT*TDTSR)+1:fix(stimstartTDT*TDTSR)+length(stimwf))=stimwf;

HW.SS=daq.createSession('ni');
HW.op_ch=HW.SS.addAnalogOutputChannel(HW.boardID1,0,'Voltage');
HW.SS.Rate=SR;
HW.triggerpulse=triggerpulse;

for kk=1:2
    %HW.SS.queueOutputData([HW.triggerpulse'])
    %HW.SS.startBackground
    TwoCh_Continuous_Play_Trig_RX6_t2(wfTDT, wfTDT,HW)
    pause(2)
end
HW.SS.release();
clear SS
daqreset



