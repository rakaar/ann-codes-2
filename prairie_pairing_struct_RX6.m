function [finished_stim]=prairie_pairing_struct_RX6(stim_structure,PP_handles)

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
%    max_speed_check: 1
%         offset_num: 5
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
if stim_structure.AUD.max_speed_check==0
    frame_max_speed=0;
    save frame_max_speed frame_max_speed
elseif stim_structure.AUD.max_speed_check==1
    frame_max_speed=1;
    save frame_max_speed frame_max_speed
end
[HW]=HWinitRX6(wtd_val);% Hardware initialized
tpls=generate_mtrigger_begin(.05,HW.Fso2,HW.Amplitude2,0.04);
%Generate stimuli %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
HWA=HW;
HWA.Fso=HW.Fso1;HWA.Amplitude=HW.Amplitude1;
eval(sprintf('[STIMS]=File_%s_Generate(stim_structure.AUD,HWA);',stim_structure.AUD.type))
current_string='Auditory Stimulus Ready';
set(PP_handles.disp_status,'String',current_string)
pause(.1)
%% GENERAL parameters in STIMS
% STIMS.lines_per_set
% STIMS.rep_sets
% STIMS.ATTENS.Left
% STIMS.ATTENS.Right
% STIMS.hard=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t_iters=stim_structure.Pair_reps;%IMG.total_iters;
deltaEo_Ao=stim_structure.OnsetE_A;
samps_deltaEo_Ao=fix(abs(deltaEo_Ao)*HW.Fso2);
stim_fnums=stim_structure.ELEC.stim_at_fnums;trigframe=stim_structure.ELEC.stim_at_fnums;
total_time=stim_structure.ELEC.total_fcount;
stim_start=stim_structure.ELEC.frame_duration;
total_time_samps=fix(total_time*HW.Fso2);
%Generate stimulation waveform %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if stim_structure.ELEC.EPISODIC.do==0
    pulselens=fix(stim_structure.ELEC.pulse_dur/1000*HW.Fso2);
    ipilens=fix(stim_structure.ELEC.ipi/1000*HW.Fso2);
    pulsewv=zeros(1,ipilens);
    pulsewv(1:pulselens)=1;
    num_ppt=stim_structure.ELEC.num_ppt;
    pulsewv=repmat(pulsewv,1,num_ppt);pulsewv=HW.Amplitude2*pulsewv;%pulsewv=[baseline pulsewv]; %%sec baseline for patch experiment%%%REMEBER TO REMOVE AFTER PATCH
    zerosamps=fix(stim_start*HW.Fso2);
    zerosamps_end=total_time_samps-zerosamps;
    if deltaEo_Ao>0
        pulsewv=[zeros(1,length(tpls)) zeros(1,zerosamps) zeros(1,samps_deltaEo_Ao) pulsewv zeros(1,zerosamps_end)];
    elseif deltaEo_Ao<0
        pulsewv=[zeros(1,length(tpls)) zeros(1,zerosamps-samps_deltaEo_Ao) pulsewv zeros(1,zerosamps_end+samps_deltaEo_Ao)];
    elseif deltaEo_Ao==0
        pulsewv=[zeros(1,length(tpls)) zeros(1,zerosamps) pulsewv zeros(1,zerosamps_end)];
    end
    mtriggerwf=zeros(1,length(pulsewv));
    mtriggerwf(1:length(tpls))=tpls;
   
elseif stim_structure.ELEC.EPISODIC.do==1
    if stim_structure.ELEC.EPISODIC.Fso==HW.Fso2
        pulsewv=HW.Amplitude2*stim_structure.ELEC.EPISODIC.pulsewv;
    else
        pulsewv=HW.Amplitude2*resample(stim_structure.ELEC.EPISODIC.pulsewv,HW.Fso2,stim_structure.ELEC.EPISODIC.Fso);
    end
