function [finished_stim,OptoParams]=prairie_OptovisLED_struct(OptoParams,PP_handles)

% Example EStim Structure 
% stim_structure
% VisLEDStimPARAMS = 
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

wtd_val=get(PP_handles.what_to_do,'Value');
[HW]=HWinitRX6(wtd_val);% Hardware initialized
stim_structure=OptoParams.VIS;
%%% [1 0 0] VISUAL STIMULATION ONLY
HW.Fso=HW.Fso2;
total_time=stim_structure.total_time;
totsamps=fix(total_time*HW.Fso)+100;
start_time=stim_structure.stim_start;
start_samp=fix(start_time*HW.Fso)+1;
pulsewf=zeros(1,fix(total_time*HW.Fso));
max_stim_samps=length(pulsewf)-start_samp+1;
if stim_structure.check_vssa==0
    nsteps=stim_structure.num_int_steps;
    ints=logspace(log10(stim_structure.start_int),log10(stim_structure.stop_int),nsteps);
else
    nsteps=1;
    ints=stim_structure.ssa_intensity;
end
intsf=ints;%%% Decide based on calibration and log scale
nreps=stim_structure.num_reps_set;
allints=repmat(intsf,1,nreps);
t_iters=nsteps*nreps;
%%%%%% [1 0 0]
if stim_structure.check_led1==1
    one_blink=[ones(1,fix(stim_structure.blink_dur*HW.Fso)) zeros(1,fix(stim_structure.inter_blink_int*HW.Fso))];
    thrsd=0;
elseif stim_structure.check_led2==1
    one_blink=[-ones(1,fix(stim_structure.blink_dur*HW.Fso)) zeros(1,fix(stim_structure.inter_blink_int*HW.Fso))];
    thrsd=-0;    
elseif stim_structure.check_vssa==1
    if stim_structure.check_LED2_stimB==1
        one_blink=[ones(1,fix(stim_structure.blink_dur*HW.Fso)) zeros(1,fix(stim_structure.inter_blink_int*HW.Fso))];
    elseif stim_structure.check_LED1_stimB==1
        one_blink=[-ones(1,fix(stim_structure.blink_dur*HW.Fso)) zeros(1,fix(stim_structure.inter_blink_int*HW.Fso))];
    end
end
allstims=repmat(one_blink,1,stim_structure.n_blinks);
if stim_structure.check_vssa==1
    devpos=stim_structure.stimB_pos;
    allstims(((devpos-1)*length(one_blink)+1):devpos*length(one_blink))=-allstims(((devpos-1)*length(one_blink)+1):devpos*length(one_blink));
end

stimulus=allstims;
current_string='Stimulus Ready';
set(PP_handles.disp_status,'String',current_string)
pause(0.05)
finished_stim=0;
check_gap=stim_structure.check_gap;
gap_time=stim_structure.gap_dur;

HW.triggerpulse=[HW.triggerpulse zeros(1,fix(total_time*HW.Fsi)+100)]';

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

% one_blinkO=[ones(1,fix(stim_structureOpto.stim_dur*HW.Fso2)) zeros(1,fix(stim_structureOpto.isi_dur*HW.Fso2))];
%%%%%%%%%%%%%%%modulatory square wave 1khz 82% duty cycle for 598nm(Arch)%%%%%%%%
  if OptoParams.check589nm==1
    modulate_time=0:1/HW.Fso2:(stim_structureOpto.stim_dur);
modulate_wav=square(2*pi*1000*modulate_time,82);%82% duty cycle 1khz square waveform
    one_blinkO=[modulate_wav];
    else
       one_blinkO=[ones(1,fix(stim_structureOpto.stim_dur*HW.Fso2))];
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% one_blinkO=[ones(1,fix(stim_structureOpto.stim_dur*HW.Fso2))];

allstimsO=repmat(one_blinkO,1,stim_structureOpto.n_stims);

stimulusO=allstimsO;
current_string='Opto Stimulus Also Ready';
set(PP_handles.disp_status,'String',current_string)
pause(0.5)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for iter=1:t_iters
    line_num=iter;%rem(iter,STIMS.lines_per_set);rep_num=floor(iter/STIMS.lines_per_set)+1;
    zeroslen=zeros(1,totsamps+100)';    
    %%% Display
    eval(sprintf('current_string=''Now at Iter %i of %i'';',iter,t_iters))
    set(PP_handles.disp_status,'String',current_string)
    
    
    %%%%%%%%%%%%%% LOADING STIMULUS %%%%%%%%%%%%%%%%%%
    started=0;
    load interrupt_vis
    if interrupt_vis==0
