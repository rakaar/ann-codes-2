function TwoCh_Continuous_Play_Trig(s1,s2,HW)

% Two-channel continuous play example using a serial buffer
% This program writes to the buffer once it has cyled halfway through
% (double-buffering)

%close all; clear all; clc;

%RP = TDTRP('C:\EXPERIMENTS\PRAIRIEPARTNER\CODES\TDT_FILES\TwoCh_Continuous_Play_Trig.rcx', 'RZ6');
RP = TDTRP('C:\EXPERIMENTS\PRAIRIEPARTNER\CODES\TDT_FILES\TwoCh_Continuous_Play_Trig.rcx', 'RZ6');

% size of the entire serial buffer
npts = RP.GetTagSize('Ldatain');

% serial buffer will be divided into two buffers A & B
bufpts = npts/2;

% get device sampling frequency
fs = RP.GetSFreq();

% create two 10-second chirps
duration = 10;
amplitude = 1;
t = 0:1/fs:duration;
%s1 = amplitude*chirp(t, 6000, duration, 10000);
%s2 = amplitude*chirp(t, 6000, duration, 12000);

RP.SetTagVal('nSamps', length(s1));

% main loop
while 1
    
    % load up entire buffer with segments A and B
    RP.WriteTagVEX('Ldatain', 0, 'F32', s1(1:npts));
    RP.WriteTagVEX('Rdatain', 0, 'F32', s2(1:npts));
    stim_index = npts;
    curindex = RP.GetTagVal('index');
    %disp(['Current buffer index: ' num2str(curindex)]);
    
    RP.SetTagVal('Enable', 1);
    disp('waiting for trigger')
    pause(0.1)
    HW.SS.startForeground
%     while RP.GetTagVal('playing') == 0
%         10000+10000;
%     end
    
    disp('playing')
    sz = length(s1);
    bDone = 0;
    while RP.GetTagVal('playing') == 1
        
        curindex = RP.GetTagVal('index');
        
        % wait until done playing A
        while(curindex < bufpts && RP.GetTagVal('playing') == 1 )
            curindex = RP.GetTagVal('index');
            pause(.05);
        end
        
        if RP.GetTagVal('playing') == 0
            RP.SetTagVal('Enable', 0);
            break
        end
        
        % load the next signal segment into A
        top = min(stim_index+bufpts, sz);
        if stim_index ~= sz
            RP.WriteTagVEX('Ldatain', 0, 'F32', s1(stim_index:top));
            RP.WriteTagVEX('Rdatain', 0, 'F32', s2(stim_index:top));
            stim_index = min(top, sz);
        end
        
        % checks to see if the data transfer rate is fast enough
        curindex = RP.GetTagVal('index');

        if(curindex < bufpts)
            warning('Transfer rate is too slow');
        end
        
        % wait until start playing A again
        while(curindex > bufpts && RP.GetTagVal('playing') == 1 )
            curindex = RP.GetTagVal('index');
            pause(.05);
        end
        
        if RP.GetTagVal('playing') == 0
            RP.SetTagVal('Enable', 0);
            break
        end
            
        % load segment B
        top = min(stim_index+bufpts, sz);
        if stim_index ~= sz
            RP.WriteTagVEX('Ldatain', bufpts, 'F32', s1(stim_index:top));
            RP.WriteTagVEX('Rdatain', bufpts, 'F32', s2(stim_index:top));
            stim_index = min(top, sz);
        end
        
        % make sure we're still playing A
        curindex = RP.GetTagVal('index');
        %disp(['Current index: ' num2str(curindex)]);
        if(curindex > bufpts)
            warning('Transfer rate too slow');
        end
    end
end

% stop playing
RP.Halt;