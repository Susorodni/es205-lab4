% ES205 Lab 4 Task 3
clear variables; close all; clc

E_a = 68.9; % GPa
rho_a = 2700; %kg/m^3

% convert to pascals
E_a = E_a*1e9; % Pa

h = 0.123; % in
b = 1.000; % in
L = 12; % in

% convert to meters
h = h/39.37; % m
b = b/39.37; % m
L = L/39.37; % m


m_eq_a = 0.23*rho_a*b*h*L;
I_a = (b*h^3)/12;
k_a = 3*E_a*I_a/(L^3);

wn_a = sqrt(k_a/m_eq_a); % rad/s
fn_a_i = wn_a/(2*pi); % Hz


fn_a_act = 156.98811/(2*pi); % Hz

fn_a = fn_a_i;
tol = 1e-4;
m_adj = 0;


while abs(fn_a - fn_a_act) > tol
    m_adj = m_adj + 0.0001;
    fn_a = sqrt(k_a/(m_eq_a + m_adj*1e-3))/(2*pi);
end

m_adj