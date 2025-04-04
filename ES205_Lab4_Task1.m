% ES205 Lab 4 Task 1
close all; clear variables; clc
%% Load Aluminum Data

XAlum = readtable('Alum12inNoPiezo.csv', 'NumHeaderLines', 4);
tAlum = XAlum.Var3; a = XAlum.Var4;

%% Plot Raw Aluminum Data
figure
set(gcf, 'Position', [50 50 1200 700]);
plot(tAlum, a)
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
title('Aluminum Beam Acceleration Raw Data')

%% Truncate Data of Aluminum Configuration
for idx = 1:length(tAlum)
    if tAlum(idx) == 2.98375
        break
    end
end

tAlumBeg = tAlum(idx);
tAlumEnd = tAlumBeg + 1;
deltaTAlum = tAlum(2) - tAlum(1);   % time step
fsAlum = 1/deltaTAlum;          % sample rate
NBegAlum = round(tAlumBeg*fsAlum);  % starting sample
NEndAlum = round(tAlumEnd*fsAlum);  % ending sample
tAlum(NEndAlum+1:end) = []; a(NEndAlum+1:end) = [];
tAlum(1:NBegAlum) = []; a(1:NBegAlum) = [];
tAlum = tAlum - tAlum(1);   % start time at zero

a = a - mean(a);
%% Plot
figure
set(gcf, 'Position', [50 50 1200 700]);
plot(tAlum, a); hold on;
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
title('Aluminum Beam Acceleration Truncated Data')

%% Truncate Data (old)
% ti = 3.14293;
% tf = ti + 10;
% 
% deltaTAlum = tAlum(2) - tAlum(1);   % time step
% fsAlum = 1/deltaTAlum;          % sample rate
% NBegAlum = round(ti*fsAlum);  % starting sample
% NEndAlum = round(tf*fsAlum);  % ending sample
% tAlum(NEndAlum+1:end) = []; a(NEndAlum+1:end) = [];
% tAlum(1:NBegAlum) = []; a(1:NBegAlum) = [];
% tAlum = tAlum - tAlum(1);   % start time at zero
% a = a - mean(a);

%% Find distance between peaks
% Estimated period
dTAlum = 0.04;
[aPksAlum, tPksAlum] = findpeaks(a, tAlum, 'MinPeakDistance', 0.95*dTAlum);

%% Plot peaks
plot(tPksAlum, aPksAlum, 'o')
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')

%% Write output file
alum_beam_trunc = table(tAlum, a);
writetable(alum_beam_trunc, 'Beam_TruncA.csv');

%% Import Steel Data

XSteel = readtable('Steel12inNoPiezo.csv', 'NumHeaderLines', 4);
tSteel = XSteel.Var3; s = XSteel.Var4;

%% Plot Raw Steel Data
figure
set(gcf, 'Position', [50 50 1200 700]);
plot(tSteel, s)
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
title('Steel Beam Acceleration Raw Data')

%% Truncate Data of Aluminum Configuration
for idx = 1:length(tSteel)
    if tSteel(idx) == 1.93
        break
    end
end

tSteelBeg = tSteel(idx);
tSteelEnd = tSteelBeg + 7;
deltaTSteel = tSteel(2) - tSteel(1);   % time step
fsSteel = 1/deltaTSteel;          % sample rate
NBegSteel = round(tSteelBeg*fsSteel);  % starting sample
NEndSteel = round(tSteelEnd*fsSteel);  % ending sample
tSteel(NEndSteel+1:end) = []; s(NEndSteel+1:end) = [];
tSteel(1:NBegSteel) = []; s(1:NBegSteel) = [];
tSteel = tSteel - tSteel(1);   % start time at zero

s = s - mean(s);

%% Plot Truncated Data
figure
set(gcf, 'Position', [50 50 1200 700]);
plot(tSteel, s); hold on;
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
title('Steel Beam Acceleration Truncated Data')

%% Find distance between peaks
% Estimated period
dTSteel = 0.04;
[aPksSteel, tPksSteel] = findpeaks(s, tSteel, 'MinPeakDistance', 0.95*dTSteel);

%% Plot peaks
plot(tPksSteel, aPksSteel, 'o')
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')

%% Write data
steel_beam_trunc = table(tSteel, s);
writetable(steel_beam_trunc, 'Beam_TruncB.csv');