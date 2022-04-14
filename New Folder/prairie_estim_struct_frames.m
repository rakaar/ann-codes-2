function [finished_stim]=prairie_estim_struct_frames(stim_structure,PP_handles)

% Example EStim Structure 
% stim_structure
% EstimPARAMS = 
% 
%        current_amp: 0.2000
%          pulse_dur: 0.2000
%                ipi: 5
%            num_ppt: 50
%       total_fcount: 50
%           num_reps: 1
%      stim_at_fnums: [20] %%currently set for only single start frame
%     linescan_check: 0
%        frame_check: 1
%          frame_str: '20'
%     frame_duration: 0.2000
%    max_speed_check: 1

wtd_val=get(PP_handles.what_to_do,'Value');
if stim_structure.max_speed_check==0
    frame_max_speed=0;
    save frame_max_speed frame_max_speed
elseif stim_structure.max_speed_check==1
    frame_max_speed=1;
    save frame_max_speed frame_max_speed
end
[HW]=HWinit(wtd_val);% Hardware initialized

%Generate stimulation waveform %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%base=0.5;%%sec baseline for patch experiment%%%REMEBER TO REMOVE AFTER PATCH
%baseline=zeros(1,base*HW.Fso);%%sec baseline for patch experiment%%%REMEBER TO REMOVE AFTER PATCH
pulselens=fix(stim_structure.pulse_dur/1000*HW.Fso);
ipilens=fix(stim_structure.ipi/1000*HW.Fso);
pulsewv=zeros(1,ipilens);
pulsewv(1:pulselens)=1;
num_ppt=stim_structure.num_ppt;
pulsewv=repmat(pulsewv,1,num_ppt);pulsewv=HW.Amplitude*pulsewv;%pulsewv=[baseline pulsewv]; %%sec baseline for patch experiment%%%REMEBER TO REMOVE AFTER PATCH
%eval(sprintf('[STIMS]=File_%s_Generate(stim_structure,HW);',stim_structure.type))
current_string='Stimulus Ready';
set(PP_handles.disp_status,'String',current_string)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Image Params %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IMG.frames_lines_per_iter=stim_structure.stim_protocol.total_frames_lines; 
% tfcount=IMG.frames_lines_per_iter;
% IMG.trig_frames_lines=stim_structure.stim_protocol.stim_start; 
% 
% IMG.total_iters=STIMS.lines_per_set*STIMS.rep_sets;
fdurs=stim_structure.frame_duration;
% fdursamp=fdurs*HW.Fso;
t_iters=stim_structure.num_reps;%IMG.total_iters;
stim_fnums=stim_structure.stim_at_fnums;trig_frame=stim_fnums;
tfcount=stim_structure.total_fcount;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TC=2^24;

%%%%%%%% SELECT BOARD COUNTER AND VALUES FOR MAX SPEED%%%%%%%%
if stim_structure.max_speed_check==0
    CTR_BOARD=1;CTR_TRIG=TC-trig_frame;CTR_RESET=tfcount-trig_frame;pause_del=0.05;
elseif stim_structure.max_speed_check==1
    CTR_BOARD=2;CTR_TRIG=TC-trig_frame+1;CTR_RESET=tfcount-trig_frame+1;pause_del=0;
end

finished_stim=0;

