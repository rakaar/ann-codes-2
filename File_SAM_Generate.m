function [STIMS,stim_structure]=File_SAM_Generate(stim_structure,HW)

% this code specific for TonePipSweep
% Example Stim Structure
% stim_structure
%         left_check: 0
%        right_check: 1
%         both_check: 0
%        frame_check: 1
%     linescan_check: 0
%               type: 'SAM'
%      stim_protocol: [1x1 struct]
%       protocol_str: [1x134 char]
% 
% stim_structure.stim_protocol
%              frame_dur: 0.3000
%     total_frames_lines: 25
%             stim_start: 11
%               level_lo: 50
%               level_hi: 10
%          num_att_steps: 5
%             total_reps: 5
%             tone_check: 1
%            noise_check: 0
%                 To_flo: 6000
%                 To_fhi: 48000
%               mod_freq: 10
%              mod_depth: 1
%         num_freq_steps: 13
%                 No_fhi: 48000
%                 No_flo: 6000
%                    dur: 0.8000

if stim_structure.stim_protocol.tone_check==1
    nfs=stim_structure.stim_protocol.num_freq_steps;
else
    nfs=1;
end
nas=stim_structure.stim_protocol.num_att_steps;
tofl=stim_structure.stim_protocol.To_flo;tofh=stim_structure.stim_protocol.To_fhi;
nofl=stim_structure.stim_protocol.No_flo;nofh=stim_structure.stim_protocol.No_fhi;
ll=stim_structure.stim_protocol.level_lo;lh=stim_structure.stim_protocol.level_hi;
fm=stim_structure.stim_protocol.mod_freq;md=stim_structure.stim_protocol.mod_depth;
dur=stim_structure.stim_protocol.dur;


% following parameters for all stimuli %%%%%%%%%%%%%%%%%%%%%%% change
% specific values as needed
STIMS.duration=dur;
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

STIMS.rise_fall_time=min([0.01 (stim_structure.stim_protocol.dur)/10]);

if stim_structure.stim_protocol.tone_check==1
    STIMS.freqs=repmat(logspace(log10(tofl),log10(tofh),nfs),1,nas);
else
    STIMS.freqs='BandpassNoise';
end
    

Fs=HW.Fso;STIMS.Fs=HW.Fso;
tp=[0:(1/Fs):(dur-1/Fs)];

if stim_structure.stim_protocol.tone_check==1
    for line_num=1:nfs*nas
        om=2*pi*STIMS.freqs(line_num);
        y=sin(om*tp);ym=sin(2*pi*fm*tp-pi/2);
        y=0.5*(1+md*ym).*y;y=y*(1/max(abs(y))); %%%%%%%%%%%% Fix level based on RMS LATER
        y=aud_gate_on(y,STIMS.rise_fall_time*1000,Fs);
        y=aud_gate_off(y,STIMS.rise_fall_time*1000,Fs);
        eval(sprintf('STIMS.waveform.line%i=y'';',line_num))
    end
else
    %frozen noise flo-fhi frequency
    N=length(tp);
    [Noise_wf]=BandPassNoise(N,Fs,nofl,nofh);
    y=Noise_wf*(1/max(abs(Noise_wf)));
    ym=sin(2*pi*fm*tp-pi/2);
    y=.5*(1+md*ym).*y;y=y/(max(abs(y))); %%%%%%%%%%%% Fix level based on RMS LATER
    y=aud_gate_on(y,STIMS.rise_fall_time*1000,Fs);
    y=aud_gate_off(y,STIMS.rise_fall_time*1000,Fs);
    for line_num=1:1*nas
        eval(sprintf('STIMS.waveform.line%i=y'';',line_num))
    end
end    