function [STIMS,stim_structure]=File_MSEQ_Generate(stim_structure,HW)

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

Fs=HW.Fso;STIMS.Fs=HW.Fso;
load binMSeq1
nbins=length(binMSeq);
cf=stim_structure.stim_protocol.carrier_freq;
binw=stim_structure.stim_protocol.binwidth;
samps_per_bin=fix(Fs*binw);
abinw=samps_per_bin/Fs;
STIMS.rise_fall_time=2*binw;
STIMS.binwidth=binw;
STIMS.actual_binwidth=abinw;
atten=stim_structure.stim_protocol.atten;
numstims=1;%stim_structure.stim_protocol.total_stims;



% following parameters for all stimuli %%%%%%%%%%%%%%%%%%%%%%%
STIMS.duration=nbins*abinw;
STIMS.nsamps=nbins*samps_per_bin;
STIMS.lines_per_set=1;
STIMS.rep_sets=stim_structure.stim_protocol.total_reps;

if stim_structure.left_check==1
    STIMS.ATTENS.Left=atten*ones(1,STIMS.lines_per_set);
    STIMS.ATTENS.Right=[];
elseif stim_structure.right_check==1
    STIMS.ATTENS.Right=atten*ones(1,STIMS.lines_per_set);
    STIMS.ATTENS.Left=[];
elseif stim_structure.both_check==1
    STIMS.ATTENS.Left=atten*ones(1,STIMS.lines_per_set);
    STIMS.ATTENS.Right=atten*ones(1,STIMS.lines_per_set);
end
STIMS.hard=1; % when 1 returns actual stimuli in STIMS.waveform.line1,2,3 etc
              % when 0 stimuli will be generated on the fly
              % when -1 stimuli will be loaded from designated directory on
              % the fly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t=[0:(STIMS.nsamps-1)]/Fs;
carrier=sin(2*pi*cf*t);
modw=reshape(repmat(binMSeq,samps_per_bin,1),1,STIMS.nsamps);
STIMS.waveform.line1=modw'.*carrier';
% figure
% plot(t,STIMS.waveform.line1)
% 
% for line_num=1:STIMS.lines_per_set
%     gap=zeros(1,gapdur*Fs);
%     if STIMS.lines_per_set==1
%         stimB_loc=stim_structure.stim_protocol.stimB_loc;
%         y=[];
%         for sn=1:numstims
%             if sn~=stimB_loc
%                 y=[y yA gap];
%             else
%                 y=[y yB gap];
%             end
%         end
%         eval(sprintf('STIMS.waveform.line%i=y'';',line_num))
%     else
%         stimB_loc=stim_structure.stim_protocol.rand_stimB_loc;
%         y=[];
%         for sn=1:numstims
%             if sn~=stimB_loc(line_num)
%                 y=[y yA gap];
%             else
%                 y=[y yB gap];
%             end
%         end
%         eval(sprintf('STIMS.waveform.line%i=y'';',line_num))
%     end
%     
% end
% %figure
% %plot(STIMS.waveform.line1)
% %save STIMS STIMS
    