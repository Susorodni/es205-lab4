% Task 9
clc; clear variables; close all;

X = readmatrix('task7_Parameters.csv');

m = X(1);  c = X(2);  k = X(3); C = X(4); R = X(5); theta = X(6);


%% solve for transfer function
%syms R C m k c theta
syms s F Y V
eq1 = R*C*V*s + V + R*theta*Y*s == 0;
eq2 = m*Y*s^2 + c*Y*s + k*Y - theta*V == F;
equations = [eq1; eq2];
unknowns = [V; Y];
solutions = solve(equations, unknowns);
G_sym = solutions.V/F;
G_sym = collect(G_sym,s);
pretty(G_sym)


%% task 9
[N,D]=numden(G_sym);
num = sym2poly(N); den = sym2poly(D);

G = tf(num,den);

Fin = 10;  t = 0:0.0001:8;
step_opts = stepDataOptions('StepAmplitude', Fin);
[x,t] = step(G, t, step_opts);

figure; hold on; set(gcf, 'Position', [100 50 1000 700])
plot(t,x)
xlabel('Time (s)')
ylabel('Voltage (V)')

