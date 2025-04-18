% ES205 Lab 4 Task 4
clc; clear variables; close all;

%% Load data
filename_Alum = 'Beam_TruncA.csv';
filename_Steel = 'Beam_TruncB.csv';

X_Alum = readtable(filename_Alum);
X_Steel = readtable(filename_Steel);
t_Alum = X_Alum.tAlum;  a_Alum = X_Alum.a;
t_Steel = X_Steel.tSteel;   a_Steel = X_Steel.s;
y0_Alum = -0.00006;  m_Alum = 18.6803/1000;  k_Alum = 471.1558; c_Alum = 0.020515; % initial guesses
y0_Steel = -0.00006;  m_Steel = 43.8/1000;  k_Steel = 1271.9; c_Steel = 0.0727; % initial guesses

%% Create ODE of model
options = odeset('AbsTol', 0.00001, 'RelTol', 0.00001);
q0_Alum = [y0_Alum;0];
q0_Steel = [y0_Steel;0];
[~, q_Alum] = ode45(@ODEbeam, t_Alum, q0_Alum, options, m_Alum, k_Alum, c_Alum);
[~, q_Steel] = ode45(@ODEbeam, t_Steel, q0_Steel, options, m_Steel, k_Steel, c_Steel);

y_Alum = q_Alum(:,1);
ydot_Alum = q_Alum(:,2);
aStar_Alum = -(1/m_Alum)*(c_Alum*ydot_Alum + k_Alum*y_Alum);

y_Steel = q_Steel(:,1);
ydot_Steel = q_Steel(:,2);
aStar_Steel = -(1/m_Steel)*(c_Steel*ydot_Steel + k_Steel*y_Steel);

%% Plot original models
figure; set(gcf, 'Position', [50 50 1200 700]); hold on
plot(t_Alum, a_Alum, t_Alum, aStar_Alum)
plot(t_Alum, aStar_Alum, 'o', 'MarkerSize', 1, 'MarkerFaceColor','r')
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
grid on
legend('Measured','Model')
title('Aluminum Acceleration Model')

% figure; set(gcf, 'Position', [50 50 1200 700]); hold on
% plot(t_Steel, a_Steel, t_Steel, aStar_Steel)
% plot(t_Alum, aStar_Alum, 'o', 'MarkerSize', 1, 'MarkerFaceColor','r')
% xlabel('Time (s)')
% ylabel('Acceleration (m/s^2)')
% grid on
% legend('Measured','Model')
% title('Steel Acceleration Model')

%% run optimization function
z0_Alum = [y0_Alum; m_Alum; c_Alum]; % initial guesses, again
options = optimset('Display','iter');
z_Alum = fminsearch(@(z)errorFunctionAccel(z,a_Alum,t_Alum,k_Alum),z0_Alum,options);
y0_Alum = z_Alum(1);
m_Alum = z_Alum(2);
c_Alum = z_Alum(3);

z0_Steel = [y0_Steel; m_Steel; c_Steel]; % initial guesses, again
options = optimset('Display','iter');
z_Steel = fminsearch(@(z)errorFunctionAccel(z,a_Steel,t_Steel,k_Steel),z0_Steel,options);
y0_Steel = z_Steel(1);
m_Steel = z_Steel(2);
c_Steel = z_Steel(3);

%% solve model with new parameters
options = odeset('AbsTol', 0.00001, 'RelTol', 0.00001);
q0_Alum = [y0_Alum;0];
[~, q_Alum] = ode45(@ODEbeam, t_Alum, q0_Alum, options, m_Alum, k_Alum, c_Alum);

y_Alum = q_Alum(:,1);
ydot_Alum = q_Alum(:,2);
aStar_Alum = -(1/m_Alum)*(c_Alum*ydot_Alum + k_Alum*y_Alum);

options = odeset('AbsTol', 0.00001, 'RelTol', 0.00001);
q0_Steel = [y0_Steel;0];
[~, q_Steel] = ode45(@ODEbeam, t_Steel, q0_Steel, options, m_Steel, k_Steel, c_Steel);

y_Steel = q_Steel(:,1);
ydot_Steel = q_Steel(:,2);
aStar_Steel = -(1/m_Steel)*(c_Steel*ydot_Steel + k_Steel*y_Steel);

%% plot optimized model
figure; set(gcf, 'Position', [50 50 1200 700]); hold on
plot(t_Alum, a_Alum, t_Alum, aStar_Alum)
plot(t_Alum, aStar_Alum, 'o', 'MarkerSize', 1, 'MarkerFaceColor','r')
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
grid on
legend('Measured','Optimized Model')
title('Optimized Model of Aluminum Beam')

figure; set(gcf, 'Position', [50 50 1200 700]); hold on
plot(t_Steel, a_Steel, t_Steel, aStar_Steel)
plot(t_Steel, aStar_Steel, 'o', 'MarkerSize', 1, 'MarkerFaceColor','r')
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
grid on
legend('Measured','Optimized Model')
title('Optimized Model of Steel Beam')