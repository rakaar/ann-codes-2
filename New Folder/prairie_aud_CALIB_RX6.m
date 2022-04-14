function [calfname,finished_stim]=prairie_aud_CALIB(freqs,attenuation,stimtime)

% Example Stim Structure 
% stim_structure
%         left_check: 0
%        right_check: 1
%         both_check: 0
%        frame_check: 1
%     linescan_check: 0
%               type: 'TonePipSweep'
%      stim_protocol: [1x1 struct]
%       protocol_str: [1x134 char]
% 
% stim_structure.stim_protocol for TonePipSweep
%              frame_dur: 0.2000     %General Always present
%     total_frames_lines: 25         %General Always present
%             stim_start: 11         %General Always present
%                pip_dur: 0.1250
%                ipi_val: 0.2500
%                freq_lo: 10000
%                freq_hi: 40000
%         num_freq_steps: 9
%               level_lo: 30
%               level_hi: 10
%          num_att_steps: 3
%        npips_per_train: 4
%             total_reps: 5

global RX6_gPL

%%% Calibration PARAMETRS

CALPARAMS.atten=attenuation;
CALPARAMS.freq_lo=freqs(1);%%% start freq in Hz
CALPARAMS.freq_hi=freqs(2);%%% stop freq in Hz
CALPARAMS.freq_steps=freqs(3);%%% freq steps in octaves
CALPARAMS.stim_dur=stimtime(1);
CALPARAMS.stim_start=stimtime(2);
CALPARAMS.total_time=stimtime(3);
CALPARAMS.Fss=156250;TDTSR=CALPARAMS.Fss;
CALPARAMS.Fsi=200000;SR=CALPARAMS.Fsi;

%[HW]=HWinitRX6(wtd_val);% Hardware initialized
SR=CALPARAMS.Fsi;%200000;TDTSR=CALPARAMS.Fss;%156250;
HW.boardID1='dev1';%
HW.Fso=TDTSR; % auditory stimulation sampling frequency
HW.RX6.fso=TDTSR;%TDT supported frequency
HW.Fsi=SR; % analog input for triggers etc sampling frequency12

HW.SS=daq.createSession('ni');
HW.op_ch=HW.SS.addAnalogOutputChannel(HW.boardID1,0,'Voltage');
HW.SS.Rate=SR;
HW.ip_ch=HW.SS.addAnalogInputChannel(HW.boardID1,0,'Voltage');
HW.ip_ch.InputType='SingleEndedNonReferenced';

TTLAMP=5;
% Initialize Attenuator
HW.atten_handle = figure;
HW.PA_L = actxcontrol('PA5.x',[5 5 26 26]);
HW.PA_R = actxcontrol('PA5.x',[5 5 26 26]);
set(HW.atten_handle,'visible','off');
HW.PA_L.ConnectPA5('GB',1);
HW.PA_R.ConnectPA5('GB',2);
HW.PA_L.SetAtten(80); 
HW.PA_R.SetAtten(80);pause(1e-3);
HW.Amplitude=1;%%% CHANGED FROM 10 to 1 FOR ADARSH CALIBRATION 01072016

HW.delaysamps=fix(0.005*SR);
HW.triggerpulse=TTLAMP*ones(1,fix(0.005*SR));
HW.triggerpulse(1:fix(0.001*SR))=0;

%Generate stimuli %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nfreqs=fix(log2(freqs(2)/freqs(1))/freqs(3))+1;
STIMS.lines_per_set=nfreqs;
STIMS.rep_sets=1;
t=[0:1/CALPARAMS.Fss:(CALPARAMS.stim_dur-1/CALPARAMS.Fss)];
STIMS.allfreqs=freqs(1)*(2.^[0:freqs(3):(nfreqs-1)*freqs(3)]);

for line_num=1:nfreqs
    om=2*pi*STIMS.allfreqs(line_num);
    y=sin(om*t);
    eval(sprintf('STIMS.waveform.line%i=y'';',line_num))
end
STIMS.ATTENS.Right(1:STIMS.lines_per_set)=CALPARAMS.atten;
STIMS.ATTENS.Left=[];

%eval(sprintf('[STIMS]=File_%s_Generate(stim_structure,HW);',stim_structure.type))
current_string='Stimulus Ready';
STIMS.hard=1;
save STIMS STIMS
%set(PP_handles.disp_status,'String',current_string)
%% GENERAL parameters in STIMS
% STIMS.lines_per_set
% STIMS.rep_sets
% STIMS.ATTENS.Left
% STIMS.ATTENS.Right
% STIMS.hard=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Image Params %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%% IMAGE
% PARAMS ARE REDUNDANT IN THIS CASE tfcount and trig_frame are changed to
% total duration of each stimulus presentation (including) preceding and 
% following silence periods

%IMG.frames_lines_per_iter=stim_structure.stim_protocol.total_frames_lines; 
tfcount=CALPARAMS.total_time;
IMG.trig_frames_lines=CALPARAMS.stim_start; 
trig_frame=IMG.trig_frames_lines;
IMG.total_iters=STIMS.lines_per_set*STIMS.rep_sets;
t_iters=IMG.total_iters;
%fdurs=stim_structure.stim_protocol.frame_dur;
%fdursamp=fdurs*HW.Fso;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
total_line_duration=tfcount;
stim_start=trig_frame;
stim_start_samp=stim_start*HW.Fso;
finished_stim=0;