%%%% for COUNTER
param = loadNI;
%fcount=[trig_frame 1000000];
%t_iters
for iter=1:t_iters
    line_num=iter;%rem(iter,STIMS.lines_per_set);rep_num=floor(iter/STIMS.lines_per_set)+1;
        
    %%% Display
    eval(sprintf('current_string=''Now at Repetition %i '';',iter))
    set(PP_handles.disp_status,'String',current_string)
    
    iLoopCount = 1000000;        %Number of times to check the counter's value
    %Hardware configuration
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
    if stim_structure.max_speed_check==0
        iStatus = GPCTR_Change_Parameter(CTR_BOARD, counterNum, param.ND_SOURCE_POLARITY, ...
            param.ND_LOW_TO_HIGH);
    elseif stim_structure.max_speed_check==1
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
    %%%%%%%%%%%%%% LOADING STIMULUS %%%%%%%%%%%%%%%%%% 
    load interrupt_estim
    if interrupt_estim==0
        putdata(HW.ao,pulsewv')
        start([HW.ai HW.ao])
    else
        set(PP_handles.disp_status,'String','Interrupted Electrical Stimulation')
        interrupt_estim=0;
        save interrupt_estim interrupt_estim
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
        %close(HW.atten_handle)
        ao=analogoutput('nidaq',HW.boardID2);
        cho=addchannel(ao,[1]);
        putdata(ao,zeros(1000,1))
        start(ao)
        pause(.1)
        daqreset
        return
    end
    
    %    /* Loop iLoopCount times. */
    cycle_start_time = -1; started_stimulus = false; % PVW000001
     for count=1:iLoopCount
        %Get the counter value
        iStatus = GPCTR_Watch(CTR_BOARD, counterNum, param.ND_COUNT, ...
            pulCount);
        if ~started_stimulus && pulCount.value==1 % PVW000001
            %if pulCount.value==1
            %eval(sprintf('current_string=''Started Stimulus (ITER # %i ...) at frame # %i'';',iter,trig_frame))
            current_string = sprintf('Started Stimulus (ITER # %i ...) at frame # %i',iter,trig_frame);
            display(sprintf('%s',current_string));
            set(PP_handles.disp_status,'String',current_string)
            pause(0.002)
            started_stimulus = true; % PVW000001
        end

        % PVW000001
        % start 'software timer' after first frame trigger received.
        if (cycle_start_time<0)
            if (pulCount.value>CTR_TRIG)
                cycle_start_time = now;
                current_string = sprintf('First trigger (ITER # %i ...)',iter);
                set(PP_handles.disp_status,'String',current_string)
                display(sprintf('%s',current_string));
                pause(0.002)
            end
            is_cycle_time_ellapsed = false;
        else
            cycle_cur_time = now;
            cycle_tot_time = (cycle_cur_time - cycle_start_time)*86400; % 86400 is seconds in a day
            is_cycle_time_ellapsed = (cycle_tot_time>=(fdurs*tfcount));
        end

        %pulCount.value
        iStatus = GPCTR_Watch(CTR_BOARD, counterNum, param.ND_COUNT, ...
            pulCount);
        %if pulCount.value==(CTR_RESET)
        if is_cycle_time_ellapsed % PVW000001
            iStatus = GPCTR_Control(CTR_BOARD, counterNum, param.ND_RESET);
            %pause(fdurs+pause_del)
            fprintf('\nDone')
            %%%%%%%%%%%%%% GETTING TRIG INPUTS %%%%%%%%%%%%%%%
            
            load interrupt_estim
            if interrupt_estim==0
                stop([HW.ai HW.ao])

                % PVW000001
                %eval(sprintf('current_string=''DONE (ITER # %i ...) '';',iter))
                if pulCount.value==(CTR_RESET)
                    current_string = sprintf('DONE (ITER # %i ...) trig_ctr=%d rst=%d',...
                        iter,pulCount.value,CTR_RESET);
                else
                    current_string = sprintf('WARNING (ITER # %i ...) trig_ctr=%d rst=%d',...
                        iter,pulCount.value,CTR_RESET);
                    % xxx - report this in PP struct somehow?
                end
                display(sprintf('%s',current_string));
                display(sprintf('\tcycle time = %0.6f',cycle_tot_time));

                set(PP_handles.disp_status,'String',current_string)
                pause(0.002)
                eval(sprintf('trig_inputs.iter%i=getdata(HW.ai,HW.ai.SamplesAcquired);',iter))
                break
            else
                set(PP_handles.disp_status,'String','Interrupted Electrical Stimulation')
                interrupt_estim=0;
                save interrupt_estim interrupt_estim
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
                %close(HW.atten_handle)
                ao=analogoutput('nidaq',HW.boardID2);
                cho=addchannel(ao,[1]);
                putdata(ao,zeros(1000,1))
                start(ao)
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

unloadNI
daqreset
    
    
    
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
