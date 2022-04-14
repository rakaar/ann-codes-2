% Two-channel continuous play example using a serial buffer
% This program writes to the buffer once it has cyled halfway through
% (double-buffering)

close all; clear all; clc;

RP = TDTRP('C:\TDT\ActiveX\ActXExamples\RP_files\TwoCh_Continuous_Play.rcx', 'RZ6');

% size of the entire serial buffer
npts = RP.GetTagSize('Ldatain');  

% serial buffer will be divided into two buffers A & B
bufpts = npts/2; 

% get device sampling frequency
fs = RP.GetSFreq();

% create two 5-second chirps
duration = 5;
t = 0:1/fs:5;
s1 = chirp(t, 1000, 5, 10000);
s2 = chirp(t, 2000, 5, 12000);

% load up entire buffer with segments A and B
RP.WriteTagVEX('Ldatain', 0, 'F32', s1(1:npts));
RP.WriteTagVEX('Rdatain', 0, 'F32', s2(1:npts));
index = npts+1;

% start playing
RP.SoftTrg(1);
curindex = RP.GetTagVal('index');
disp(['Current buffer index: ' num2str(curindex)]);

% main looping section
sz = length(s1);
while index < sz

    % wait until done playing A
    while(curindex < bufpts)
        curindex = RP.GetTagVal('index');
        pause(.05);
    end

    % load the next signal segment
    top = min(index+bufpts, sz);
    RP.WriteTagVEX('Ldatain', 0, 'F32', s1(index:top));
    RP.WriteTagVEX('Rdatain', 0, 'F32', s2(index:top));
    index = top;

    % checks to see if the data transfer rate is fast enough
    curindex = RP.GetTagVal('index');
    disp(['Current buffer index: ' num2str(curindex)]);
    if(curindex < bufpts)
        warning('Transfer rate is too slow');
    end

    % wait until start playing A 
    while(curindex > bufpts)
        curindex = RP.GetTagVal('index');
        pause(.05);
    end

    % load segment B
    top = min(index+bufpts, sz);
    RP.WriteTagVEX('Ldatain', bufpts, 'F32', s1(index:top));
    RP.WriteTagVEX('Rdatain', bufpts, 'F32', s2(index:top));
    index = top;

    % make sure we're still playing A 
    curindex = RP.GetTagVal('index');
    disp(['Current index: ' num2str(curindex)]);
    if(curindex > bufpts)
        warning('Transfer rate too slow');
    end

end

% stop playing
RP.SoftTrg(2);
RP.Halt;