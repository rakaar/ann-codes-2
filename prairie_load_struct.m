function [finished_loading]=prairie_load_struct(load_structure,PP_handles)

global interrupt_load; % pwatkins - enable faster stopping

%in seconds
% (duration,nr_pulses,pulse_dt,repetition,rep_dt)
finished_loading=0;Fs=10000;
interrupt_load=0;
save interrupt_load interrupt_load
pause(1)
load_structure
duration=load_structure.puff_dur;
pulse_dt=load_structure.ipi_val;
rep_dt=load_structure.ipti_val;
nr_pulses=load_structure.num_ppt_val;
repetition=load_structure.num_pt_val;
stimtime=(duration+pulse_dt)*nr_pulses;
SS=daq.createSession('ni');
SS.Rate=Fs;
SS.addAnalogOutputChannel('dev1',0,'Voltage');%%% 0 ao top is for loading
% ao = analogoutput('nidaq',2);
% cho=addchannel(ao,0);
% set(ao,'SampleRate',Fs);
aotime=stimtime+0.1;%in ms
aosamples=fix(aotime*Fs);
stimdat=zeros(1,aosamples);
one_puff=[ones(duration*Fs,1);zeros(pulse_dt*Fs,1)];
alldata=repmat(one_puff,nr_pulses,1);
figure(12873); clf
plot(alldata)

for i=1:repetition
    % pwatkins - changed to global
    %load interrupt_load
    if interrupt_load==0
        SS.queueOutputData(alldata);
        SS.startForeground();
    else
        if ishandle(PP_handles.disp_status)
            set(PP_handles.disp_status,'String','Interrupted Loading')
        end
        interrupt_load=0;
        save interrupt_load interrupt_load
        finished_loading=-1;
        return
    end
    eval(sprintf('current_string=''Rep %i/%i %i pulses every %i s, then pausing for %i s'';',i,repetition, nr_pulses,pulse_dt,rep_dt));
    set(PP_handles.disp_status,'String',current_string)
    %pause(rep_dt);
    % pwatkins - enable faster stopping
    tic; while toc<rep_dt, if interrupt_load, break; end, pause(1); end
end
finished_loading=1;
return
