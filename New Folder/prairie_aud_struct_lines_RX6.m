function [finished_stim]=prairie_aud_struct_lines_RX6(stim_structure,PP_handles)

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
frame_max_speed=0;
save frame_max_speed frame_max_speed
[HW]=HWinitRX6(wtd_val);% Hardware initialized

%Generate stimuli %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
eval(sprintf('[STIMS]=File_%s_Generate(stim_structure,HW);',stim_structure.type))
current_string='Stimulus Ready';
set(PP_handles.disp_status,'String',current_string)
pause(.002)
%% GENERAL parameters in STIMS
% STIMS.lines_per_set
% STIMS.rep_sets
% STIMS.ATTENS.Left
% STIMS.ATTENS.Right
% STIMS.hard=1;
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TC=2^24;
finished_stim=0;
param = loadNI;
%fcount=[trig_frame 1000000];
set(HW.ai,'Triggertype','Immediate')
%set(HW.ao,'Triggertype','Immediate') %%% ??? UNSURE WHY THIS WAS NEEDED

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
line_num=rem(iter,STIMS.lines_per_set);rep_num=floor(iter/STIMS.lines_per_set)+1;
if line_num==0
    line_num=STIMS.lines_per_set;
    rep_num=rep_num-1;
end
eval(sprintf('current_string=''Now at Iter %i of %i, Rep %i of %i, Line %i of Set of %i Lines!'';',iter,t_iters,rep_num,STIMS.rep_sets,line_num,STIMS.lines_per_set))
set(PP_handles.disp_status,'String',current_string)
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
        stimulus=stimulus*HW.Amplitude;
        if stim_structure.left_check==1
            stimulus=[stimulus zeros(size(stimulus))];
        elseif stim_structure.right_check==1
            stimulus=[zeros(size(stimulus)) stimulus];
        elseif stim_structure.both_check==1
            stimulus=[stimulus stimulus];
        end
    else
        %%%WRITE CODE%%%% For hard parameter= 0 and -1
    end
    load interrupt_aud
    if interrupt_aud==0
        %putdata(HW.ao,stimulus)
        set(HW.ai,'Triggertype','HWDigital')
        %set(HW.ao,'Triggertype','HWDigital')
        trigPlay_2CH(stimulus(:,1)',stimulus(:,2)',HW.RX6.fso)
        start([HW.ai])
    else
        set(PP_handles.disp_status,'String','Interrupted Auditory Stimulation')
        interrupt_aud=0;
        save interrupt_aud interrupt_aud
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
%         ao=analogoutput('nidaq',HW.boardID1);
%         cho=addchannel(ao,[0 1]);
%         putdata(ao,zeros(1000,2))
%         start(ao)
%         pause(.1)
%         daqreset
        RX6_gPL.SetTagVal('Enable',0); RX6_gPL.Halt;
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
                load interrupt_aud
                if interrupt_aud==0
                    RX6_gPL.SetTagVal('Enable',0); RX6_gPL.Halt;
                    stop(HW.ai)
                    eval(sprintf('current_string=''DONE (ITER # %i ...) '';',frame-1))
                    set(PP_handles.disp_status,'String',current_string)
                    pause(0.002)
                    eval(sprintf('trig_inputs.iter%i=getdata(HW.ai,HW.ai.SamplesAcquired);',frame-1))
                    %eval(sprintf('dd.iter%i=getdata(ai,ai.SamplesAcquired);',frame-1))
                    line_num=rem(iter,STIMS.lines_per_set);rep_num=floor(iter/STIMS.lines_per_set)+1;
                    if line_num==0
                        line_num=STIMS.lines_per_set;
                        rep_num=rep_num-1;
                    end
                    eval(sprintf('current_string=''Now starting Iter %i of %i, Rep %i of %i, Line %i of Set of %i Lines!'';',iter,t_iters,rep_num,STIMS.rep_sets,line_num,STIMS.lines_per_set))
                    set(PP_handles.disp_status,'String',current_string)
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
                        stimulus=stimulus*HW.Amplitude;
                        if stim_structure.left_check==1
                            stimulus=[stimulus zeros(size(stimulus))];
                        elseif stim_structure.right_check==1
                            stimulus=[zeros(size(stimulus)) stimulus];
                        elseif stim_structure.both_check==1
                            stimulus=[stimulus stimulus];
                        end
                    else
                        %%%WRITE CODE%%%% For hard parameter= 0 and -1
                    end
                    %putdata(HW.ao,stimulus)
                    trigPlay_2CH(stimulus(:,1)',stimulus(:,2)',HW.RX6.fso)
                    start([HW.ai])
                else
                    set(PP_handles.disp_status,'String','Interrupted Auditory Stimulation')
                    interrupt_aud=0;
                    save interrupt_aud interrupt_aud
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
%                     ao=analogoutput('nidaq',HW.boardID1);
%                     cho=addchannel(ao,[0 1]);
%                     putdata(ao,zeros(1000,2))
%                     start(ao)
%                     pause(.1)
%                     daqreset
                    RX6_gPL.SetTagVal('Enable',0); RX6_gPL.Halt;
                    return
                end
                    
            end
            prairie_aud_start_line_counter_RX6(trig_frame,HW)
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
            load interrupt_aud
            if interrupt_aud==0
                RX6_gPL.SetTagVal('Enable',0); RX6_gPL.Halt;
                stop(HW.ai)
                eval(sprintf('current_string=''DONE (ITER # %i ...) '';',frame))
                set(PP_handles.disp_status,'String',current_string)
                pause(0.002)
                eval(sprintf('trig_inputs.iter%i=getdata(HW.ai,HW.ai.SamplesAcquired);',frame))
                break
            else
                interrupt_aud=0;
                save interrupt_aud interrupt_aud
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
%                  ao=analogoutput('nidaq',HW.boardID1);
%                  cho=addchannel(ao,[0 1]);
%                  putdata(ao,zeros(1000,2))
%                  start(ao)
%                  pause(.1)
%                  daqreset
                 RX6_gPL.SetTagVal('Enable',0); RX6_gPL.Halt;                 
                 return
             end
        end
        
        pause(.00001);
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
RX6_gPL.SetTagVal('Enable',0); RX6_gPL.Halt;


