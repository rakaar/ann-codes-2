function [STIMS,stim_structure]=File_VOCAL_Generate(stim_structure,HW)

%this code specific for NoisePip
% Example Stim Structure
% stim_structure
%         left_check: 0
%        right_check: 1
%         both_check: 0
%        frame_check: 1
%     linescan_check: 0
%               type: 'NoisePip'
%      stim_protocol: [1x1 struct]
%       protocol_str: [1x134 char]
% 
% stim_structure.stim_protocol
%              frame_dur: 0.2000
%                pip_dur: 0.1250
%     total_frames_lines: 25
%             stim_start: 11
%                ipi_val: 0.2500
%               level_lo: 30
%               level_hi: 10
%          num_att_steps: 3
%        npips_per_train: 4
%             total_reps: 5
%                flo_val: 6000
%                fhi_val: 48000


nas=1;%stim_structure.stim_protocol.num_att_steps;
ll=stim_structure.stim_protocol.level;
lh=stim_structure.stim_protocol.level;
%pipd=stim_structure.stim_protocol.pip_dur;
%ipi=stim_structure.stim_protocol.ipi_val;
%npips=stim_structure.stim_protocol.npips_per_train;
ctv=stim_structure.stim_protocol.choose_set;

if ctv==4
nstims_set=8;%stim_structure.stim_protocol.nstims_set;
else
    nstims_set=20;%stim_structure.stim_protocol.nstims_set;

end


% following parameters for all stimuli %%%%%%%%%%%%%%%%%%%%%%%
STIMS.no_times=stim_structure.stim_protocol.no_times_rand_stim_set;%set of 20 stimuli randomly generated here 5 times say ,so 5*20 stimuli
no_times=stim_structure.stim_protocol.no_times_rand_stim_set;
STIMS.duration=1.64;%npips*ipi;
STIMS.lines_per_set=nas*nstims_set*no_times;
STIMS.rep_sets=stim_structure.stim_protocol.total_reps;
if stim_structure.left_check==1
    STIMS.ATTENS.Left=reshape(repmat(linspace(ll,lh,nas),nstims_set*no_times,1),1,nstims_set*nas*no_times);
    STIMS.ATTENS.Right=[];
elseif stim_structure.right_check==1
    STIMS.ATTENS.Right=reshape(repmat(linspace(ll,lh,nas),nstims_set*no_times,1),1,nstims_set*nas*no_times);
    STIMS.ATTENS.Left=[];
elseif stim_structure.both_check==1
    STIMS.ATTENS.Left=reshape(repmat(linspace(ll,lh,nas),nstims_set*no_times,1),1,nstims_set*no_times*nas);
    STIMS.ATTENS.Right=reshape(repmat(linspace(ll,lh,nas),nstims_set*no_times,1),1,nstims_set*no_times*nas);
end
STIMS.hard=1; % when 1 returns actual stimuli in STIMS.waveform.line1,2,3 etc
              % when 0 stimuli will be generated on the fly
              % when -1 stimuli will be loaded from designated directory
              % STIMS.directory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

STIMS.rise_fall_time=0;%min([.01 (stim_structure.stim_protocol.pip_dur)/10]);

%STIMS.freqs=repmat(logspace(log10(fl),log10(fh),nfs),1,nas);

Fs=HW.Fso;STIMS.Fs=HW.Fso;
%tp=[0:(1/Fs):(ipi-1/Fs)];tpip=[0:(1/Fs):(pipd-1/Fs)];
setnums=[1 1 2 3 4];
stimset=setnums(ctv);
%%%% currently set to only one frequency range - 6-48 kHz - change RSSGUI
%%%% to choose different frequency ranges and set up those stimuli.
strx1='C:\EXPERIMENTS\STIMULUS\VOCAL\SET';
strx2=num2str(stimset);
%strx3='dB\FREQ_6_48\';
dir_str=strcat(strx1,strx2);
STIMS.directory=dir_str;
%frozen noise flo-fhi frequency
%N=length(tpip);
%[Noise_wf]=BandPassNoise(N,Fs,fl,fh);
%y=Noise_wf*(1/max(abs(Noise_wf)));
curr_dir=pwd;
%%%HARD CODED
for rep_num=1:no_times*nas
    stim_order=[];
    stim_order=randperm(nstims_set);
    store_stim_order(rep_num,:)=stim_order;
end

play_order=store_stim_order';
play_order=play_order(:);
for line_num=1:nstims_set*no_times
    stnum=rem(play_order(line_num),nstims_set);
    if stnum==0
        stnum=nstims_set;
    end
    eval(sprintf('cd %s',dir_str))
    eval(sprintf('[stm fs_ch ]=wavread(''b%03d'');',stnum))
     sprintf('%i',fs_ch)
%     sprintf(fs_ch)
    eval(sprintf('cd %s',curr_dir))
%     if length(stm)>=N
%         y=stm(1:N)';
%     else
%         rmd=rem(length(stm),N);fct=fix(length(stm)/N);y=[];
%         for jj=1:fct
%             y=[y stm'];
%         end
%         if rmd~=0
%             y=[y stm(1:rmd)'];
%         end
%     end
%     y=aud_gate_on(y,STIMS.rise_fall_time*1000,Fs);
%     y=aud_gate_off(y,STIMS.rise_fall_time*1000,Fs);
%     y=[y zeros(1,length(tp)-length(y))];y=repmat(y,1,npips);
    eval(sprintf('STIMS.waveform.line%i=stm;',line_num))
%     line_num
end
%   rep_num
% end
 STIMS.store_stim_order=store_stim_order;
% end