function [CTR_RESETALL,CTR_TRIGALL,STIMFRAMES]=create_ctr_trigreset_set(stim_structure,stimdur,lines_per_set,TC);

% stim_structure = 
% 
%          left_check: 0
%         right_check: 1
%          both_check: 0
%         frame_check: 1
%      linescan_check: 0
%                type: 'SAM'
%       stim_protocol: [1x1 struct]
%        protocol_str: [1x107 char]
%     max_speed_check: 1
%          offset_num: 1
%           MultFrame: 0
%        MultFrameVal: 5
% 
% stim_structure.stim_protocol =
% 
%              frame_dur: 0.1540
%     total_frames_lines: 20
%             stim_start: 10
%               level_lo: 70
%               level_hi: 0
%          num_att_steps: 8
%             total_reps: 15
%             tone_check: 0
%            noise_check: 1
%                 To_flo: 8000
%                 To_fhi: 64000
%               mod_freq: 5
%              mod_depth: 1
%         num_freq_steps: 13
%                 No_fhi: 64000
%                 No_flo: 8000
%                    dur: 1

fdur=stim_structure.stim_protocol.frame_dur;
stim_nframes=fix(stimdur/fdur)+1;
trig_frame=stim_structure.stim_protocol.stim_start;
gapdur=stim_structure.MultFrameVal;
totaldur=stimdur+gapdur;total_nframes=fix(totaldur/fdur)+1;
STIMFRAMES=[trig_frame trig_frame+[1:(lines_per_set-1)]*total_nframes];
CTR_RESETALL=stim_nframes*ones(1,lines_per_set-1);CTR_RESETALL(lines_per_set)=total_nframes;
CTR_TRIGALL(2:lines_per_set)=TC-(total_nframes-stim_nframes)+1;