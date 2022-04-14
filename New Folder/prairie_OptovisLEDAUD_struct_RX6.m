function [finished_stim,OptoParams]=prairie_OptovisLEDAUD_struct_RX6(OptoParams,PP_handles)


% VISUAL STRUCTURE
% OptoParams.VIS =
%
%            check_led1: 1
%            check_led2: 0
%            check_vssa: 0
%            total_time: 2
%            stim_start: 0.5000
%             start_int: 5
%              stop_int: 5
%         num_int_steps: 1
%             blink_dur: 0.5000
%       inter_blink_int: 0.2000
%              n_blinks: 1
%        check_vis_only: 1
%              check_ep: 0
%             check_avp: 0
%         ssa_intensity: 5
%      check_LED1_stimB: 0
%      check_LED2_stimB: 1
%             stimB_pos: 8
%           randB_check: 0
%      check_horver_led: 0
%       check_single_ch: 0
%     check_multiple_ch: 1
%             check_gap: 0
%               gap_dur: 3
%          num_reps_set: 20
%                  ELEC: EStimPARAMS
%                   AUD: AudStimPARAMS
% AUDITORY STRUCTURE
% OptoParams.AUD
%         left_check: 0
%        right_check: 1
%         both_check: 0
%        frame_check: 1
%     linescan_check: 0
%               type: 'TonePipSweep'
%      stim_protocol: [1x1 struct]
%       protocol_str: [1x134 char]
%
% stim_structureAUD.stim_protocol for TonePipSweep
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
% OPTO STRUCTURE
%       check_auditory
%       check_visual
%       check_all
%       check_none
%       check_optoSSA
%       check_standard
%       check_deviant
%       stimB_pos
%       stimA_dur
%       stimB_dur
%       total_time
%       stim_start
%       curr_amp
%       stim_dur
%       isi_dur
%       n_stims
%       n_reps
%       gapcheck
%       gap_dur
%       AUD
%       VIS
%       protocol_str

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global RX6_gPL

wtd_val=get(PP_handles.what_to_do,'Value');
[HW]=HWinitRX6(wtd_val);% Hardware initialized
stim_structureAUD=OptoParams.AUD;

%Generate stimuli %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eval(sprintf('[STIMS,stim_structureAUD]=File_%s_Generate(stim_structureAUD,HW);',stim_structureAUD.type))
current_string='Auditory Stimulus Ready';
pause(0.5)
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
fdurs=stim_structureAUD.stim_protocol.frame_dur;
fdursamp=fdurs*HW.Fso2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
total_line_duration=stim_structureAUD.stim_protocol.total_frames_lines;




stim_start=stim_structureAUD.stim_protocol.stim_start;
%%%%%%%% CORRECTED FOR 5 ms TRIGGER PULSE
stim_start_samp=fix((stim_start-.005)*HW.RX6.fso);%%% for padding auditory stimulus
use_gap=stim_structureAUD.stim_gap_check;
gap_time=stim_structureAUD.stim_gap_val;
finished_stim=0;

%%%% for COUNTER
%param = loadNI;
%fcount=[trig_frame 1000000];
HW.triggerpulse=[HW.triggerpulse zeros(1,fix(total_line_duration*HW.Fsi)+100)]';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CREATING VISUAL STIM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stim_structureVIS=OptoParams.VIS;
%%% first check total iter t_iters in the 2 cases
total_time=stim_structureVIS.total_time;
totsamps=fix(total_time*HW.Fso2)+100;
%%% Matching total length
if totsamps<length(HW.triggerpulse)
    
    totsamps=length(HW.triggerpulse);
