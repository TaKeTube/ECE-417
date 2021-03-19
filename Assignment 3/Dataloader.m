clear all;
close all;
clc;

% initialize
load('speech_signal.mat');
sound(speech_signal,1000);
disp('original signal');
pause(1);
load('noise_signal.mat');
sound(noise_signal,1000);
disp('noise signal')
p=100;

% LP modeling
a = lpc(speech_signal,p);
% get prediction error
e = filter(a,1,speech_signal);

% synthesis using prediction error 
synthesis_e = filter(1,a,e);
pause(1);
sound(synthesis_e,1000);
disp('synthesis signal using error');

% synthesis using noise signal
synthesis_x = filter(1,a,noise_signal);
pause(1);
sound(synthesis_x,1000);
disp('synthesis signal using noise signal')
