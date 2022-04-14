function [finished_stim,OptoParams]=prairie_OptoAud_struct(OptoParams,PP_handles)

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

wtd_val=get(PP_handles.what_to_do,'Value');
[HW]=HWinitRX6(wtd_val);% Hardware initialized
stim_structureAUD=OptoParams.AUD;

%Generate stimuli %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eval(sprintf('[STIMS,stim_structureAUD]=File_%s_Generate(stim_structureAUD,HW);',stim_structureAUD.type))
current_string='Stimulus Ready';
%save STIMS STIMS
set(PP_handles.disp_status,'String',current_string)
%% GENERAL parameters in STIMS
% STIMS.lines_per_set
% STIMS.rep_sets
% STIMS.ATTENS.Left
% STIMS.ATTENS.Right
% STIMS.hard=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% CHANGED ATTENUATION SETTING FROM BEFORE ON 22/5/2015
%%% SET ATTENUATION OF FIRST LINE IN THE BEGINNING BEFORE GOING INTO ITER
%%% LOOP. THEN ATTENUATION FOR NEXT LINE IS SET IMMEDIATELY AFTER DATA
%%% COLLECITON OF CURRENT LINE TO AVOID TDT CLICK IMMEDIATELY PRECEDING
%%% DATA COLLECTION. SHARBA
%%%%%%%%%%%% SET ATTENUATION FOR FIRST LINE %%%%%%%%%%%%%%%%%
if stim_structureAUD.left_check==1
    
    HW.PA_L.SetAtten(STIMS.ATTENS.Left(1));
    HW.PA_R.SetAtten(120);pause(.001);
elseif stim_structureAUD.right_check==1
    HW.PA_L.SetAtten(120);
    HW.PA_R.SetAtten(STIMS.ATTENS.Right(1));pause(.001);
elseif stim_structureAUD.both_check==1
    HW.PA_L.SetAtten(STIMS.ATTENS.Left(1));
    HW.PA_R.SetAtten(STIMS.ATTENS.Right(1));pause(.001);
end
pause(1)

% Image Params %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%% IMAGE
% PARAMS ARE REDUNDANT IN THIS CASE tfcount and trig_frame are changed to
% total duration of each stimulus presentation (including) preceding and 
% following silence periods

IMG.frames_lines_per_iter=stim_structureAUD.stim_protocol.total_frames_lines; 
tfcount=IMG.frames_lines_per_iter;
IMG.trig_frames_lines=stim_structureAUD.stim_protocol.stim_start; 
trig_frame=IMG.trig_frames_lines;
IMG.total_iters=STIMS.lines_per_set*STIMS.rep_sets;
t_iters=IMG.total_iters;
fdurs=0.2;%stim_structureAUD.stim_protocol.frame_dur;
fdursamp=fdurs*HW.Fso;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
total_line_duration=stim_structureAUD.stim_protocol.total_frames_lines;
stim_start=stim_structureAUD.stim_protocol.stim_start;
stim_start_samp=stim_start*HW.Fso;
use_gap=stim_structureAUD.stim_gap_check;
gap_time=stim_structureAUD.stim_gap_val;
finished_stim=0;

%%%% for COUNTER
%param = loadNI;
%fcount=[trig_frame 1000000];
HW.triggerpulse=[HW.triggerpulse zeros(1,fix(total_line_duration*HW.Fsi)+100)]';


%%%%%%%%%%%%%%%%%%%%%%% CREATING Opto Stimulus %%%%%%%%%%%%%%%

stim_structureOpto=OptoParams;

%%% first check total iter t_iters in the 2 cases
total_time=stim_structureOpto.total_time;
totsamps=fix(total_time*HW.Fso2)+100;
%%% Matching total length
if totsamps<length(HW.triggerpulse)
    totsamps=length(HW.triggerpulse);
