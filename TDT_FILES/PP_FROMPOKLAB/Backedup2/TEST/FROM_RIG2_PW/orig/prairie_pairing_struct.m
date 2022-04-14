function [finished_stim]=prairie_pairing_struct(stim_structure,PP_handles)

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

wtd_val=get(PP_handles.what_to_do,'Value');
if stim_structure.AUD.max_speed_check==0
    frame_max_speed=0;
    save frame_max_speed frame_max_speed
elseif stim_structure.AUD.max_speed_check==1
    frame_max_speed=1;
    save frame_max_speed frame_max_speed
end
[HW]=HWinit(wtd_val);% Hardware initialized

%Generate stimuli %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
HWA=HW;
HWA.Fso=HW.Fso1;HWA.ao=HW.ao1;HWA.op_ch=HW.op_ch1;HWA.Amplitude=HW.Amplitude1;
eval(sprintf('[STIMS]=File_%s_Generate(stim_structure.AUD,HWA);',stim_structure.AUD.type))
current_string='Auditory Stimulus Ready';
set(PP_handles.disp_status,'String',current_string)
pause(.01)
%% GENERAL parameters in STIMS
% STIMS.lines_per_set
% STIMS.rep_sets
% STIMS.ATTENS.Left
% STIMS.ATTENS.Right
% STIMS.hard=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Generate stimulation waveform %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pulselens=fix(stim_structure.ELEC.pulse_dur/1000*HW.Fso2);
ipilens=fix(stim_structure.ELEC.ipi/1000*HW.Fso2);
pulsewv=zeros(1,ipilens);
pulsewv(1:pulselens)=1;
num_ppt=stim_structure.ELEC.num_ppt;
pulsewv=repmat(pulsewv,1,num_ppt);pulsewv=HW.Amplitude2*pulsewv;
%eval(sprintf('[STIMS]=File_%s_Generate(stim_structure,HW);',stim_structure.type))
current_string='Electrical Stimulus Ready';
set(PP_handles.disp_status,'String',current_string)
pause(.01)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Image Params %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IMG.frames_lines_per_iter=stim_structure.AUD.stim_protocol.total_frames_lines; 
tfcount=IMG.frames_lines_per_iter;
IMG.trig_frames_lines=stim_structure.AUD.stim_protocol.stim_start; 
trig_frame=IMG.trig_frames_lines;
IMG.total_iters=STIMS.lines_per_set*STIMS.rep_sets;
t_iters=stim_structure.Pair_reps;
fdurs=stim_structure.AUD.stim_protocol.frame_dur;
fdursamp=fdurs*HW.Fso1;
offset_num=stim_structure.AUD.offset_num;
start_offsets=fix([0:(offset_num-1)]*(fdursamp)/offset_num);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% FOR COUNTING %%%%%%%%%%%%%%%%%%%%%%%%%
TC=2^24;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% SELECT BOARD COUNTER AND VALUES FOR MAX SPEED%%%%%%%%
if stim_structure.AUD.max_speed_check==0
    CTR_BOARD=1;CTR_TRIG=TC-trig_frame;CTR_RESET=tfcount-trig_frame;pause_del=0.05;
elseif stim_structure.AUD.max_speed_check==1
    CTR_BOARD=2;CTR_TRIG=TC-trig_frame+1;CTR_RESET=tfcount-trig_frame+1;pause_del=0;
end


finished_stim=0;

