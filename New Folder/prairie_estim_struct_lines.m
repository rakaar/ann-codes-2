function [finished_stim]=prairie_estim_struct_lines(stim_structure,PP_handles)

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
frame_max_speed=0;
save frame_max_speed frame_max_speed
[HW]=HWinit(wtd_val);% Hardware initialized

%Generate stimulation waveform %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pulselens=fix(stim_structure.pulse_dur/1000*HW.Fso);
ipilens=fix(stim_structure.ipi/1000*HW.Fso);
pulsewv=zeros(1,ipilens);
pulsewv(1:pulselens)=1;
num_ppt=stim_structure.num_ppt;
pulsewv=repmat(pulsewv,1,num_ppt);pulsewv=HW.Amplitude*pulsewv;pulsewv=pulsewv';
%eval(sprintf('[STIMS]=File_%s_Generate(stim_structure,HW);',stim_structure.type))
current_string='Stimulus Ready';
set(PP_handles.disp_status,'String',current_string)
pause(.002)

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
finished_stim=0;
param = loadNI;
%fcount=[trig_frame 1000000];
set(HW.ai,'Triggertype','Immediate')
set(HW.ao,'Triggertype','Immediate')

%t_iters
  
    
iLoopCount = 1000000;        %Number of times to check the counter's value
%Hardware configuration
counterNum1 = param.ND_COUNTER_0;    %The ID for the counter frame
%Define pointers to get data back from the counter
fmt = 'uint32Ptr';      % Pointer format string
iStatus = GPCTR_Control(HW.boardID1, counterNum1, param.ND_RESET);
pulCount1 = libpointer(fmt,0);
iStatus = GPCTR_Set_Application(HW.boardID1, counterNum1, ...
    param.ND_SIMPLE_EVENT_CNT);
iStatus = GPCTR_Change_Parameter(HW.boardID1, counterNum1, param.ND_SOURCE, ...
    param.ND_DEFAULT_PFI_LINE);
iStatus = GPCTR_Change_Parameter(HW.boardID1, counterNum1, param.ND_SOURCE_POLARITY, ...
    param.ND_HIGH_TO_LOW);
iStatus = Select_Signal(HW.boardID1,param.ND_GPCTR0_OUTPUT, param.ND_GPCTR0_OUTPUT, ...
    param.ND_DONT_CARE);
iStatus = GPCTR_Change_Parameter(HW.boardID1, counterNum1, ...
    param.ND_INITIAL_COUNT, pulCount1.value);
iStatus = GPCTR_Control(HW.boardID1, counterNum1, param.ND_PROGRAM);
%%%%%%%%%%%%%%%%% COUNTER1
counterNum2 = param.ND_COUNTER_1;    %The ID for the counter line
iStatus = GPCTR_Set_Application(HW.boardID1, counterNum2, ...
    param.ND_SIMPLE_EVENT_CNT);
iStatus = GPCTR_Change_Parameter(HW.boardID1, counterNum2, param.ND_SOURCE, ...
    param.ND_DEFAULT_PFI_LINE);
iStatus = Select_Signal(HW.boardID1,param.ND_GPCTR1_OUTPUT, param.ND_GPCTR1_OUTPUT, ...
    param.ND_LOW_TO_HIGH);
