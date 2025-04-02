% ES205 Lab 4 Task 4
clear variables; close all; clc

%% Load Data
filename_Alum = 'Beam_TruncA.csv';
X_Alum = readtable(filename_Alum, 'NumHeaderLines', 0);
t_Alum = X_Alum.tAlum;  a = X_Alum.a;
y0_Alum = -0.00006; m_Alum = 18.6803/1000;  k_Alum = 471.1558;   c_Alum = 0.020515;

options = odeset('AbsTol', 0.00001, 'RelTol', 0.00001);
q0_Alum = [y0_Alum; 0];  % initial conditions
[~, q_Alum] = ode45(@ODEbeam, t_Alum, q0_Alum, options, m_Alum, k_Alum, c_Alum);

y_Alum = q_Alum(:,1);
ydot_Alum = q_Alum(:,2);
aStar_Alum = -(1/m_Alum)*(c_Alum*ydot_Alum + k_Alum*y_Alum);

figure; set(gcf, 'Position', [50 50 1200 700]); hold on
plot(t_Alum, a, t_Alum, aStar_Alum)
plot(t_Alum, aStar_Alum, 'o', 'MarkerSize', 1, 'MarkerFaceColor', 'r')
xlabel('Time (s)'); ylabel('Acceleration (m/s^2)')
grid on
legend('Measured', 'Model')