function [STIMS,stim_structure]=File_perrand_Generate(stim_structure,HW)

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
%              frame_dur: 0.2000+-
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


%% ann 11/4/2022

%2 sets of 4/2/3 periodicity + random fr each haivng same no of tokens
%%
Fs=HW.Fso;STIMS.Fs=HW.Fso;

if stim_structure.stim_protocol.use_sam==0&&stim_structure.stim_protocol.use_MSt==0
    
    Fs=HW.Fso;STIMS.Fs=HW.Fso;
    Adur=stim_structure.stim_protocol.tdur1;
    Bdur=stim_structure.stim_protocol.tdur2;
    Cdur=stim_structure.stim_protocol.tdur3;

    Sdur=stim_structure.stim_protocol.sil_dur; % silence interval 

    STIMS.rise_fall_timeABC=[min([.01 Adur/10]) min([.01 Bdur/10]) min([.01 Cdur/10])];
    tsA=[0:(1/Fs):(Adur-1/Fs)];
    tsB=[0:(1/Fs):(Bdur-1/Fs)];
    tsC=[0:(1/Fs):(Cdur-1/Fs)];
    tsS=[0:(1/Fs):(Sdur-1/Fs)]; % for silence
    atten=stim_structure.stim_protocol.db_atten;% single attenuation 
    STIMS.Fre=[stim_structure.stim_protocol.freq1 stim_structure.stim_protocol.freq2 stim_structure.stim_protocol.freq3];% set of all freq from gui
    STIMS.duration = stim_structure.stim_protocol.total_dur;% total duration of stimulus taken frm user


    %% frm sir s code
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
              % the fl

 %% 
    omA=2*pi*STIMS.Fre(1);
    omB=2*pi*STIMS.Fre(2);
    omC=2*pi*STIMS.Fre(3);
    yA=sin(omA*tsA);yB=sin(omB*tsB);yC=sin(omC*tsC);
    yA=aud_gate_on(yA,STIMS.rise_fall_timeABC(1)*1000,Fs);
    yA=aud_gate_off(yA,STIMS.rise_fall_timeABC(1)*1000,Fs);
    yB=aud_gate_on(yB,STIMS.rise_fall_timeABC(2)*1000,Fs);
    yB=aud_gate_off(yB,STIMS.rise_fall_timeABC(2)*1000,Fs);
    yC=aud_gate_on(yC,STIMS.rise_fall_timeABC(3)*1000,Fs);
    yC=aud_gate_off(yC,STIMS.rise_fall_timeABC(3)*1000,Fs);
    gap=zeros(1,Sdur*Fs);
% %%
%  for line_num=1:1
%     omA=2*pi*STIMS.freqsAB(1);omB=2*pi*STIMS.freqsAB(2);
%     yA=sin(omA*tsA);yB=sin(omB*tsB);
%     yA=aud_gate_on(yA,STIMS.rise_fall_timeAB(1)*1000,Fs);
%     yA=aud_gate_off(yA,STIMS.rise_fall_timeAB(1)*1000,Fs);
%     yB=aud_gate_on(yB,STIMS.rise_fall_timeAB(2)*1000,Fs);
%     yB=aud_gate_off(yB,STIMS.rise_fall_timeAB(2)*1000,Fs);
%     gap=zeros(1,gapdur*Fs);
%     y=[yA yB yA gap];
%     y=repmat(y,1,numABAsets);
%     eval(sprintf('STIMS.waveform.line%i=y'';',line_num))
%  end

%% for random signal generation 
ryA=[yA gap];
ryB=[yB gap];
ryC=[yC gap];
randsignals=[ryA ryB ryC];
rand_mat=zeros(20,STIMS.duration/(Adur+Sdur));
for i=1:20
    rand_mat(i,:)=randi([1 2],1,STIMS.duration/(Adur+Sdur));
    
end


    n=randi(16);% to choose all possible stimulus for two tones in periodicity 2/3/4 and random =6 

    switch stim_structure.stim_protocol.ntoks_period % based on periodicity

        case 1
            
            %% 12
            period_dur = (Adur+Sdur+Bdur+Sdur);% total duration of one period in periodicity 2
            n_periods= STIMS.duration/period_dur;
            y=[yA gap yB gap];
            y=repmat(y,1,n_periods);
        case 2   
            % 21
            period_dur = (Adur+Sdur+Bdur+Sdur);% total duration of one period in periodicity 2
            n_periods= STIMS.duration/period_dur;
              y=[yB gap yA gap];
              y=repmat(y,1,n_periods);
        case 3  
            % 122
            period_dur = (Adur+Sdur+Bdur+Sdur+Bdur+Sdur);% total duration of one period in periodicity 2
            n_periods= STIMS.duration/period_dur;
            y=[yA gap yB gap yB gap];
            y=repmat(y,1,n_periods);
         case 4  
            % 211
            period_dur = (Bdur+Sdur+Adur+Sdur+Adur+Sdur);% total duration of one period in periodicity 2
            n_periods= STIMS.duration/period_dur;
            y=[yB gap yA gap yA gap];
            y=repmat(y,1,n_periods);
          case 5  
            % 121
            period_dur = (Adur+Sdur+Bdur+Sdur+Adur+Sdur);% total duration of one period in periodicity 2
            n_periods= STIMS.duration/period_dur;
            y=[yA gap yB gap yA gap];
            y=repmat(y,1,n_periods);
          case 6 
            % 212
            period_dur = (Bdur+Sdur+Adur+Sdur+Bdur+Sdur);% total duration of one period in periodicity 2
            n_periods= STIMS.duration/period_dur;
            y=[yB gap yA gap yB gap];
            y=repmat(y,1,n_periods);

          case 7 
            % 112
            period_dur = (Adur+Sdur+Adur+Sdur+Bdur+Sdur);% total duration of one period in periodicity 2
            n_periods= STIMS.duration/period_dur;
            y=[yA gap yA gap yB gap];
            y=repmat(y,1,n_periods);

          case 8
            % 221
            period_dur = (Bdur+Sdur+Bdur+Sdur+Adur+Sdur);% total duration of one period in periodicity 2
            n_periods= STIMS.duration/period_dur;
            y=[yB gap yB gap yA gap];
            y=repmat(y,1,n_periods);
             
        case 9
            % 1221
            period_dur = (2*Adur+4*Sdur+2*Bdur);% total duration of one period in periodicity 2
            n_periods= STIMS.duration/period_dur;
            y=[yA gap yB gap yB gap yA gap];
            y=repmat(y,1,n_periods);
   
            case 10
            % 2112
            period_dur = (2*Adur+4*Sdur+2*Bdur);% total duration of one period in periodicity 2
            n_periods= STIMS.duration/period_dur;
            y=[yB gap yA gap yA gap yB gap];
            y=repmat(y,1,n_periods);

            %%random stimulus

        case 11
            % 1=18times and 2=18 times
        case 12
            % 1=24 times and 2=12 times

        case 13
            % 2=24 times and 1 = 12 times


        