end
stim_structure.ELEC.EPISODIC.pulsewv=[];
EstimPARAMS=stim_structure.ELEC;
curdir=pwd;
cd C:\EXPERIMENTS\CODES\PARAMS
save EstimPARAMS EstimPARAMS
cd (curdir)
current_string='Electrical Stimulus Ready';
set(PP_handles.disp_status,'String',current_string)
pause(.1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Image Params %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IMG.frames_lines_per_iter=stim_structure.AUD.stim_protocol.total_frames_lines; 
tfcount=IMG.frames_lines_per_iter;
IMG.trig_frames_lines=stim_structure.AUD.stim_protocol.stim_start; 
trig_frame=IMG.trig_frames_lines;
IMG.total_iters=STIMS.lines_per_set*STIMS.rep_sets;
t_iters=stim_structure.Pair_reps;
fdurs=stim_structure.AUD.stim_protocol.frame_dur;
fdursamp=fix(fdurs*HW.Fso1);
offset_num=stim_structure.AUD.offset_num;
start_offsets=fix([0:(offset_num-1)]*(fdursamp)/offset_num);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


use_gap=stim_structure.ELEC.stim_gap_check;
gap_time=stim_structure.ELEC.stim_gap_val;

finished_stim=0;
stim_start=stim_structure.AUD.stim_protocol.stim_start;
zerosampsA=fix(stim_start*HW.RX6.fso);
%zerosampsA_end=0;%(tfcount-trigframe)*fdursamp;
for iter=1:t_iters
    line_num=1;%rem(iter,STIMS.lines_per_set);
    rep_num=floor(iter/STIMS.lines_per_set)+1;
    if line_num==0
        line_num=STIMS.lines_per_set;
        rep_num=rep_num-1;
    end
    offsetid=rem(rep_num,offset_num);
    if offsetid==0
        offsetid=offset_num;
    end
    current_offset=start_offsets(offsetid);%%% in samples
    STIMS.START_TIMES(iter)=start_offsets(offsetid)/HW.Fso1;%%%%% start times saved in secs
    
    %%% Display
    eval(sprintf('current_string=''Now at Iter %i of %i, Rep %i of %i, Line %i of Set of %i Lines!'';',iter,t_iters,rep_num,STIMS.rep_sets,line_num,STIMS.lines_per_set))
    set(PP_handles.disp_status,'String',current_string)
    started=0;%armed_started=0;
    %%%%%%%%%%%% SET ATTENUATION %%%%%%%%%%%%%%%%%
    if stim_structure.AUD.left_check==1
        HW.PA_L.SetAtten(STIMS.ATTENS.Left(line_num));
        HW.PA_R.SetAtten(120);pause(.001);
    elseif stim_structure.AUD.right_check==1
        HW.PA_L.SetAtten(120);
        HW.PA_R.SetAtten(STIMS.ATTENS.Right(line_num));pause(.001);
    elseif stim_structure.AUD.both_check==1
        HW.PA_L.SetAtten(STIMS.ATTENS.Left(line_num));
        HW.PA_R.SetAtten(STIMS.ATTENS.Right(line_num));pause(.001);
    end
    if STIMS.hard==1
        eval(sprintf('stimulus=STIMS.waveform.line%i;',line_num)) %%%%%%%% Currently written as same stimulus in both ears (if both)
        stimulus=[zeros(zerosampsA,1); stimulus];% zeros(zerosampsA_end,1)];
        stimulus=[zeros(current_offset,1); stimulus*HWA.Amplitude];
        if stim_structure.AUD.left_check==1
            stimulus=[stimulus zeros(size(stimulus))];
        elseif stim_structure.AUD.right_check==1
            stimulus=[zeros(size(stimulus)) stimulus];
        elseif stim_structure.AUD.both_check==1
            stimulus=[stimulus stimulus];
        end
    else
        %%%WRITE CODE%%%% For hard parameter= 0 and -1
    end
    started=0;
    load interrupt_aud
    if interrupt_aud==0
        figure
        plot(mtriggerwf)
        hold on
        plot(pulsewv,'r')
        HW.SS.queueOutputData([mtriggerwf' pulsewv'])
        trigPlay_2CH(stimulus(:,1)',stimulus(:,2)',HW.RX6.fso)
        
    else
        set(PP_handles.disp_status,'String','Interrupted Auditory Stimulation')
        interrupt_aud=0;
        save interrupt_aud interrupt_aud
        daqreset
        setdaqout0
        if exist('trig_inputs')
            save trig_inputs trig_inputs
        else
            trig_inputs=[];
            save trig_inputs trig_inputs
        end
        finished_stim=-1;
        close(HW.atten_handle)
        daqreset
        setdaqout0
        RX6_gPL.SetTagVal('Enable',0); RX6_gPL.Halt;
        return
                
    end
    eval(sprintf('current_string=''Started Stimulus (ITER # %i ...) '';',iter))
    set(PP_handles.disp_status,'String',current_string)
    started=1;
    pause(0.002)
    eval(sprintf('trig_inputs.iter%i=HW.SS.startForeground;',iter))
    pause(0.01)
    while HW.SS.IsRunning
        1000000+1000000;
    end
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