started=0;%armed_started=0;
%%%%%% LOAD STIMULUS FOR ITER 1
iter=1;
line_num=iter;
eval(sprintf('current_string=''Now at Repetition %i '';',iter))
set(PP_handles.disp_status,'String',current_string)
    
    load interrupt_estim
    if interrupt_estim==0
        putdata(HW.ao,pulsewv)
        set(HW.ai,'Triggertype','HWDigital')
        set(HW.ao,'Triggertype','HWDigital')
        start([HW.ai HW.ao])
    else
        set(PP_handles.disp_status,'String','Interrupted Electrical Stimulation')
        interrupt_estim=0;
        save interrupt_estim interrupt_estim
        iStatus = GPCTR_Control(HW.boardID1, counterNum, param.ND_RESET);
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
    frame=0;
    for count=1:iLoopCount
        %Get the counter value
        iStatus = GPCTR_Watch(HW.boardID1, counterNum1, param.ND_COUNT, ...
            pulCount1);
        
        %%%%%%%%%%%%%% LOADING STIMULUS %%%%%%%%%%%%%%%%%% 
        %%%%%%%%%%%%%% GETTING TRIG INPUTS %%%%%%%%%%%%%%%
        %%%%%%%%%%%%%% AT 3 frames before trig frame %%%%%
        %pulCount1.value
        if (pulCount1.value==1)
            frame=frame+1;
            if frame~=1
                iter=iter+1;
                load interrupt_estim
                if interrupt_estim==0
                    stop(HW.ai)
                    eval(sprintf('current_string=''DONE (ITER # %i ...) '';',frame-1))
                    set(PP_handles.disp_status,'String',current_string)
                    pause(0.002)
                    eval(sprintf('trig_inputs.iter%i=getdata(HW.ai,HW.ai.SamplesAcquired);',frame-1))
                    line_num=iter;
                    eval(sprintf('current_string=''Now at Repetition %i'';',iter))
                    set(PP_handles.disp_status,'String',current_string)
                    
                    putdata(HW.ao,pulsewv)
                    start([HW.ai,HW.ao])
                else
                    set(PP_handles.disp_status,'String','Interrupted Electrical Stimulation')
                    interrupt_estim=0;
                    save interrupt_estim interrupt_estim
                    iStatus = GPCTR_Control(HW.boardID1, counterNum, param.ND_RESET);
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
                    ao=analogoutput('nidaq',HW.boardID2);
                    cho=addchannel(ao,[1]);
                    putdata(ao,zeros(1000,1))
                    start(ao)
                    pause(.1)
                    daqreset
                    return
                end
                    
            end
            prairie_estim_start_line_counter(trig_frame,HW)
            % DONE STIM PRESENTATION
            eval(sprintf('current_string=''Presented Stimulus (ITER # %i ...) '';',iter))
            set(PP_handles.disp_status,'String',current_string)
            pause(0.002)
            
            
            fmt = 'uint32Ptr';      % Pointer format string
            iStatus = GPCTR_Control(HW.boardID1, counterNum1, param.ND_RESET);
            pulCount1 = libpointer(fmt,0);
            iStatus = GPCTR_Set_Application(HW.boardID1, counterNum1, ...
                param.ND_SIMPLE_EVENT_CNT);
            iStatus = GPCTR_Change_Parameter(HW.boardID1, counterNum1, param.ND_SOURCE, ...
                 param.ND_DEFAULT_PFI_LINE);
            iStatus = GPCTR_Change_Parameter(HW.boardID1, counterNum1, param.ND_SOURCE_POLARITY, ...
                param.ND_HIGH_TO_LOW);
%             iStatus = Select_Signal(1,param.ND_GPCTR0_OUTPUT, param.ND_GPCTR0_OUTPUT, ...
%                 param.ND_DONT_CARE);
            iStatus = GPCTR_Change_Parameter(HW.boardID1, counterNum1, ...
                param.ND_INITIAL_COUNT, pulCount1.value);
            iStatus = GPCTR_Control(HW.boardID1, counterNum1, param.ND_PROGRAM);
            
        end
        
        if frame==t_iters
            pause(fdurs*tfcount+.05)
            load interrupt_estim
            if interrupt_estim==0
                stop(HW.ai)
                eval(sprintf('current_string=''DONE (ITER # %i ...) '';',frame))
                set(PP_handles.disp_status,'String',current_string)
                pause(0.002)
                eval(sprintf('trig_inputs.iter%i=getdata(HW.ai,HW.ai.SamplesAcquired);',frame))
                break
            else
                set(PP_handles.disp_status,'String','Interrupted Electrical Stimulation')
                interrupt_estim=0;
                save interrupt_estim interrupt_estim
                iStatus = GPCTR_Control(HW.boardID1, counterNum, param.ND_RESET);
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
finished_stim=1;
trig_inputs.Fsi=HW.Fsi;
save trig_inputs trig_inputs %change in 

unloadNI
daqreset