elseif totsamps>length(HW.triggerpulse)
    HW.triggerpulse=[HW.triggerpulse' zeros(1,totsamps-length(HW.triggerpulse))]';
end

start_time=stim_structureOpto.stim_start;
start_samp=fix(start_time*HW.Fso2)+1;
pulsewf=zeros(1,totsamps);
max_stim_samps=length(pulsewf)-start_samp+1;

nsteps=1;
ints=stim_structureOpto.curr_amp;

intsf=ints;
nreps=stim_structureOpto.n_reps;
allintsO=repmat(intsf,1,nreps);
t_iters=nsteps*nreps;
%%%%%%%%%%%%%%%modulatory square wave 1khz 82% duty cycle for 598nm(Arch)%%%%%%%%
  if OptoParams.check589nm==1
    modulate_time=0:1/HW.Fso2:(stim_structureOpto.stim_dur);
modulate_wav=square(2*pi*1000*modulate_time,82);%82% duty cycle 1khz square waveform
    one_blinkO=[modulate_wav  zeros(1,fix(stim_structureOpto.isi_dur*HW.Fso2))];
    else
       one_blinkO=[ones(1,fix(stim_structureOpto.stim_dur*HW.Fso2))  zeros(1,fix(stim_structureOpto.isi_dur*HW.Fso2))];
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



allstimsO=repmat(one_blinkO,1,stim_structureOpto.n_stims);

stimulusO=allstimsO;
current_string='Opto Stimulus Also Ready';
set(PP_handles.disp_status,'String',current_string)
pause(0.5)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for iter=1:t_iters
    line_num=rem(iter,STIMS.lines_per_set);rep_num=floor(iter/STIMS.lines_per_set)+1;
    if line_num==0
        line_num=STIMS.lines_per_set;
        rep_num=rep_num-1;
    end
    %oddc=rem(rep_num,2);
    
    %%% Display
    eval(sprintf('current_string=''Now at Iter %i of %i, Rep %i of %i, Line %i of Set of %i Lines!'';',iter,t_iters,rep_num,STIMS.rep_sets,line_num,STIMS.lines_per_set))
    set(PP_handles.disp_status,'String',current_string)
    
    if STIMS.hard==1
        eval(sprintf('stimulusA=STIMS.waveform.line%i;',line_num)) %%%%%%%% Currently written as same stimulus in both ears (if both)
%         stimulus=stimulus*HW.Amplitude;
        stimulusA=[zeros(fix(stim_start_samp),1); stimulusA*HW.Amplitude];
        if stim_structureAUD.left_check==1
            stimulusA=[stimulusA zeros(size(stimulusA))];
        elseif stim_structureAUD.right_check==1
            stimulusA=[zeros(size(stimulusA)) stimulusA];
        elseif stim_structureAUD.both_check==1
            stimulusA=[stimulusA stimulusA];
        end
    else
        %%%WRITE CODE%%%% For hard parameter= 0 and -1
    end
    
    %save stimulus stimulus

    started=0;
    load interrupt_aud
    if interrupt_aud==0 | interrupt_opto==0
        %stop([HW.ai])
        %putdata(HW.ao,stimulus)
        %putvalue(HW.dio.Line(1),[1]);
        %set(HW.ai,'SamplesPerTrigger',fix(total_line_duration*HW.Fsi)+100)
        %size(zeros(1,fix(total_line_duration*HW.Fsi)+100))
        
        stimuO=stimulusO;
        stimuO(find(stimulusO~=0))=stimulusO(find(stimulusO~=0))*allintsO(iter);
        STIMULUSO=[zeros(start_samp,1);stimuO'];
        
        figure(100);clf
        plot((1:length(stimulusA))/HW.Fso,stimulusA(:,2),'b')
        hold on
        plot((1:length(STIMULUSO))/HW.Fso2,STIMULUSO,'r')
        
        zeroslen2=zeros(1,totsamps)';
        zeroslen2(1:length(STIMULUSO))=STIMULUSO;
        
        HW.SS.queueOutputData([HW.triggerpulse zeroslen2])
%         figure(100);clf
%         plot(0.005+[1:length(stimulusA)]/HW.RX6.fso,stimulusA(:,2)')
%         hold on
%         plot([1:length(HW.triggerpulse)]/HW.SS.Rate,HW.triggerpulse','r')
        drawnow
        if stim_structureAUD.uf_check==0
            trigPlay_2CH_NBRC(stimulusA(:,1)',stimulusA(:,2)',HW.RX6.fso)
        elseif stim_structureAUD.uf_check==1
            trigPlay_2CH_NBRC_UF(stimulusA(:,1)',stimulusA(:,2)',HW.RX6.fso)
        end
        %start([HW.ai])
        %start([HW.ao HW.ai])
    else
        set(PP_handles.disp_status,'String','Interrupted opto Stimulation')
        interrupt_aud=0;interrupt_opto=0;
        save interrupt_aud interrupt_aud
        save interrupt_opto interrupt_opto
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
    eval(sprintf('current_string=''Started Stimulus (ITER # %i ...) '';',iter))
    set(PP_handles.disp_status,'String',current_string)
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
    %%%%%%%%%%%% SET ATTENUATION FOR NEXT LINE %%%%%%%%%%%%%%%%%
    nextline=rem(line_num+1,STIMS.lines_per_set);
    if nextline==0
        nextline=STIMS.lines_per_set;
    end
    if stim_structureAUD.left_check==1
        if STIMS.ATTENS.Left(line_num)~=STIMS.ATTENS.Left(nextline)
            HW.PA_L.SetAtten(STIMS.ATTENS.Left(nextline));
            %HW.PA_R.SetAtten(120);
            pause(.001);
        end
    elseif stim_structureAUD.right_check==1
        if STIMS.ATTENS.Right(line_num)~=STIMS.ATTENS.Right(nextline)
            %HW.PA_L.SetAtten(120);
            HW.PA_R.SetAtten(STIMS.ATTENS.Right(nextline));
            pause(.001);
        end
    elseif stim_structureAUD.both_check==1
        if STIMS.ATTENS.Left(line_num)~=STIMS.ATTENS.Left(nextline)
            HW.PA_L.SetAtten(STIMS.ATTENS.Left(nextline));
        end
        if STIMS.ATTENS.Right(line_num)~=STIMS.ATTENS.Right(nextline)
            HW.PA_R.SetAtten(STIMS.ATTENS.Right(nextline));pause(.001);
        end
    end
%    waittilstop([HW.ai],100)    
    eval(sprintf('current_string=''DONE (ITER # %i ...) '';',iter))
    pause(.002)
    %eval(sprintf('trig_inputs.iter%i=getdata(HW.ai,HW.ai.SamplesAcquired);',iter))
    set(PP_handles.disp_status,'String',current_string)
    if use_gap&iter~=t_iters
        eval(sprintf('current_string=''DONE (ITER # %i ...); Waiting for ... %5.2f seconds '';',iter,gap_time))
        set(PP_handles.disp_status,'String',current_string)
        pause(gap_time)
    end
end
    
finished_stim=1;
trig_inputs.Fsi=HW.Fsi;
save trig_inputs trig_inputs %change in 
STIMS=rmfield(STIMS,'waveform');
AUD_IMG_STIM.IMG=IMG;
AUD_IMG_STIM.STIMS=STIMS;
%AUD_IMG_STIM.HW=HW;
save AUD_IMG_STIM AUD_IMG_STIM
HW.PA_L.SetAtten(80);
HW.PA_R.SetAtten(80);pause(.01); 
close(HW.atten_handle)
HW.SS.release();
daqreset
RX6_gPL.SetTagVal('Enable',0); RX6_gPL.Halt;
clear HW