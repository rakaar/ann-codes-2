function calib_data=Calibration_withPA5(attenval)

tic
N=29;
fl=6000;fh=6000*2^(3.5);T=.8;pause_T=0.2;

freqs=logspace(log10(fl),log10(fh),N);

daqreset
HW.boardID1=1; % number of the NI board % maybe use a second board for AUD stim??
HW.Fso=160000; % auditory stimulation sampling frequency
HW.Fsi=160000; % analog input for triggers etc sampling frequency

HW.ao = analogoutput('nidaq',HW.boardID1);
set(HW.ao,'SampleRate',HW.Fso)
set(HW.ao,'Triggertype','HWDigital') % later change to HWDigital - with HW trigger from counter
HW.op_ch=addchannel(HW.ao,[0 1]); % 0- Left ear 1- Right ear

HW.ai = analoginput('nidaq',HW.boardID1); % second board to acquire triggers
set(HW.ai,'SampleRate',HW.Fsi)
set(HW.ai,'InputType','Differential')
set(HW.ai,'Triggertype','HWDigital') % later change to HWDigital - with HW trigger from counter
HW.ip_ch=addchannel(HW.ai,[4]);
set(HW.ai,'SamplesPerTrigger',2*HW.Fsi)%set time based on input
set(HW.ai,'TimeOut',1000)

HW.dio=digitalio('nidaq',HW.boardID1);
addline(HW.dio,0,'Out');%digital line to trigger ai and ao - this line is connected to PFI0 (of board2) and PFI6 (of board1)
putvalue(HW.dio.Line(1),[1]);

HW.atten_handle = figure;
HW.PA_L = actxcontrol('PA5.x',[5 5 26 26]);
HW.PA_R = actxcontrol('PA5.x',[5 5 26 26]);
set(HW.atten_handle,'visible','off');
HW.PA_L.ConnectPA5('USB',1);
HW.PA_R.ConnectPA5('USB',2);
HW.PA_L.SetAtten(80); 
HW.PA_R.SetAtten(80);pause(1e-3); 
HW.Amplitude=10;

ts=[0:1/HW.Fso:(T-1/HW.Fso)];P_samp=pause_T*HW.Fso;
for fn=1:N
    fprintf('Now at %i\n',fn)
    yy=sin(2*pi*freqs(fn)*ts);
    yy=yy*HW.Amplitude;yy=[zeros(1,P_samp) yy zeros(size(yy)) zeros(1,P_samp)];
    putdata(HW.ao,[yy' yy'])
    start([HW.ai HW.ao])
    putvalue(HW.dio.Line(1),[0]);
    pause(.05)
    putvalue(HW.dio.Line(1),[1]);
    if attenval(2)==-1
        HW.PA_R.SetAtten(120);
        HW.PA_L.SetAtten(attenval(1));pause(.001)
    elseif attenval(2)==1
        HW.PA_L.SetAtten(120);
        HW.PA_R.SetAtten(attenval(1));pause(.001)
    end
    waittilstop(HW.ao,5);
    HW.PA_L.SetAtten(80);
    HW.PA_R.SetAtten(80);pause(.01); 
    stop(HW.ai);
    eval(sprintf('calib_data.freq%i=getdata(HW.ai,HW.ai.SamplesAcquired);',fn))
    pause(.01)
end
close(HW.atten_handle)
toc

    