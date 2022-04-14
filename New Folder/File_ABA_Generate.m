function [STIMS,stim_structure]=File_ABA_Generate(stim_structure,HW)

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


toneAfr=stim_structure.stim_protocol.toneAfr;
toneBfr=toneAfr*2^(stim_structure.stim_protocol.Bfr_re_A_octaves);
Adur=stim_structure.stim_protocol.tone_Adur;
Bdur=stim_structure.stim_protocol.tone_Bdur;
gapdur=stim_structure.stim_protocol.gapdur;
atten=stim_structure.stim_protocol.atten;
numABAsets=stim_structure.stim_protocol.num_ABA_sets;



% following parameters for all stimuli %%%%%%%%%%%%%%%%%%%%%%%
STIMS.duration=numABAsets*(2*Adur+Bdur+gapdur);
STIMS.lines_per_set=1;
STIMS.rep_sets=stim_structure.stim_protocol.total_reps;
if stim_structure.left_check==1
    STIMS.ATTENS.Left=atten;
    STIMS.ATTENS.Right=[];
elseif stim_structure.right_check==1
    STIMS.ATTENS.Right=atten;
    STIMS.ATTENS.Left=[];
elseif stim_structure.both_check==1
    STIMS.ATTENS.Left=atten;
    STIMS.ATTENS.Right=atten;
end
STIMS.hard=1; % when 1 returns actual stimuli in STIMS.waveform.line1,2,3 etc
              % when 0 stimuli will be generated on the fly
              % when -1 stimuli will be loaded from designated directory on
              % the fly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

STIMS.rise_fall_timeAB=[min([.01 Adur/10]) min([.01 Bdur/10])];

STIMS.freqsAB=[toneAfr toneBfr];

Fs=HW.Fso;STIMS.Fs=HW.Fso;
tsA=[0:(1/Fs):(Adur-1/Fs)];tsB=[0:(1/Fs):(Bdur-1/Fs)];

for line_num=1:1
    omA=2*pi*STIMS.freqsAB(1);omB=2*pi*STIMS.freqsAB(2);
    yA=sin(omA*tsA);yB=sin(omB*tsB);
    yA=aud_gate_on(yA,STIMS.rise_fall_timeAB(1)*1000,Fs);
    yA=aud_gate_off(yA,STIMS.rise_fall_timeAB(1)*1000,Fs);
    yB=aud_gate_on(yB,STIMS.rise_fall_timeAB(2)*1000,Fs);
    yB=aud_gate_off(yB,STIMS.rise_fall_timeAB(2)*1000,Fs);
    gap=zeros(1,gapdur*Fs);
    y=[yA yB yA gap];
    y=repmat(y,1,numABAsets);
    eval(sprintf('STIMS.waveform.line%i=y'';',line_num))
end
    