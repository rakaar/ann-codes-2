function d=HARDWARETEST

daqreset
Fsi=10000;
ao=analogoutput('nidaq',2);
ai=analoginput('nidaq',2);
set(ai,'SampleRate',Fsi)
set(ai,'InputType','SingleEnded')
set(ai,'Triggertype','HWDigital') % later change to HWDigital - with HW trigger from counter
ip_ch=addchannel(ai,[0 1]);
set(ai,'Samplespertrigger',100*Fsi)

dio=digitalio('nidaq',1);
addline(dio,0,'Out');
putvalue(dio.Line(1),[1]);

start(ai)
sprintf('Press any key to start acquisiton of frame and line triggers (START PRAIRIE T-Series) ...')
pause
pause(1)
putvalue(dio.Line(1),[0]);
pause(.02)
putvalue(dio.Line(1),[1]);
pause(10)
stop(ai)
stop(ai)
d=getdata(ai,ai.SamplesAcquired);
daqreset