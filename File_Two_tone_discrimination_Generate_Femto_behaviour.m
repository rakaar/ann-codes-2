function [STIMS,stim_structure]=File_TonePipSweep_Generate_Femto_behaviour(stim_structure,HW)




nfs=1;
nas=1;
RF=stim_structure.stim_protocol.rf;NRF=stim_structure.stim_protocol.nrf;
ll=stim_structure.stim_protocol.atten;lh=stim_structure.stim_protocol.atten
pipd=stim_structure.stim_protocol.pip_dur;
ipi=stim_structure.stim_protocol.inter_pip_int;
npips=stim_structure.stim_protocol.num_pips;


% following parameters for all stimuli %%%%%%%%%%%%%%%%%%%%%%%
STIMS.duration=npips*ipi;
STIMS.lines_per_set=nfs*nas;
STIMS.rep_sets=stim_structure.stim_protocol.reps;
if stim_structure.left_check==1
    STIMS.ATTENS.Left=reshape(repmat(linspace(ll,lh,nas),nfs,1),1,nfs*nas);
    STIMS.ATTENS.Right=[];
elseif stim_structure.right_check==1
    STIMS.ATTENS.Right=reshape(repmat(linspace(ll,lh,nas),nfs,1),1,nfs*nas);
    STIMS.ATTENS.Left=[];
elseif stim_structure.both_check==1
    STIMS.ATTENS.Left=reshape(repmat(linspace(ll,lh,nas),nfs,1),1,nfs*nas);
    STIMS.ATTENS.Right=reshape(repmat(linspace(ll,lh,nas),nfs,1),1,nfs*nas);
end
STIMS.hard=1; % when 1 returns actual stimuli in STIMS.waveform.line1,2,3 etc
              % when 0 stimuli will be generated on the fly
              % when -1 stimuli will be loaded from designated directory on
              % the fly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

STIMS.rise_fall_time=min([.01 (stim_structure.stim_protocol.pip_dur)/10]);

STIMS.freqs=[RF NRF];

Fs=HW.Fso;STIMS.Fs=HW.Fso;
tp=[0:(1/Fs):(ipi-1/Fs)];tpip=[0:(1/Fs):(pipd-1/Fs)];

for line_num=1:2
    om=2*pi*STIMS.freqs(line_num);
    y=sin(om*tpip);
    %y=-sin(om*tpip);
    y=aud_gate_on(y,STIMS.rise_fall_time*1000,Fs);
    y=aud_gate_off(y,STIMS.rise_fall_time*1000,Fs);
    y=[y zeros(1,length(tp)-length(y))];y=repmat(y,1,npips);
    eval(sprintf('STIMS.waveform.line%i=y'';',line_num))
%      sprintf('%i'';',Fs)
    
end
    