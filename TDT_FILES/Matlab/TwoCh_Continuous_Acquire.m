% Two-channel continuous acquire example using a serial buffer
% This program writes to the buffer once it has cyled halfway through
% (double-buffering)

close all; clear all; clc;

% filePath - set this to wherever the examples are stored
filePath = 'C:\TDT\ActiveX\ActXExamples\Matlab\';

RP = TDTRP('C:\TDT\ActiveX\ActXExamples\RP_files\TwoCh_Continuous_Acquire.rcx', 'RZ6');

% size of the entire serial buffer
npts = RP.GetTagSize('Ldataout');  

% serial buffer will be divided into two buffers A & B
fs = RP.GetSFreq();
bufpts = npts/2; 
t=(1:bufpts)/fs;

filePath1 = strcat(filePath, 'fnoise1.F32');
filePath2 = strcat(filePath, 'fnoise2.F32');
fnoise1 = fopen(filePath1,'w');
fnoise2 = fopen(filePath2,'w');
    
% begin acquiring
RP.SoftTrg(1);
curindex = RP.GetTagVal('index');
disp(['Current buffer index: ' num2str(curindex)]);

% main looping section
for i = 1:10  

    % wait until done writing A
    while(curindex < bufpts)
        curindex = RP.GetTagVal('index');
        pause(.05);
    end

    % read segment A
    noise1 = RP.ReadTagVEX('Ldataout', 0, bufpts, 'F32', 'F32', 1);
    noise2 = RP.ReadTagVEX('Rdataout', 0, bufpts, 'F32', 'F32', 1);
    disp(['Wrote ' num2str(fwrite(fnoise1, noise1, 'float32')) ' points to file']);
    disp(['Wrote ' num2str(fwrite(fnoise2, noise2, 'float32')) ' points to file']);

    % checks to see if the data transfer rate is fast enough
    curindex = RP.GetTagVal('index');
    disp(['Current buffer index: ' num2str(curindex)]);
    if(curindex < bufpts)
        warning('Transfer rate is too slow');
    end

    % wait until start writing A 
    while(curindex > bufpts)
        curindex = RP.GetTagVal('index');
        pause(.05);
    end

    % read segment B
    noise1 = RP.ReadTagVEX('Ldataout', bufpts, bufpts, 'F32', 'F32', 1);
    noise2 = RP.ReadTagVEX('Rdataout', bufpts, bufpts, 'F32', 'F32', 1);
    disp(['Wrote ' num2str(fwrite(fnoise1, noise1, 'float32')) ' points to file']);
    disp(['Wrote ' num2str(fwrite(fnoise2, noise2, 'float32')) ' points to file']);

    % make sure we're still playing A 
    curindex = RP.GetTagVal('index');
    disp(['Current index: ' num2str(curindex)]);
    if(curindex > bufpts)
        warning('Transfer rate too slow');
    end

end

fclose(fnoise1);
fclose(fnoise2);

% stop acquiring
RP.SoftTrg(2);
RP.Halt;

% plots the last npts data points
subplot(2,1,1)
plot(t,noise1);
axis tight;
subplot(2,1,2)
plot(t,noise2);
axis tight;