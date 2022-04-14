close all; clear all; clc;

RP = TDTRP('C:\TDT\ActiveX\ActXExamples\RP_Files\TDTwavplay1ch.rcx', 'RZ6');

maxSamples = RP.GetTagSize('Ldata');

% put path of .wav file here
wav_filename = 'C:\Windows\Media\recycle.wav';

new_sample_rate = RP.GetSFreq();

% resample it
[data, sample_rate] = audioread(wav_filename);
[p, q] = rat(sample_rate/new_sample_rate, 0.0001);
try
    new_data = resample (data, q, p);
catch
    warning(['Problem occurred during resample. Signal Processing Toolbox is required. Assuming wav file was sampled at ' num2str(new_sample_rate)])
    new_data = data;
end

Ldata = new_data(:,1);

% normalize to 1
Ldata = Ldata ./ max(Ldata);

% set my number of samples
mySamples = numel(Ldata);
RP.SetTagVal('dur', mySamples);

if mySamples > maxSamples
    error(sprintf('number of samples too large (%d vs %d), increase hardware buffer size', mySamples, maxSamples))
end

% write it to TDT
RP.WriteTagV('Ldata', 0, Ldata');

% begin playback
RP.SoftTrg(1);

% wait for playback to finish
while RP.GetTagVal('playback') > 0
    pause(.1)
end