%%%% for COUNTER
param = loadNI;
%fcount=[trig_frame 1000000];

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
    
    iLoopCount = 1000000;        %Number of times to check the counter's value
    %Hardware configuration
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % COUNTER NUMBER IS 0 for either board for frames
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    counterNum = param.ND_COUNTER_0;    %The ID for the counter
    %Define pointers to get data back from the counter
    fmt = 'uint32Ptr';      % Pointer format string
    iStatus = GPCTR_Control(CTR_BOARD, counterNum, param.ND_RESET);
    pulCount = libpointer(fmt,CTR_TRIG);  %The number of events counted by the counter (initialized)
    %2^24-1 terminalcount
    iStatus = GPCTR_Set_Application(CTR_BOARD, counterNum, ...
        param.ND_SIMPLE_EVENT_CNT);
    iStatus = GPCTR_Change_Parameter(CTR_BOARD, counterNum, param.ND_SOURCE, ...
        param.ND_DEFAULT_PFI_LINE);
    if stim_structure.AUD.max_speed_check==0
        iStatus = GPCTR_Change_Parameter(CTR_BOARD, counterNum, param.ND_SOURCE_POLARITY, ...
            param.ND_LOW_TO_HIGH);
    elseif stim_structure.AUD.max_speed_check==1
        iStatus = GPCTR_Change_Parameter(CTR_BOARD, counterNum, param.ND_SOURCE_POLARITY, ...
            param.ND_HIGH_TO_LOW);
    end
    
    iStatus = Select_Signal(CTR_BOARD,param.ND_GPCTR0_OUTPUT, param.ND_GPCTR0_OUTPUT, ...
        param.ND_LOW_TO_HIGH);
    iStatus = GPCTR_Change_Parameter(CTR_BOARD, counterNum, param.ND_OUTPUT_MODE, ...
        param.ND_PULSE);
    %     /* Load initial count. */
    iStatus = GPCTR_Change_Parameter(CTR_BOARD, counterNum, ...
        param.ND_INITIAL_COUNT, pulCount.value);
    iStatus = GPCTR_Control(CTR_BOARD, counterNum, param.ND_PROGRAM);
    %    /* Loop iLoopCount times. */
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
        putdata(HW.ao1,stimulus)
        putdata(HW.ao2,pulsewv')
        start([HW.ai HW.ao1 HW.ao2])
    else
        set(PP_handles.disp_status,'String','Interrupted Auditory Stimulation')
        interrupt_aud=0;
        save interrupt_aud interrupt_aud
        iStatus = GPCTR_Control(CTR_BOARD, counterNum, param.ND_RESET);
        unloadNI
        daqreset
        finished_stim=-1;
        if exist('trig_inputs')
            save trig_inputs trig_inputs
        else
            trig_inputs=[];
            save trig_inputs trig_inputs
        end
        close(HW.atten_handle)
        ao1=analogoutput('nidaq',HW.boardID1);
        ao2=analogoutput('nidaq',HW.boardID1);
        cho1=addchannel(ao1,[0 1]);
        cho2=addchannel(ao2,[0 1]);
        putdata(ao1,zeros(1000,2))
        putdata(ao2,zeros(1000,2))
        start([ao1 ao2])
        pause(.1)
        daqreset
        return
    end
    
    %    /* Loop iLoopCount times. */
    
     for count=1:iLoopCount
        %Get the counter value
        iStatus = GPCTR_Watch(CTR_BOARD, counterNum, param.ND_COUNT, ...
            pulCount);
        if pulCount.value==1
            eval(sprintf('current_string=''Started Stimulus (ITER # %i ...) at frame # %i'';',iter,trig_frame))
            set(PP_handles.disp_status,'String',current_string)
            pause(0.002)
        end
        
        %pulCount.value
        iStatus = GPCTR_Watch(CTR_BOARD, counterNum, param.ND_COUNT, ...
            pulCount);
        if pulCount.value==(CTR_RESET)
            iStatus = GPCTR_Control(CTR_BOARD, counterNum, param.ND_RESET);
            pause(fdurs+pause_del)
            
            %%%%%%%%%%%%%% GETTING TRIG INPUTS %%%%%%%%%%%%%%%
            
            load interrupt_aud
            if interrupt_aud==0
                stop([HW.ai HW.ao1 HW.ao2])
                eval(sprintf('current_string=''DONE (ITER # %i ...) '';',iter))
                set(PP_handles.disp_status,'String',current_string)
                pause(0.002)
                eval(sprintf('trig_inputs.iter%i=getdata(HW.ai,HW.ai.SamplesAcquired);',iter))
                break
            else
                set(PP_handles.disp_status,'String','Interrupted Auditory Stimulation')
                interrupt_aud=0;
                save interrupt_aud interrupt_aud
                iStatus = GPCTR_Control(CTR_BOARD, counterNum, param.ND_RESET);
                unloadNI
                daqreset
                finished_stim=-1;
                if exist('trig_inputs')
                    save trig_inputs trig_inputs
                else
                    trig_inputs=[];
                    save trig_inputs trig_inputs
                end
                close(HW.atten_handle)
                ao1=analogoutput('nidaq',HW.boardID1);
                ao2=analogoutput('nidaq',HW.boardID2);
                cho1=addchannel(ao1,[0 1]);
                cho2=addchannel(ao2,[0 1]);
                putdata(ao1,zeros(1000,2))
                putdata(ao2,zeros(1000,2))
                start([ao1 ao2])
                pause(.1)
                daqreset
                return
            end
                
        end
            
        
        pause(.00001);
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
unloadNI
daqreset

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
