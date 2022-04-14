function [STIMS,stim_structure]=File_SSA_Generate(stim_structure,HW)

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
Adur=stim_structure.stim_protocol.stim_Adur;
Bdur=stim_structure.stim_protocol.stim_Bdur;
STIMS.rise_fall_timeAB=[min([.01 Adur/10]) min([.01 Bdur/10])];
tsA=[0:(1/Fs):(Adur-1/Fs)];
tsB=[0:(1/Fs):(Bdur-1/Fs)];
STIMS.rise_fall_timeAB=[min([.01 Adur/10]) min([.01 Bdur/10])];

switch stim_structure.stim_protocol.Atype
    case 1
        STIMS.Atype=1;
        toneAfr=stim_structure.stim_protocol.freqA;
        omA=2*pi*toneAfr;
        yA=sin(omA*tsA);
        
    case 2
        STIMS.Atype=2;
        Afrlo=stim_structure.stim_protocol.NoiseAlow;
        Afrhi=stim_structure.stim_protocol.NoiseAhigh;
        N=length(tsA);
        [Noise_wf]=BandPassNoise(N,Fs,Afrlo,Afrhi);
        yA=Noise_wf*(1/max(abs(Noise_wf)));
        noise_rms=sqrt(mean(yA.^2));
        20*log10(noise_rms/20e-6)
    case 3
        STIMS.Atype=3;
        STIMS.pfA=strcat(stim_structure.stim_protocol.path_A,stim_structure.stim_protocol.file_A);
        eval(sprintf('[yy,wfs,nb]=wavread(''%s'');',STIMS.pfA))
        if wfs~=Fs
            yy=resample(yy,Fs,wfs);
        end
        yy=yy';
        N=length(yy);
        if N<length(tsA)
            yy=repmat(yy,1,ceil(length(tsA)/N));
        end
        yA=yy(1:length(tsA));
        clear yy
end
yA=aud_gate_on(yA,STIMS.rise_fall_timeAB(1)*1000,Fs);
yA=aud_gate_off(yA,STIMS.rise_fall_timeAB(1)*1000,Fs);

switch stim_structure.stim_protocol.Btype
    case 1
        STIMS.Btype=1;
        toneBfr=stim_structure.stim_protocol.freqB;
        omB=2*pi*toneBfr;
        yB=sin(omB*tsB);
        
    case 2
        STIMS.Btype=2;
        Bfrlo=stim_structure.stim_protocol.NoiseBlow;
        Bfrhi=stim_structure.stim_protocol.NoiseBhigh;
        N=length(tsB);
        [Noise_wf]=BandPassNoise(N,Fs,Bfrlo,Bfrhi);
        yB=Noise_wf*(1/max(abs(Noise_wf)));
        noise_rms=sqrt(mean(yB.^2));
        20*log10(noise_rms/20e-6)
    case 3
        STIMS.Btype=3;
        STIMS.pfB=strcat(stim_structure.stim_protocol.path_B,stim_structure.stim_protocol.file_B);
        eval(sprintf('[yy,wfs,nb]=wavread(''%s'');',STIMS.pfB))
        if wfs~=Fs
            yy=resample(yy,Fs,wfs);
        end
        yy=yy';
        N=length(yy);
        if N<length(tsB)
            yy=repmat(yy,1,ceil(length(tsB)/N));
        end
        yB=yy(1:length(tsB));
        clear yy
end
yB=aud_gate_on(yB,STIMS.rise_fall_timeAB(2)*1000,Fs);
yB=aud_gate_off(yB,STIMS.rise_fall_timeAB(2)*1000,Fs);




gapdur=stim_structure.stim_protocol.gap_dur;
atten=stim_structure.stim_protocol.atten;
numstims=stim_structure.stim_protocol.total_stims;



% following parameters for all stimuli %%%%%%%%%%%%%%%%%%%%%%%
STIMS.lines_per_set=1;
STIMS.rep_sets=stim_structure.stim_protocol.nreps;
if stim_structure.stim_protocol.rand_nstim_check==0
    STIMS.duration=(numstims-1)*Adur+Bdur+numstims*gapdur;