%%%% for COUNTER
%param = loadNI;
%fcount=[trig_frame 1000000];
HW.triggerpulse=[HW.triggerpulse zeros(1,fix(total_line_duration*HW.Fsi)+100)]';

for iter=1:t_iters
    line_num=rem(iter,STIMS.lines_per_set);rep_num=floor(iter/STIMS.lines_per_set)+1;
    if line_num==0
        line_num=STIMS.lines_per_set;
        rep_num=rep_num-1;
    end
    %oddc=rem(rep_num,2);
    
    %%% Display
    fprintf('\n%6.2f kHz,Frequency Number %i of Total %i Frequencies',STIMS.allfreqs(iter)/1000,iter,t_iters)
    %eval(sprintf('current_string=''Now at Iter %i of %i, Rep %i of %i, Line %i of Set of %i Lines!'';',iter,t_iters,rep_num,STIMS.rep_sets,line_num,STIMS.lines_per_set))
    %set(PP_handles.disp_status,'String',current_string)
    %%%%%%%%%%%% SET ATTENUATION %%%%%%%%%%%%%%%%%
    HW.PA_R.SetAtten(STIMS.ATTENS.Right(line_num));
    HW.PA_L.SetAtten(120);pause(.001);
    
    if STIMS.hard==1
        eval(sprintf('stimulus=STIMS.waveform.line%i;',line_num)) %%%%%%%% Currently written as same stimulus in both ears (if both)
%         stimulus=stimulus*HW.Amplitude;
        stimulus=[zeros(fix(stim_start_samp),1); stimulus*HW.Amplitude];
        stimulus=[zeros(size(stimulus)) stimulus];
        
    else
        %%%WRITE CODE%%%% For hard parameter= 0 and -1
    end
    
    %save stimulus stimulus

    started=0;
    load interrupt_aud
    if interrupt_aud==0
        %stop([HW.ai])
        %putdata(HW.ao,stimulus)
        %putvalue(HW.dio.Line(1),[1]);
        %set(HW.ai,'SamplesPerTrigger',fix(total_line_duration*HW.Fsi)+100)
        %size(zeros(1,fix(total_line_duration*HW.Fsi)+100))
        HW.SS.queueOutputData(HW.triggerpulse)
        trigPlay_2CH_NBRC(stimulus(:,1)',stimulus(:,2)',HW.RX6.fso)
        %start([HW.ai])
        %start([HW.ao HW.ai])
    else
        %set(PP_handles.disp_status,'String','Interrupted Auditory Stimulation')
        interrupt_aud=0;
        save interrupt_aud interrupt_aud
        daqreset
        if exist('trig_inputs')
            save trig_inputs trig_inputs
        else
            trig_inputs=[];
            save trig_inputs trig_inputs
        end
        finished_stim=-1;
        close(HW.atten_handle)
        RX6_gPL.SetTagVal('Enable',0); RX6_gPL.Halt;
        return
    end 
    
    %%%%%%%%%%%%%% PLAYING STIMULUS %%%%%%%%%%%%%%%%%% 
    %%%%%%%%%%%%%% STARTING ACQUISITION %%%%%%%%%%%%%%
    %eval(sprintf('current_string=''Started Stimulus (ITER # %i ...) '';',iter))
    %set(PP_handles.disp_status,'String',current_string)
    started=1;
    pause(0.002)
    eval(sprintf('trig_inputs.iter%i=HW.SS.startForeground;',iter))
    pause(0.01)
    %putvalue(HW.dio.Line(1),[0]);
    %putvalue(HW.dio.Line(1),[1]); % reset trigger line
    %%%%%%%%%%%%%% ENDING LINE %%%%%%%%%%%%%%%%%% 
    %%%%%%%%%%%%%% STOP ACQUISITION %%%%%%%%%%%%%
    while HW.SS.IsRunning
        1000000+1000000;
    end
%    waittilstop([HW.ai],100)    
    %eval(sprintf('current_string=''DONE (ITER # %i ...) '';',iter))
    pause(.002)
    %eval(sprintf('trig_inputs.iter%i=getdata(HW.ai,HW.ai.SamplesAcquired);',iter))
    %set(PP_handles.disp_status,'String',current_string)
end
    
finished_stim=1;
trig_inputs.Fsi=HW.Fsi;
dt=date;
clk=clock;
cd C:\EXPERIMENTS\DATA\CALIBRATION
eval(sprintf('save CALIBDATA_file_%s_%i_%i_%i_%idBATTEN trig_inputs CALPARAMS',dt,clk(4),clk(5),fix(clk(6)),attenuation))
eval(sprintf('calfname=''CALIBDATA_file_%s_%i_%i_%i_%idBATTEN'';',dt,clk(4),clk(5),fix(clk(6)),attenuation))
cd C:\EXPERIMENTS\CODES
STIMS=rmfield(STIMS,'waveform');
%AUD_IMG_STIM.IMG=IMG;
%AUD_IMG_STIM.STIMS=STIMS;
%AUD_IMG_STIM.HW=HW;
%save AUD_IMG_STIM AUD_IMG_STIM
HW.PA_L.SetAtten(80);
HW.PA_R.SetAtten(80);pause(.01); 
close(HW.atten_handle);
HW.SS.release();
daqreset
RX6_gPL.SetTagVal('Enable',0); RX6_gPL.Halt;
clear HW