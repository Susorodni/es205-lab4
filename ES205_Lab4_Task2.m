% ES205 Lab 4 Task 2
clear variables; close all; clc

%% Load Config A
XAlum = readtable('Beam_TruncA.csv', 'NumHeaderLines', 0);
tAlum = XAlum.tAlum; a = XAlum.a;

%% Find natural frequency of Config A
TAlum = 0.04;
[aPksAlum, tPksAlum] = findpeaks(a, tAlum, 'MinPeakDistance', 0.95*TAlum);
NPksAlum = length(tPksAlum);

[deltaTAlum, deltaAlum] = deal(NPksAlum-1, 1);
for i = 1:NPksAlum - 1
    deltaTAlum(i) = tPksAlum(i + 1) - tPksAlum(i);
    deltaAlum(i) = (1/i)*log(aPksAlum(1)/aPksAlum(i + 1));
end

TAlum = mean(deltaTAlum);
deltaAvgAlum = mean(deltaAlum);
zetaAlum = deltaAvgAlum/sqrt(deltaAvgAlum^2 + 4*pi^2);
fdAlum = 1/TAlum;           % in Hz
omegadAlum = 2*pi*fdAlum;   % in rad/sec
fnAlum = (omegadAlum/sqrt(1 - zetaAlum^2))/(2*pi);
disp('Aluminum Beam')
disp(['Average Delta            ', num2str(deltaAvgAlum)])
disp(['Zeta                     ', num2str(zetaAlum)])
disp(['Damped Natural Frequency ', num2str(fdAlum), ' Hz'])
disp(['Natural Frequency        ', num2str(fnAlum), ' Hz'])

Autospectrum(tAlum, a, 'Acceleration');

%% Load Config B
XSteel = readtable('Beam_TruncB.csv', 'NumHeaderLines', 0);
tSteel = XSteel.tSteel; s = XSteel.s;

%% Find natural frequency of Config B
TSteel = 0.04;
[aPksSteel, tPksSteel] = findpeaks(s, tSteel, 'MinPeakDistance', 0.95*TSteel);
NPksSteel = length(tPksSteel);

[deltaTSteel, deltaSteel] = deal(NPksSteel-1, 1);
for i = 1:NPksSteel - 1
    deltaTSteel(i) = tPksSteel(i + 1) - tPksSteel(i);
    deltaSteel(i) = (1/i)*log(aPksSteel(1)/aPksSteel(i + 1));
end

TSteel = mean(deltaTSteel);
deltaAvgSteel = mean(deltaSteel);
zetaSteel = deltaAvgSteel/sqrt(deltaAvgSteel^2 + 4*pi^2);
fdSteel = 1/TSteel;           % in Hz
omegadSteel = 2*pi*fdSteel;   % in rad/sec
fnSteel = (omegadSteel/sqrt(1 - zetaSteel^2))/(2*pi);
disp('Steel Beam')
disp(['Average Delta            ', num2str(deltaAvgSteel)])
disp(['Zeta                     ', num2str(zetaSteel)])
disp(['Damped Natural Frequency ', num2str(fdSteel), ' Hz'])
disp(['Natural Frequency        ', num2str(fnSteel), ' Hz'])

Autospectrum(tSteel, s, 'Acceleration');
%TODO: finish task 2