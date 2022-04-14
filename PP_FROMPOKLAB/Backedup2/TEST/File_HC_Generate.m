function [STIMS]=File_HC_Generate(stim_structure,HW)

%this code specific for TonePipSweep
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
% stim_structure.stim_protocol
%              frame_dur: 0.2000
%                pip_dur: 0.1250
%     total_frames_lines: 25
%             stim_start: 11
%                ipi_val: 0.2500
%                freq_lo: 10000
%                freq_hi: 40000
%         num_freq_steps: 9
%               level_lo: 30
%               level_hi: 10
%          num_att_steps: 3
%        npips_per_train: 4
%             total_reps: 5


nfs=stim_structure.stim_protocol.num_freq_steps;
nas=stim_structure.stim_protocol.num_att_steps;
numhc=stim_structure.stim_protocol.numhc;
fl=stim_structure.stim_protocol.freq_lo;fh=stim_structure.stim_protocol.freq_hi;
ll=stim_structure.stim_protocol.level_lo;lh=stim_structure.stim_protocol.level_hi;
pipd=stim_structure.stim_protocol.pip_dur;
ipi=stim_structure.stim_protocol.ipi_val;
npips=stim_structure.stim_protocol.npips_per_train;


% following parameters for all stimuli %%%%%%%%%%%%%%%%%%%%%%%
STIMS.duration=npips*ipi;
STIMS.lines_per_set=nfs*nas;
STIMS.rep_sets=stim_structure.stim_protocol.total_reps;
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

STIMS.freqs=repmat(logspace(log10(fl),log10(fh),nfs),1,nas);

Fs=HW.Fso;STIMS.Fs=HW.Fso;
tp=[0:(1/Fs):(ipi-1/Fs)];tpip=[0:(1/Fs):(pipd-1/Fs)];
maxy=0;
for line_num=1:nfs*nas
    %line_num
    om=2*pi*STIMS.freqs(line_num);
    y=zeros(size(tpip));
    for nhcc=1:numhc
        %nhcc
        y=y+sin(nhcc*om*tpip);
    end
    %figure(2011)
    %plot(y)
    %y=-sin(om*tpip);
    y=aud_gate_on(y,STIMS.rise_fall_time*1000,Fs);
    y=aud_gate_off(y,STIMS.rise_fall_time*1000,Fs);
    y=[y zeros(1,length(tp)-length(y))];y=repmat(y,1,npips);
    maxy=max([maxy max(abs(y))]);
    eval(sprintf('STIMS.waveform.line%i=y'';',line_num))
end
for line_num=1:nfs*nas
    %line_num
    eval(sprintf('STIMS.waveform.line%i=(1/maxy)*STIMS.waveform.line%i;',line_num,line_num))
end
STIMS.norm_factor=maxy;
%save STIMS STIMS
%save STIMS STIMS