%         stop([HW.ai HW.ao])
%         putdata(HW.ao,pulsewv')
%         putvalue(HW.dio.Line(1),[1]);
%         set(HW.ai,'SamplesPerTrigger',fix(total_line_duration*HW.Fsi)+100) %%%%%%%% ***** CHECK
%         start([HW.ao HW.ai])
        %figure
        stimu=stimulus;
        stimu(find(stimulus~=0))=stimulus(find(stimulus~=0))*allints(iter);
%         plot([zeros(start_samp,1);stimu'])
        STIMULUS=[zeros(start_samp,1);stimu'];
            
        stimuO=stimulusO;
        stimuO(find(stimulusO~=0))=stimulusO(find(stimulusO~=0))*allintsO(iter);
        STIMULUSO=[zeros(start_samp,1);stimuO'];
        
        figure(100);clf
        plot((1:length(STIMULUS))/HW.Fso,STIMULUS,'g')
        hold on
        plot((1:length(STIMULUSO))/HW.Fso2,STIMULUSO,'r')
        
        zeroslen2=zeros(1,totsamps+100)';
        zeroslen2(1:length(STIMULUSO))=STIMULUSO;
            
        if totsamps<length([zeros(start_samp,1);stimu'])
            %%% add default 500 ms to stimulus duration with starting time
            extrasamps=fix(0.5*HW.Fso);
            totsamps=length([zeros(start_samp,1);stimu'])+extrasamps;
            zeroslen=zeros(1,totsamps+100)';
            stim_structure.total_time=fix(totsamps/HW.Fso);
            set(PP_handles.disp_status,'String','Adjusted total time to fit in entire stimulus')
            pause(0.2)
        end
        
        zeroslen(1:length([zeros(start_samp,1);stimu']))=[zeros(start_samp,1);stimu'];
        HW.SS.queueOutputData([zeroslen zeroslen2]);
    else
            
        set(PP_handles.disp_status,'String','Interrupted Visual Stimulation')
        interrupt_vis=0;
        save interrupt_vis interrupt_vis
        
        daqreset
        finished_stim=-1;
        if exist('trig_inputs')
            save trig_inputs trig_inputs
        else
            trig_inputs=[];
            save trig_inputs trig_inputs
        end
        %close(HW.atten_handle)
        %ao=analogoutput('nidaq',HW.boardID2);
        %cho=addchannel(ao,[1]);
        %putdata(ao,zeros(1000,1))
        %start(ao)
        pause(.1)
        HW.SS.release();
        daqreset
        return
    end
    %%%%%%%%%%%%%% PLAYING STIMULUS %%%%%%%%%%%%%%%%%% 
    %%%%%%%%%%%%%% STARTING ACQUISITION %%%%%%%%%%%%%%
    eval(sprintf('current_string=''Started Stimulus (Iter # %i ...) '';',iter))
    set(PP_handles.disp_status,'String',current_string)
    started=1;
    pause(0.002)
    eval(sprintf('trig_inputs.iter%i=HW.SS.startForeground;',iter))%trig_inputs.iter%i=
    %putvalue(HW.dio.Line(1),[0]);
    pause(.003)
    %putvalue(HW.dio.Line(1),[1]); % reset trigger line
    %%%%%%%%%%%%%% ENDING LINE %%%%%%%%%%%%%%%%%% 
    %%%%%%%%%%%%%% STOP ACQUISITION %%%%%%%%%%%%%
    while HW.SS.IsRunning
        1000000+1000000;
    end
    %waittilstop([HW.ai],100)    
    eval(sprintf('current_string=''DONE (Iter # %i ...) '';',iter))
    pause(.002)
    %eval(sprintf('trig_inputs.iter%i=getdata(HW.ai,HW.ai.SamplesAcquired);',iter))
    set(PP_handles.disp_status,'String',current_string)
    if check_gap&iter~=t_iters
        eval(sprintf('current_string=''DONE (ITER # %i ...); Waiting for ... %5.2f seconds '';',iter,gap_time))
        set(PP_handles.disp_status,'String',current_string)
        pause(gap_time)
    end
end

finished_stim=1;
trig_inputs.Fsi=HW.Fsi;
save trig_inputs trig_inputs %change in 
HW.SS.release();
daqreset
setdaqout0
           

    
    
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
