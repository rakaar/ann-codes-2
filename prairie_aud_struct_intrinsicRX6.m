function [finished_stim]=prairie_aud_struct_intrinsicRX6(stim_structure,PP_handles)

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

[HW]=HWinitRX6(wtd_val);% Hardware initialized

%Generate stimuli %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eval(sprintf('[STIMS]=File_%s_Generate(stim_structure,HW);',stim_structure.type))
current_string='Stimulus Ready';
set(PP_handles.disp_status,'String',current_string)
%% GENERAL parameters in STIMS
% STIMS.lines_per_set
% STIMS.rep_sets
% STIMS.ATTENS.Left
% STIMS.ATTENS.Right
% STIMS.hard=1;
% STIMS.duration
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Image Params %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
IMG.frames_lines_per_iter=stim_structure.stim_protocol.total_frames_lines;
tfcount=IMG.frames_lines_per_iter;
IMG.trig_frames_lines=stim_structure.stim_protocol.stim_start;
trig_frame=IMG.trig_frames_lines;
IMG.total_iters=STIMS.lines_per_set*STIMS.rep_sets;
t_iters=IMG.total_iters;
fdurs=stim_structure.stim_protocol.frame_dur;
fdursamp=fdurs*HW.Fso;
%offset_num=stim_structure.offset_num;
%start_offsets=fix([0:(offset_num-1)]*(fdursamp)/offset_num);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%% FOR COUNTING %%%%%%%%%%%%%%%%%%%%%%%%%
TC=2^24;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% SELECT BOARD COUNTER AND VALUES FOR INTRINSIC%%%%%%%%

CTR_BOARD=2;CTR_TRIGx=TC-trig_frame;CTR_RESETx=tfcount-trig_frame+1;pause_del=0;

finished_stim=0;

%%%% for COUNTER
param = loadNI;
%fcount=[trig_frame 1000000];
nreps=STIMS.rep_sets;
presented=zeros(1,t_iters);
[CTR_RESETALL,CTR_TRIGALL,STIMFRAMES]=create_ctr_trigreset_setII(stim_structure,STIMS.duration,STIMS.lines_per_set,TC);
CTR_TRIGALL(1)=CTR_TRIGx;STIMFRAMES(1)=trig_frame;STIMS.STIMFRAMES=STIMFRAMES;
for iter=1:t_iters
    line_num=rem(iter,STIMS.lines_per_set);rep=floor(iter/STIMS.lines_per_set)+1;
    if line_num==0
        line_num=STIMS.lines_per_set;
        rep=rep-1;
    end


    CTR_RESET=CTR_RESETALL(iter);
    CTR_TRIG=STIMFRAMES(iter);
    %STIMS.START_FRAMES(stimnum)=
    %%% Display
    eval(sprintf('current_string=''Now at Rep %i of %i, Stim Number %i of %i!'';',rep,nreps,line_num,STIMS.lines_per_set))
    set(PP_handles.disp_status,'String',current_string)

    iLoopCount = 1000000;        %Number of times to check the counter's value
    %Hardware configuration

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % COUNTER NUMBER IS 1 on board 2 for intrinsic imaging
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if iter==1
        counterNum = param.ND_COUNTER_1;    %The ID for the counter
        %Define pointers to get data back from the counter
        fmt = 'uint32Ptr';      % Pointer format string
        iStatus = GPCTR_Control(CTR_BOARD, counterNum, param.ND_RESET);
        pulCount = libpointer(fmt,0);  %The number of events counted by the counter (initialized)
        %2^24-1 terminalcount
        iStatus = GPCTR_Set_Application(CTR_BOARD, counterNum, ...
            param.ND_SIMPLE_EVENT_CNT);
        iStatus = GPCTR_Change_Parameter(CTR_BOARD, counterNum, param.ND_SOURCE, ...
            param.ND_DEFAULT_PFI_LINE);
        iStatus = GPCTR_Change_Parameter(CTR_BOARD, counterNum, param.ND_SOURCE_POLARITY, ...
            param.ND_LOW_TO_HIGH);

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
    end
    %%%%%%%%%%%% SET ATTENUATION %%%%%%%%%%%%%%%%%
    if stim_structure.left_check==1
        HW.PA_L.SetAtten(STIMS.ATTENS.Left(line_num));
        HW.PA_R.SetAtten(120);pause(.001);
    elseif stim_structure.right_check==1
        HW.PA_L.SetAtten(120);
        HW.PA_R.SetAtten(STIMS.ATTENS.Right(line_num));pause(.001);
    elseif stim_structure.both_check==1
        HW.PA_L.SetAtten(STIMS.ATTENS.Left(line_num));
        HW.PA_R.SetAtten(STIMS.ATTENS.Right(line_num));pause(.001);
    end
    if STIMS.hard==1
        eval(sprintf('stimulus=STIMS.waveform.line%i;',line_num)) %%%%%%%% Currently written as same stimulus in both ears (if both)
        stimulus=[stimulus*HW.Amplitude];
        if stim_structure.left_check==1
            %sprintf('left')
            stimulus=[stimulus zeros(size(stimulus))];
        elseif stim_structure.right_check==1
            %sprintf('right')
            stimulus=[zeros(size(stimulus)) stimulus];
        elseif stim_structure.both_check==1
            stimulus=[stimulus stimulus];
        end
    else
        %%%WRITE CODE%%%% For hard parameter= 0 and -1
    end
    started=0;
    
   

    %    /* Loop iLoopCount times. */

    for count=1:iLoopCount
        %Get the counter value
        iStatus = GPCTR_Watch(CTR_BOARD, counterNum, param.ND_COUNT, ...
            pulCount);