elseif totsamps>length(HW.triggerpulse)
    
    HW.triggerpulse=[HW.triggerpulse' zeros(1,totsamps-length(HW.triggerpulse))]';
end

start_time=stim_structureVIS.stim_start;
start_samp=fix(start_time*HW.Fso2)+1;
pulsewf=zeros(1,totsamps);
max_stim_samps=length(pulsewf)-start_samp+1;
if stim_structureVIS.check_vssa==0
    nsteps=stim_structureVIS.num_int_steps;
    ints=linspace(stim_structureVIS.start_int,stim_structureVIS.stop_int,nsteps);
else
    nsteps=1;
    ints=stim_structureVIS.ssa_intensity;
end
intsf=ints;%%% Put in a factor: to be decided based on calibration and log scale etc (SUDHA needs to get V1 data)
nreps=stim_structureVIS.num_reps_set;
allints=repmat(intsf,1,nreps);
t_iters=nsteps*nreps;
%%%%%% [0 0 1]
if stim_structureVIS.check_led1==1
    one_blink=[ones(1,fix(stim_structureVIS.blink_dur*HW.Fso2)) zeros(1,fix(stim_structureVIS.inter_blink_int*HW.Fso2))];
    thrsd=0;
elseif stim_structureVIS.check_led2==1
    one_blink=[-ones(1,fix(stim_structureVIS.blink_dur*HW.Fso2)) zeros(1,fix(stim_structureVIS.inter_blink_int*HW.Fso2))];
    thrsd=-0;
elseif stim_structureVIS.check_vssa==1
    if stim_structureVIS.check_LED2_stimB==1
        one_blink=[ones(1,fix(stim_structureVIS.blink_dur*HW.Fso2)) zeros(1,fix(stim_structureVIS.inter_blink_int*HW.Fso2))];
    elseif stim_structureVIS.check_LED1_stimB==1
        one_blink=[-ones(1,fix(stim_structureVIS.blink_dur*HW.Fso2)) zeros(1,fix(stim_structureVIS.inter_blink_int*HW.Fso2))];
    end
end
allstims=repmat(one_blink,1,stim_structureVIS.n_blinks);

if stim_structureVIS.check_vssa==1
    ndev=stim_structureVIS.num_stimB;
    devpo=stim_structureVIS.stimB_pos;
    for devpos=devpo:devpo+ndev-1
        allstims(((devpos-1)*length(one_blink)+1):devpos*length(one_blink))=-allstims(((devpos-1)*length(one_blink)+1):devpos*length(one_blink));
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
stimulusV=allstims;
current_string='Visual Stimulus Also Ready';
set(PP_handles.disp_status,'String',current_string)
pause(0.5)


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
% if stim_structureOpto.check_optossa==0
%     nsteps=stim_structureOpto.num_int_steps;
%     ints=linspace(stim_structureVIS.start_int,stim_structureVIS.stop_int,nsteps);
% else
%     nsteps=1;
%     ints=stim_structureVIS.ssa_intensity;
% end
intsf=ints;
nreps=stim_structureOpto.n_reps;
allintsO=repmat(intsf,1,nreps);
t_iters=nsteps*nreps;
%%%%%% [0 0 1]
% if stim_structureVIS.check_led1==1
%     one_blink=[ones(1,fix(stim_structureVIS.blink_dur*HW.Fso2)) zeros(1,fix(stim_structureVIS.inter_blink_int*HW.Fso2))];
%     thrsd=0;
% elseif stim_structureVIS.check_led2==1
%     one_blink=[-ones(1,fix(stim_structureVIS.blink_dur*HW.Fso2)) zeros(1,fix(stim_structureVIS.inter_blink_int*HW.Fso2))];
%     thrsd=-0;
% elseif stim_structureVIS.check_vssa==1
%     if stim_structureVIS.check_LED2_stimB==1
%         one_blink=[ones(1,fix(stim_structureVIS.blink_dur*HW.Fso2)) zeros(1,fix(stim_structureVIS.inter_blink_int*HW.Fso2))];
%     elseif stim_structureVIS.check_LED1_stimB==1
%         one_blink=[-ones(1,fix(stim_structureVIS.blink_dur*HW.Fso2)) zeros(1,fix(stim_structureVIS.inter_blink_int*HW.Fso2))];
%     end
% end
one_blinkO=[ones(1,fix(stim_structureOpto.stim_dur*HW.Fso2)) zeros(1,fix(stim_structureOpto.isi_dur*HW.Fso2))];

allstimsO=repmat(one_blinkO,1,stim_structureOpto.n_stims);

% if stim_structureVIS.check_vssa==1
%     ndev=stim_structureVIS.num_stimB;
%     devpo=stim_structureVIS.stimB_pos;
%     for devpos=devpo:devpo+ndev-1
%         allstims(((devpos-1)*length(one_blink)+1):devpos*length(one_blink))=-allstims(((devpos-1)*length(one_blink)+1):devpos*length(one_blink));
%     end
% end

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
    zeroslen=zeros(1,totsamps)';
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
    load interrupt_vis
    load interrupt_opto
    if interrupt_aud==0|interrupt_vis==0| interrupt_opto==0
        stimu=stimulusV;
        stimu(find(stimulusV~=0))=stimulusV(find(stimulusV~=0))*allints(iter);
        STIMULUS=[zeros(start_samp,1);stimu'];
        
        stimuO=stimulusO;
        stimuO(find(stimulusO~=0))=stimulusO(find(stimulusO~=0))*allintsO(iter);
        STIMULUSO=[zeros(start_samp,1);stimuO'];
        
        
        figure(100);clf
        plot((1:length(stimulusA))/HW.Fso,stimulusA(:,2),'b')
        hold on
        plot((1:length(STIMULUS))/HW.Fso2,STIMULUS,'g')
        hold on
        plot((1:length(STIMULUSO))/HW.Fso2,STIMULUSO,'r')
        
        
        if totsamps<length([zeros(start_samp,1);stimu'])
            %%% add default 1000 ms to stimulus duration with starting time
            extrasamps=fix(HW.Fso2);
            totsamps=length([zeros(start_samp,1);stimu'])+extrasamps;
            zeroslen=zeros(1,totsamps)';
            %             size(HW.triggerpulse)
            %             size(zeros(1,totsamps-length(HW.triggerpulse)))
            HW.triggerpulse=[HW.triggerpulse;zeros(1,totsamps-length(HW.triggerpulse))'];
            
%             figure(100);clf
%             plot(0.005+[1:length(stimulusV)]/HW.RX6.fso,stimulusV(:,2)')
%             hold on
%             plot([1:length(HW.triggerpulse)]/HW.SS.Rate,HW.triggerpulse','r')
%             drawnow
            
            
            
            stim_structure.total_time=fix(totsamps/HW.Fso2);
            set(PP_handles.disp_status,'String','Adjusted total time to fit in entire stimulus')
            pause(0.2)
            
        end
        zeroslen(1:length([zeros(start_samp,1);stimu']))=[zeros(start_samp,1);stimu'];
        zeroslen2=zeros(1,totsamps)';
        zeroslen2(1:length(STIMULUSO))=STIMULUSO;
        HW.SS.queueOutputData([HW.triggerpulse zeroslen zeroslen2])%%% ADD VISUAL STIM PULSES
        %         figure(100);clf
        %         plot([1:length(stimulus)]/HW.RX6.fso,stimulus(:,2)')
        %         drawnow
        %         figure(101);clf
        %         plot([1:length(HW.triggerpulse)]/HW.Fso2,[HW.triggerpulse zeroslen])
        trigPlay_2CH_NBRC(stimulusA(:,1)',stimulusA(:,2)',HW.RX6.fso)
        %start([HW.ai])
        %start([HW.ao HW.ai])
    else
        set(PP_handles.disp_status,'String','Interrupted Stimulation')
        interrupt_aud=0;interrupt_vis=0;
        save interrupt_aud interrupt_aud
        save interrupt_vis interrupt_vis
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
setdaqout0
RX6_gPL.SetTagVal('Enable',0); RX6_gPL.Halt;
clear HW

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% wtd_val=get(PP_handles.what_to_do,'Value');
% [HW]=HWinitRX6(wtd_val);% Hardware initialized
% if stim_structure.max_speed_check==0
%     frame_max_speed=0;
%     save frame_max_speed frame_max_speed
% elseif stim_structure.max_speed_check==1
%     frame_max_speed=1;
%     save frame_max_speed frame_max_speed
% end
%%% [0 0 1] VISUAL-AUDITORY STIMULATION ONLY
% total_time=stim_structure.total_time;
% totsamps=fix(total_time*HW.Fso)+100;
% start_time=stim_structure.stim_start;
% start_samp=fix(start_time*HW.Fso)+1;
% pulsewf=zeros(1,fix(total_time*HW.Fso));
% max_stim_samps=length(pulsewf)-start_samp+1;
% if stim_structure.check_vssa==0
%     nsteps=stim_structure.num_int_steps;
%     ints=linspace(stim_structure.start_int,stim_structure.stop_int,nsteps);
% else
%     nsteps=1;
%     ints=stim_structure.ssa_intensity;
% end
% intsf=ints;%%% Decide based on calibration and log scale
% nreps=stim_structure.num_reps_set;
% allints=repmat(intsf,1,nreps);
% t_iters=nsteps*nreps;
% %%%%%% [1 0 0]
% if stim_structure.check_led1==1
%     one_blink=[ones(1,fix(stim_structure.blink_dur*HW.Fso)) zeros(1,fix(stim_structure.inter_blink_int*HW.Fso))];
%     thrsd=0;
% elseif stim_structure.check_led2==1
%     one_blink=[-ones(1,fix(stim_structure.blink_dur*HW.Fso)) zeros(1,fix(stim_structure.inter_blink_int*HW.Fso))];
%     thrsd=-0;
% elseif stim_structure.check_vssa==1
%     if stim_structure.check_LED2_stimB==1
%         one_blink=[ones(1,fix(stim_structure.blink_dur*HW.Fso)) zeros(1,fix(stim_structure.inter_blink_int*HW.Fso))];
%     elseif stim_structure.check_LED1_stimB==1
%         one_blink=[-ones(1,fix(stim_structure.blink_dur*HW.Fso)) zeros(1,fix(stim_structure.inter_blink_int*HW.Fso))];
%     end
% end
% allstims=repmat(one_blink,1,stim_structure.n_blinks);
% if stim_structure.check_vssa==1
%     devpos=stim_structure.stimB_pos;
%     allstims(((devpos-1)*length(one_blink)+1):devpos*length(one_blink))=-allstims(((devpos-1)*length(one_blink)+1):devpos*length(one_blink));
% end

%allstims=[allstims];
%Generate stimulation waveform %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%base=0.5;%%sec baseline for patch experiment%%%REMEMBER TO REMOVE AFTER PATCH
%baseline=zeros(1,base*HW.Fso);%%sec baseline for patch experiment%%%REMEBER TO REMOVE AFTER PATCH
% pulselens=fix(stim_structure.pulse_dur/1000*HW.Fso);
% ipilens=fix(stim_structure.ipi/1000*HW.Fso);
% pulsewv=zeros(1,ipilens);%blankingpulsewv=zeros(1,ipilens);

%%%% additional 0.1 ms to follow for blanking
%%%% and additional 0.5 ms before for blanking
%%%% so shift stimulation time by 0.5 ms
% addblanksamps=fix(10/1000*HW.Fso);
% addblanksampsbefore=fix(10/1000*HW.Fso);
% pulsewv((1):(pulselens))=1;
% %size(pulsewv)
% %blankingpulsewv(1:(pulselens+addblanksamps+addblanksampsbefore-1))=1;
% %size(blankingpulsewv)
% pulsewv=[pulsewv];%;blankingpulsewv];
% num_ppt=stim_structure.num_ppt;
% pulsewv=repmat(pulsewv,1,num_ppt);
% stimulus=allstims;%pulsewv=[baseline pulsewv]; %%sec baseline for patch experiment%%%REMEBER TO REMOVE AFTER PATCH
% %eval(sprintf('[STIMS]=File_%s_Generate(stim_structure,HW);',stim_structure.type))
% current_string='Stimulus Ready';
% set(PP_handles.disp_status,'String',current_string)
% pause(0.05)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Image Params %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IMG.frames_lines_per_iter=stim_structure.stim_protocol.total_frames_lines;
% tfcount=IMG.frames_lines_per_iter;
% IMG.trig_frames_lines=stim_structure.stim_protocol.stim_start;
%
% IMG.total_iters=STIMS.lines_per_set*STIMS.rep_sets;
% stim_start=stim_structure.frame_duration;
% fdursamp=fdurs*HW.Fso;
% t_iters=stim_structure.num_reps;%IMG.total_iters;
% stim_fnums=stim_structure.stim_at_fnums;trig_frame=stim_fnums;
% total_line_duration=stim_structure.total_fcount;
% stim_start_samp=stim_start*HW.Fso;
% pulsewv=[zeros(fix(stim_start_samp),1)' pulsewv]; %%%% insert initial zeros for fixed start time

% figure
% plot(pulsewv')
% finished_stim=0;

% %%%% for COUNTER
% param = loadNI;
% %fcount=[trig_frame 1000000];
% %t_iters
% zeroslen=zeros(1,fix(total_line_duration*HW.Fsi)+100)';
% zeroslen(1:length(pulsewv))=pulsewv;
% pulsewv=zeroslen;

% check_gap=stim_structure.check_gap;
% gap_time=stim_structure.gap_dur;
%
% for iter=1:t_iters
%     line_num=iter;%rem(iter,STIMS.lines_per_set);rep_num=floor(iter/STIMS.lines_per_set)+1;
%     zeroslen=zeros(1,totsamps+100)';
%     %%% Display
%     eval(sprintf('current_string=''Now at Iter %i of %i'';',iter,t_iters))
%     set(PP_handles.disp_status,'String',current_string)
%
%
%     %%%%%%%%%%%%%% LOADING STIMULUS %%%%%%%%%%%%%%%%%%
%     started=0;
%     load interrupt_vis
%     if interrupt_vis==0
% %         stop([HW.ai HW.ao])
% %         putdata(HW.ao,pulsewv')
% %         putvalue(HW.dio.Line(1),[1]);
% %         set(HW.ai,'SamplesPerTrigger',fix(total_line_duration*HW.Fsi)+100) %%%%%%%% ***** CHECK
% %         start([HW.ao HW.ai])
%         %figure
%         stimu=stimulus;
%         stimu(find(stimulus~=0))=stimulus(find(stimulus~=0))*allints(iter);
%         %plot([zeros(start_samp,1);stimu'])
%         if totsamps<length([zeros(start_samp,1);stimu'])
%             %%% add default 500 ms to stimulus duration with starting time
%             extrasamps=fix(0.5*HW.Fso);
%             totsamps=length([zeros(start_samp,1);stimu'])+extrasamps;
%             zeroslen=zeros(1,totsamps+100)';
%             stim_structure.total_time=fix(totsamps/HW.Fso);
%             set(PP_handles.disp_status,'String','Adjusted total time to fit in entire stimulus')
%             pause(0.2)
%
%         end
%         zeroslen(1:length([zeros(start_samp,1);stimu']))=[zeros(start_samp,1);stimu'];
%         HW.SS.queueOutputData(zeroslen);
%     else
%
%         set(PP_handles.disp_status,'String','Interrupted Visual Stimulation')
%         interrupt_vis=0;
%         save interrupt_vis interrupt_vis
%
%         daqreset
%         finished_stim=-1;
%         if exist('trig_inputs')
%             save trig_inputs trig_inputs
%         else
%             trig_inputs=[];
%             save trig_inputs trig_inputs
%         end
%         %close(HW.atten_handle)
%         %ao=analogoutput('nidaq',HW.boardID2);
%         %cho=addchannel(ao,[1]);
%         %putdata(ao,zeros(1000,1))
%         %start(ao)
%         pause(.1)
%         HW.SS.release();
%         daqreset
%         return
%     end
%     %%%%%%%%%%%%%% PLAYING STIMULUS %%%%%%%%%%%%%%%%%%
%     %%%%%%%%%%%%%% STARTING ACQUISITION %%%%%%%%%%%%%%
%     eval(sprintf('current_string=''Started Stimulus (Iter # %i ...) '';',iter))
%     set(PP_handles.disp_status,'String',current_string)
%     started=1;
%     pause(0.002)
%     eval(sprintf('trig_inputs.iter%i=HW.SS.startForeground;',iter))
%     %putvalue(HW.dio.Line(1),[0]);
%     pause(.003)
%     %putvalue(HW.dio.Line(1),[1]); % reset trigger line
%     %%%%%%%%%%%%%% ENDING LINE %%%%%%%%%%%%%%%%%%
%     %%%%%%%%%%%%%% STOP ACQUISITION %%%%%%%%%%%%%
%     while HW.SS.IsRunning
%         1000000+1000000;
%     end
%     %waittilstop([HW.ai],100)
%     eval(sprintf('current_string=''DONE (Iter # %i ...) '';',iter))
%     pause(.002)
%     %eval(sprintf('trig_inputs.iter%i=getdata(HW.ai,HW.ai.SamplesAcquired);',iter))
%     set(PP_handles.disp_status,'String',current_string)
%     if check_gap&iter~=t_iters
%         eval(sprintf('current_string=''DONE (ITER # %i ...); Waiting for ... %5.2f seconds '';',iter,gap_time))
%         set(PP_handles.disp_status,'String',current_string)
%         pause(gap_time)
%     end
% end
%
% finished_stim=1;
% trig_inputs.Fsi=HW.Fsi;
% save trig_inputs trig_inputs %change in
% HW.SS.release();
% daqreset
% setdaqout0




%     started=0;%armed_started=0;
%
%
%     for count=1:iLoopCount
%         %Get the counter value
%         iStatus = GPCTR_Watch(HW.boardID, counterNum, param.ND_COUNT, ...
%             pulCount);
%
%         %%%%%%%%%%%%%% LOADING STIMULUS %%%%%%%%%%%%%%%%%%
%         %%%%%%%%%%%%%% GETTING TRIG INPUTS %%%%%%%%%%%%%%%
%         %%%%%%%%%%%%%% AT 3 frames before trig frame %%%%%
%         %pulCount.value
%         iter
%         inds=find((stim_fnums-3)==pulCount.value);
%         if length(inds)~=0
%             started=0;
%
%             load interrupt_estim
%             if interrupt_estim==0
%                 stop([HW.ai HW.ao])
% %                 if iter~=1
% %                     eval(sprintf('trig_inputs.iter%i=getdata(HW.ai,HW.ai.SamplesAcquired);',iter-1))
% %                 end
%                 putdata(HW.ao,pulsewv')
%                 %%% arm trigger
%                 putvalue(HW.dio.Line(1),[1]);
%                 start([HW.ao HW.ai])
%             else
%                 set(PP_handles.disp_status,'String','Interrupted Electrical Stimulation')
%                 interrupt_estim=0;
%                 save interrupt_estim interrupt_estim
%                 iStatus = GPCTR_Control(HW.boardID, counterNum, param.ND_RESET);
%                 unloadNI
%                 daqreset
%                 finished_stim=-1;
%                 %close(HW.atten_handle)
%                 return
%             end
%         end
% %         inds=find(((stim_fnums)-1)==pulCount.value);current_frame=pulCount.value;
% %         if length(inds)~=0&armed_started==0
% %             start([HW.ao HW.ai])
% %             armed_started=1;
% %         end
%         %%%%%%%%%%%%%% PLAYING STIMULUS %%%%%%%%%%%%%%%%%%
%         %%%%%%%%%%%%%% STARTING ACQUISITION %%%%%%%%%%%%%%
%         inds=find((stim_fnums)==pulCount.value);current_frame=pulCount.value;
%         if length(inds)~=0&started==0
%             %%% pull trigger
%             putvalue(HW.dio.Line(1),[0]);
%             started=1;
%             eval(sprintf('current_string=''Started Stimulation (Rep # %i, for frame # %i) '';',iter,current_frame))
%             set(PP_handles.disp_status,'String',current_string)
%             pause(0.002)
%             putvalue(HW.dio.Line(1),[1]); % reset trigger line
%         end
%
%         inds=find((stim_fnums+1)==pulCount.value);current_frame=pulCount.value;
%         if length(inds)~=0&started==1
%             started=0;armed_started=0;
%         end
%         %%%%%%%%%%%%%% ENDING LINE %%%%%%%%%%%%%%%%%%
%         %%%%%%%%%%%%%% STOP ACQUISITION %%%%%%%%%%%%%
%
%         if pulCount.value==tfcount
%             iStatus = GPCTR_Control(HW.boardID, counterNum, param.ND_RESET);
%             stop([HW.ao HW.ai])
%             eval(sprintf('current_string=''DONE (ITER # %i ...) '';',iter))
%             %tic
%             eval(sprintf('trig_inputs.iter%i=getdata(HW.ai,HW.ai.SamplesAcquired);',iter))
%             %iter
%             %toc
%             set(PP_handles.disp_status,'String',current_string)
%             break
%         end
%         load interrupt_estim
%         if interrupt_estim==1
%             interrupt_estim=0;
%             save interrupt_estim interrupt_estim
%             return
%         end
%         pause(.00001);
%     end
% end
% finished_stim=1;
% save trig_inputs trig_inputs %change in
%
% unloadNI
% daqreset
