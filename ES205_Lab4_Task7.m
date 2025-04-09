% ES205 Lab 4 Task 7
clc; clear variables; close all;
filename = 'Beam_TruncC.csv';

X = readtable(filename);
t = X.t; v = X.v;  a = X.a;
idx = find(abs(t-1) < 1e-5);
t_cut = t(1:idx); v_cut = v(1:idx); a_cut = a(1:idx);

% initial guesses
z = readmatrix('Piezo_parameters.csv');
y0 = z(1);
m = z(2);
c = z(3);
k = 471.1558;
theta0 = 1;

%% ode45 shenanigans
options = odeset('AbsTol', 0.00001, 'RelTol', 0.00001);
q0 = [y0; 0; v(1)];
[~, q] = ode45(@ODEpiezo, t_cut, q0, options, m, k, c, theta0);


plot(t_cut,v_cut*1000,t_cut,q(:,3))
legend('1','2')

%% fminsearch
options = optimset('Display','iter');

theta_best = fminsearch(@(theta)errorFunctionPiezo(z,v_cut,t_cut,k,theta),theta0,options);

[~, q] = ode45(@ODEpiezo, t, q0, options, m, k, c, theta_best);

v_opt = q(:,3);

figure; set(gcf, 'Position', [50 50 1200 700]); hold on
plot(t_cut,v_cut,t_cut,v_opt(1:idx))
xlabel('Time (s)')
ylabel('Voltage (V)')
grid on
legend('Measured','Optimized Model')


%% plot over whole range
figure; set(gcf, 'Position', [50 50 1200 700]); hold on
plot(t,v,t,v_opt)
xlabel('Time (s)')
ylabel('Voltage (V)')
grid on
legend('Measured','Optimized Model')

%% output
Cp = 9.62e-9;  RL = 10e3;

parameters = [m c k Cp RL theta_best]';
writematrix(parameters, 'task7_Parameters.csv');