%     for count=1:iLoopCount
%         %Get the counter value
%         iStatus = GPCTR_Watch(HW.boardID, counterNum, param.ND_COUNT, ...
%             pulCount);
%         
%         %%%%%%%%%%%%%% LOADING STIMULUS %%%%%%%%%%%%%%%%%% 
%         %%%%%%%%%%%%%% GETTING TRIG INPUTS %%%%%%%%%%%%%%%
%         %%%%%%%%%%%%%% AT 8 frames before trig frame %%%%%
%         %pulCount.value
%         if pulCount.value==(trig_frame-8) 
%             %%%%%%%%%%%% SET ATTENUATION %%%%%%%%%%%%%%%%%
%             if stim_structure.left_check==1
%                 HW.PA_L.SetAtten(STIMS.ATTENS.Right(line_num));
%                 HW.PA_R.SetAtten(120);pause(.001);
%             elseif stim_structure.right_check==1
%                 HW.PA_L.SetAtten(120);
%                 HW.PA_R.SetAtten(STIMS.ATTENS.Right(line_num));pause(.001);
%             elseif stim_structure.both_check==1
%                 HW.PA_L.SetAtten(STIMS.ATTENS.Left(line_num));
%                 HW.PA_R.SetAtten(STIMS.ATTENS.Right(line_num));pause(.001);
%             end
%             if STIMS.hard==1
%                 eval(sprintf('stimulus=STIMS.waveform.line%i;',line_num)) %%%%%%%% Currently written as same stimulus in both ears (if both)
%                 if oddc==1
%                     stimulus=stimulus*HW.Amplitude;
%                 else
%                     stimulus=[zeros(fix(fdursamp/2),1); stimulus*HW.Amplitude];
%                 end
%                 if stim_structure.left_check==1
%                     stimulus=[stimulus zeros(size(stimulus))];
%                 elseif stim_structure.right_check==1
%                     stimulus=[zeros(size(stimulus)) stimulus];
%                 elseif stim_structure.both_check==1
%                     stimulus=[stimulus stimulus];
%                 end
%             else
%                 %%%WRITE CODE%%%% For hard parameter= 0 and -1
%             end
% 
%             started=0;
%                         
%             load interrupt_aud
%             if interrupt_aud==0
%                 stop([HW.ai HW.ao])
% %                 if iter~=1
% %                     eval(sprintf('trig_inputs.iter%i=getdata(HW.ai,HW.ai.SamplesAcquired);',iter-1))
% %                 end
%                 putdata(HW.ao,stimulus)
%                 %%% arm trigger
%                 putvalue(HW.dio.Line(1),[1]);
%                 start([HW.ao HW.ai])
%             else
%                 set(PP_handles.disp_status,'String','Interrupted Auditory Stimulation')
%                 interrupt_aud=0;
%                 save interrupt_aud interrupt_aud
%                 iStatus = GPCTR_Control(HW.boardID, counterNum, param.ND_RESET);
%                 unloadNI
%                 daqreset
%                 finished_stim=-1;
%                 close(HW.atten_handle)
%                 return
%             end
%         end               
%         
%         %%%%%%%%%%%%%% PLAYING STIMULUS %%%%%%%%%%%%%%%%%% 
%         %%%%%%%%%%%%%% STARTING ACQUISITION %%%%%%%%%%%%%%
%                 
%         if pulCount.value==trig_frame&started==0
%             %%% pull trigger
%             putvalue(HW.dio.Line(1),[0]);
%             started=1;
%             eval(sprintf('current_string=''Started Stimulus (ITER # %i ...) '';',iter))
%             set(PP_handles.disp_status,'String',current_string)
%             pause(0.002)
%             putvalue(HW.dio.Line(1),[1]); % reset trigger line
%         end
%         
%         %%%%%%%%%%%%%% ENDING LINE %%%%%%%%%%%%%%%%%% 
%         %%%%%%%%%%%%%% STOP ACQUISITION %%%%%%%%%%%%%
%         
%         if pulCount.value==tfcount
%             iStatus = GPCTR_Control(HW.boardID, counterNum, param.ND_RESET);
%             stop([HW.ao HW.ai])
%             eval(sprintf('current_string=''DONE (ITER # %i ...) '';',iter))
%             %tic
%             eval(sprintf('trig_inputs.iter%i=getdata(HW.ai,HW.ai.SamplesAcquired);',iter))
%             %toc
%             set(PP_handles.disp_status,'String',current_string)
%             break
%         end
%         pause(.00001);
%     end
% end
% finished_stim=1;
% save trig_inputs trig_inputs %change in 
% STIMS=rmfield(STIMS,'waveform');
% AUD_IMG_STIM.IMG=IMG;
% AUD_IMG_STIM.STIMS=STIMS;
% %AUD_IMG_STIM.HW=HW;
% save AUD_IMG_STIM AUD_IMG_STIM
% HW.PA_L.SetAtten(80);
% HW.PA_R.SetAtten(80);pause(.01); 
% close(HW.atten_handle)
% unloadNI
% daqreset
