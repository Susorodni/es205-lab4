%% Task 8
clear variables; close all; clc

 syms R C m k c theta
 syms s F Y V

eq1 = R*C*V*s +V + R*theta*Y*s == 0;
eq2 = m*Y*s^2 +c*Y*s +k*Y - theta*V == F;

equations = [eq1;eq2];
unknowns = [V;Y];
solutions = solve(equations,unknowns);
G = solutions.V/F;


pretty(G)


X = readmatrix('task7_Parameters.csv');
C = X(4);
R = X(5);
k = X(3);
m = X(1);
c = X(2);
theta =X(6);

poles = roots([(C*R*m)/k (C*R*c+m)/k (R*theta^2+c+C*R*k)/k 1]);
zeros = roots([(R*theta)/k 0]);