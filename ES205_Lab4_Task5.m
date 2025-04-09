% ES205 Lab 4 Task 5
close all; clear variables; clc
%% Load Data

X = readtable('AccelPiezo10kOhm.csv', 'NumHeaderLines', 4);
t = X.Var3; v = X.Var2; a = X.Var4;

%% Plot Raw Data
figure
set(gcf, 'Position', [50 50 1200 700]);
plot(t, a)
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
title('Aluminum Beam Acceleration Raw Data')

%% Truncate Data

idx = find(abs(t-1.15461) < 1e-5);

tBeg = t(idx);
tEnd = tBeg + 8; % determine how much data to keep, in seconds
deltaT = t(2) - t(1);   % time step
fs = 1/deltaT;          % sample rate
NBeg = round(tBeg*fs);  % starting sample
NEnd = round(tEnd*fs);  % ending sample
t(NEnd+1:end) = []; v(NEnd+1:end) = []; a(NEnd+1:end) = [];
t(1:NBeg) = []; v(1:NBeg) = []; a(1:NBeg) = [];
t = t - t(1);   % start time at zero

a = a - mean(a);
%% Plot
figure
set(gcf, 'Position', [50 50 1200 700]);
plot(t, a); hold on;
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
title('Aluminum Beam Acceleration Truncated Data')


%% Find distance between peaks
% Estimated period
dT = 0.04;
[aPks, tPks] = findpeaks(a, t, 'MinPeakDistance', 0.95*dT);

%% Plot peaks
plot(tPks, aPks, 'o')
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')

%% Write output file
piezo_beam_trunc = table(t, v, a);
writetable(piezo_beam_trunc, 'Beam_TruncC.csv');

