% Task 8
clc; clear variables; close all;

%% solve for transfer function
syms R C m k c theta
syms s F Y V
eq1 = R*C*V*s + V + R*theta*Y*s == 0;
eq2 = m*Y*s^2 + c*Y*s + k*Y - theta*V == F;
equations = [eq1; eq2];
unknowns = [V; Y];
solutions = solve(equations, unknowns);
G = solutions.V/F;
pretty(G)