%         if pulCount.value==(CTR_TRIG-9)
%              putdata(HW.ao,stimulus)
%         end

        if pulCount.value==CTR_TRIG
            load interrupt_aud
            if interrupt_aud==0
                if presented(iter)==0
                    putdata(HW.ao,stimulus)
                    start([HW.ao])
                    waittilstop(HW.ao,10)
                    presented(iter)=1;
                end
                %CTR_TRIG
                
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
                ao=analogoutput('nidaq',HW.boardID1);
                cho=addchannel(ao,[0 1]);
                putdata(ao,zeros(1000,2))
                start(ao)
                pause(.1)
                daqreset
                return
            end
        end

        if pulCount.value==(CTR_TRIG+1)
            eval(sprintf('current_string=''Started Stimulus (number # %i ...) at frame # %i'';',line_num,STIMFRAMES(iter)))
            set(PP_handles.disp_status,'String',current_string)
            pause(0.002)
        end
        
         if pulCount.value==(CTR_TRIG+2)
            eval(sprintf('current_string=''DONE (ITER # %i ...)'';',iter))
            set(PP_handles.disp_status,'String',current_string)
            pause(0.002)
            break
        end

        %pulCount.value
%         iStatus = GPCTR_Watch(CTR_BOARD, counterNum, param.ND_COUNT, ...
%             pulCount);
%         if pulCount.value==(CTR_RESET)
%             iStatus = GPCTR_Control(CTR_BOARD, counterNum, param.ND_RESET);
%             pause(fdurs+pause_del)
% 
%             %%%%%%%%%%%%%% GETTING TRIG INPUTS %%%%%%%%%%%%%%%
% 
%             load interrupt_aud
%             if interrupt_aud==0
%                 stop([HW.ao])
%                 eval(sprintf('current_string=''DONE (ITER # %i ...) '';',iter))
%                 set(PP_handles.disp_status,'String',current_string)
%                 pause(0.002)
%                 eval(sprintf('trig_inputs.iter%i=[];',iter))%getdata(HW.ai,HW.ai.SamplesAcquired)
%                 break
%             else
%                 set(PP_handles.disp_status,'String','Interrupted Auditory Stimulation')
%                 interrupt_aud=0;
%                 save interrupt_aud interrupt_aud
%                 iStatus = GPCTR_Control(CTR_BOARD, counterNum, param.ND_RESET);
%                 unloadNI
%                 daqreset
%                 finished_stim=-1;
%                 if exist('trig_inputs')
%                     save trig_inputs trig_inputs
%                 else
%                     trig_inputs=[];
%                     save trig_inputs trig_inputs
%                 end
%                 close(HW.atten_handle)
%                 ao=analogoutput('nidaq',HW.boardID1);
%                 cho=addchannel(ao,[0 1]);
%                 putdata(ao,zeros(1000,2))
%                 start(ao)
%                 pause(.1)
%                 daqreset
%                 return
%             end
% 
%         end


        pause(.00001);
    end

end
finished_stim=1;
trig_inputs.Fsi=HW.Fsi;
trig_inputs=[];
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
