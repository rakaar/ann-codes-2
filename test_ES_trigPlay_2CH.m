% test_ES_trigPlay_2CH.m
%
% Ed Smith         March 2009
%
clc;
close all;
clear all;

fs = 156250;

% Time points
T = .1; % Duration of the tone
dt = 1 / fs;
t = 0 : dt : (T-dt);

% tone
freqcy = 2000; % freq of this tone
ts1 = cos ( 2 * pi * freqcy * t );
ts2 = sin ( 2 * pi * freqcy * t );
% SEND DATA TO THE TDT BOX
trigPlay_2CH ( ts1, ts2, fs );
