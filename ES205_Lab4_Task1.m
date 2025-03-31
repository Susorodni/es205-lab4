% ES205 Lab 4 Task 1
close all; clear variables; clc
%% Load Data

X = readtable('Alum12inNoPiezo.csv', 'NumHeaderLines', 4);
t = X.Var3; a = X.Var4;

%% Plot
figure
set(gcf, 'Position', [50 50 1200 700]);
hold on
plot(t, a)

%% Truncate Data
ti = 3.14293;
tf = ti + 10;

deltaT = t(2) - t(1);   % time step
fs = 1/deltaT;          % sample rate
NBeg = round(ti*fs);  % starting sample
NEnd = round(tf*fs);  % ending sample
t(NEnd+1:end) = []; a(NEnd+1:end) = [];
t(1:NBeg) = []; a(1:NBeg) = [];
t = t - t(1);   % start time at zero
a = a - mean(a);

%% Find distance between peaks
% Estimated period
dT = 0.04;
[aPks, tPks] = findpeaks(a, t, 'MinPeakDistance', 0.95*dT);

%% Plot peaks
figure
set(gcf, 'Position', [50 50 1200 700]);
hold on
plot(t, a)
plot(tPks, aPks, 'o')
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')

%% Write output file
beam_trunc = table(t, a);
writetable(beam_trunc, 'Beam_TruncA.csv');