% test_ES_trigPlay.m
%
% Ed Smith         March 2009
%
clc;
close all;
clear all;

original_fs = 156250; % original (generation) fs
fixed_TDT_fs = 156250; % A TDT fs

for i = 1 : inf;

    % MAKE SOME TONE
    freqcy = 1000 * 4000 * rand; % freq of this tone
    T = .25 + .5 * rand; % Duration of this tone
    dt = 1 / original_fs;
    t = 0 : dt : (T-dt);
    ts = cos ( 2 * pi * freqcy * t );

    % CONVERT FS TO TDT'S SAMPLE FREQUENCY
    ts = resample ( ts, fixed_TDT_fs, original_fs );

    % SEND DATA TO THE TDT BOX
    trigPlay ( ts, fixed_TDT_fs );

    pause ( 10 * abs ( randn ) );

end;