else
    for lll=1:stim_structure.stim_protocol.nreps
        nstsline=stim_structure.stim_protocol.rand_nstim_num(lll);
        STIMS.duration(lll)=(nstsline-1)*Adur+Bdur+nstsline*gapdur;
    end
end

if stim_structure.stim_protocol.randB_check~=0&stim_structure.stim_protocol.rand_nstim_check==0
    STIMS.lines_per_set=stim_structure.stim_protocol.nreps;
    STIMS.rep_sets=1;
elseif stim_structure.stim_protocol.randB_check==0&stim_structure.stim_protocol.rand_nstim_check~=0
    STIMS.lines_per_set=stim_structure.stim_protocol.nreps;
    STIMS.rep_sets=1;
elseif stim_structure.stim_protocol.randB_check~=0&stim_structure.stim_protocol.rand_nstim_check~=0
    STIMS.lines_per_set=stim_structure.stim_protocol.nreps;
    STIMS.rep_sets=1;
end
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




if stim_structure.stim_protocol.rand_nstim_check==0
    for line_num=1:STIMS.lines_per_set
        gap=zeros(1,fix(gapdur*Fs));
        if STIMS.lines_per_set==1
            stimB_loc=stim_structure.stim_protocol.stimB_loc;
            num_stimB=stim_structure.stim_protocol.num_stimB;
            stimB_locs=stimB_loc:stimB_loc+num_stimB-1;
            y=[];
            for sn=1:numstims
                if ~ismember(sn,stimB_locs)
                        y=[y yA gap];
                    else
                        y=[y yB gap];
                end
                    
            end
            eval(sprintf('STIMS.waveform.line%i=y'';',line_num))
            stimduration(line_num)=length(y)/Fs;
        else
            stimB_loc=stim_structure.stim_protocol.rand_stimB_loc;
            y=[];
            for sn=1:numstims
                if sn~=stimB_loc(line_num)
                    y=[y yA gap];
                else
                    y=[y yB gap];
                end
            end
            eval(sprintf('STIMS.waveform.line%i=y'';',line_num))
            stimduration(line_num)=length(y)/Fs;
        end
        
    end
elseif stim_structure.stim_protocol.rand_nstim_check==1
    if stim_structure.stim_protocol.randB_check==0
        gap=zeros(1,fix(gapdur*Fs));
        stimB_loc=stim_structure.stim_protocol.stimB_loc;
        for line_num=1:STIMS.lines_per_set
            y=[];
            nstsline=stim_structure.stim_protocol.rand_nstim_num(line_num);
            for sn=1:nstsline
                if sn~=stimB_loc
                    y=[y yA gap];
                else
                    y=[y yB gap];
                end
            end
            eval(sprintf('STIMS.waveform.line%i=y'';',line_num))
            stimduration(line_num)=length(y)/Fs;
        end
    elseif stim_structure.stim_protocol.randB_check==1
        gap=zeros(1,fix(gapdur*Fs));
        stimB_loc=stim_structure.stim_protocol.rand_stimB_loc;
        for line_num=1:STIMS.lines_per_set
            y=[];
            nstsline=stim_structure.stim_protocol.rand_nstim_num(line_num);
            for sn=1:nstsline
                if sn~=stimB_loc(line_num)
                    y=[y yA gap];
                else
                    y=[y yB gap];
                end
            end
            eval(sprintf('STIMS.waveform.line%i=y'';',line_num))
            stimduration(line_num)=length(y)/Fs;
        end        
    end
end
%%% Code to make sure all stimuli in a line are played before end of data
%%% collection.
totaltime=stim_structure.stim_protocol.stim_start+max(stimduration);
if stim_structure.stim_protocol.total_frames_lines<(totaltime+.5)
    stim_structure.stim_protocol.total_frames_lines=totaltime+0.5;
    fprintf('Total time changed to accommodate all stimuli\n')
end
pause(1)



    