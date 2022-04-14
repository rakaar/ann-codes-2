function setdaqout0

daqreset
wf=zeros(1,10000);
HW.SS=daq.createSession('ni');
HW.op_ch=HW.SS.addAnalogOutputChannel('dev1',0:3,'Voltage');
HW.SS.Rate=10000;
HW.SS.queueOutputData([wf' wf' wf' wf'])
HW.SS.startForeground
clear SS
daqreset