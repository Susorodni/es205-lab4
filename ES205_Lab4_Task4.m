% ES205 Lab 4 Task 4
clc; clear variables; close all;
filename = 'Beam_TruncA.csv';

X = readtable(filename);
t = X.tAlum;  a = X.a;
y0 = -0.00006;  m = 18.6803/1000;  k = 471.1558; c = 0.020515; % initial guesses


options = odeset('AbsTol', 0.00001, 'RelTol', 0.00001);
q0 = [y0;0];
[~, q] = ode45(@ODEbeam, t, q0, options, m, k, c);

y = q(:,1);
ydot = q(:,2);
aStar = -(1/m)*(c*ydot + k*y);

% plot with original parameters
figure; set(gcf, 'Position', [50 50 1200 700]); hold on
plot(t, a, t, aStar)
plot(t, aStar, 'o', 'MarkerSize', 1, 'MarkerFaceColor','r')
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
grid on
legend('Measured','Model')


% run optimization function
z0 = [y0; m; c]; % initial guesses, again
options = optimset('Display','iter');
z = fminsearch(@(z)errorFunctionAccel(z,a,t,k),z0,options);
y0 = z(1);
m = z(2);
c = z(3);

% solve model with new parameters
options = odeset('AbsTol', 0.00001, 'RelTol', 0.00001);
q0 = [y0;0];
[~, q] = ode45(@ODEbeam, t, q0, options, m, k, c);

y = q(:,1);
ydot = q(:,2);
aStar = -(1/m)*(c*ydot + k*y);

% plot optimized model
figure; set(gcf, 'Position', [50 50 1200 700]); hold on
plot(t, a, t, aStar)
plot(t, aStar, 'o', 'MarkerSize', 1, 'MarkerFaceColor','r')
xlabel('Time (s)')
ylabel('Acceleration (m/s^2)')
grid on
legend('Measured','Optimized Model')