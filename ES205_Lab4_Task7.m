% ES205 Lab 4 Task 7
clc; clear variables; close all;
filename = 'Beam_TruncC.csv';

X = readtable(filename);
t = X.t; v = X.v;  a = X.a;
idx = find(abs(t-1) < 1e-5);
t_cut = t(1:idx); v_cut = v(1:idx); a_cut = a(1:idx);

% initial guesses
z0 = readmatrix('Piezo_parameters.csv');
y0 = z0(1);
m = z0(2);
c = z0(3);
k = 471.1558;
theta = 1;

%% ode45 shenanigans
options = odeset('AbsTol', 0.00001, 'RelTol', 0.00001);
q0 = [y0;0;v(1)];
[~, q] = ode45(@ODEpiezo, t_cut, q0, options, m, k, c, theta);


plot(t_cut,v_cut*1000,t_cut,q(:,3))
legend('1','2')