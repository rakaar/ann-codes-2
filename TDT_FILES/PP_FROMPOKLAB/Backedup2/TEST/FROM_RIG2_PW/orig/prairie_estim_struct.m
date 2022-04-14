function [finished_stim]=prairie_estim_struct(stim_structure,PP_handles)

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
pulsewv=zeros(1,ipilens);%blankingpulsewv=zeros(1,ipilens);

%%%% additional 0.1 ms to follow for blanking
%%%% and additional 0.5 ms before for blanking
%%%% so shift stimulation time by 0.5 ms
addblanksamps=fix(10/1000*HW.Fso);
addblanksampsbefore=fix(10/1000*HW.Fso);
pulsewv((1):(pulselens))=1;
%size(pulsewv)
%blankingpulsewv(1:(pulselens+addblanksamps+addblanksampsbefore-1))=1;
%size(blankingpulsewv)
pulsewv=[pulsewv];%;blankingpulsewv];
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
stim_start=stim_structure.frame_duration;
% fdursamp=fdurs*HW.Fso;
t_iters=stim_structure.num_reps;%IMG.total_iters;
%stim_fnums=stim_structure.stim_at_fnums;trig_frame=stim_fnums;
total_line_duration=stim_structure.total_fcount;
stim_start_samp=stim_start*HW.Fso;
pulsewv=[zeros(fix(stim_start_samp),1)' pulsewv]; %%%% insert initial zeros for fixed start time

% figure 
% plot(pulsewv')
finished_stim=0;

% %%%% for COUNTER
% param = loadNI;
% %fcount=[trig_frame 1000000];
% %t_iters
for iter=1:t_iters
    line_num=iter;%rem(iter,STIMS.lines_per_set);rep_num=floor(iter/STIMS.lines_per_set)+1;
        
    %%% Display
    eval(sprintf('current_string=''Now at Repetition %i '';',iter))
    set(PP_handles.disp_status,'String',current_string)
    
    
    %%%%%%%%%%%%%% LOADING STIMULUS %%%%%%%%%%%%%%%%%%
    started=0;
    load interrupt_estim
    if interrupt_estim==0
        stop([HW.ai HW.ao])
        putdata(HW.ao,pulsewv')
        putvalue(HW.dio.Line(1),[1]);
        set(HW.ai,'SamplesPerTrigger',fix(total_line_duration*HW.Fsi)+100) %%%%%%%% ***** CHECK
        start([HW.ao HW.ai])
    else
            
        set(PP_handles.disp_status,'String','Interrupted Electrical Stimulation')
        interrupt_estim=0;
        save interrupt_estim interrupt_estim
        
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
    %%%%%%%%%%%%%% PLAYING STIMULUS %%%%%%%%%%%%%%%%%% 
    %%%%%%%%%%%%%% STARTING ACQUISITION %%%%%%%%%%%%%%
    eval(sprintf('current_string=''Started Stimulus (REP # %i ...) '';',iter))
    set(PP_handles.disp_status,'String',current_string)
    started=1;
    pause(0.002)
    putvalue(HW.dio.Line(1),[0]);
    pause(.003)
    putvalue(HW.dio.Line(1),[1]); % reset trigger line
    %%%%%%%%%%%%%% ENDING LINE %%%%%%%%%%%%%%%%%% 
    %%%%%%%%%%%%%% STOP ACQUISITION %%%%%%%%%%%%%
    waittilstop([HW.ai],100)    
    eval(sprintf('current_string=''DONE (REP # %i ...) '';',iter))
    pause(.002)
    eval(sprintf('trig_inputs.iter%i=getdata(HW.ai,HW.ai.SamplesAcquired);',iter))
    set(PP_handles.disp_status,'String',current_string)
end

finished_stim=1;
trig_inputs.Fsi=HW.Fsi;
save trig_inputs trig_inputs %change in 
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
