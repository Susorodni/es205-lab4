% ES205 Lab 4 Task 3
clear variables; close all; clc

%% Beam Properties
rho_Alum = 2700;                                        % kg/m^3
rho_Steel = 7870;                                       % kg/m^3
E_Alum = 68.9*(10^9);                                   % Pa
E_Steel = 186*(10^9);                                   % Pa

% Dimensions
h = 0.123/39.37;                                        % m
b = 1.000/39.37;                                        % m
L = 12.000/39.37;                                       % m

%% Masses of Beams
V = L*b*h;                                              % m^3
m_Alum_eq = rho_Alum*V*0.23;                            % kg
m_Steel_eq = rho_Steel*V*0.23;                          % kg

%% Stiffness of Beams
I = (1/12)*b*(h^3);                                     % m^4
k_Alum = (3*E_Alum*I)/(L^3);                            % ???
k_Steel = (3*E_Steel*I)/(L^3);

%% Predicted Natural Frequency
omegan_Alum_init = sqrt(k_Alum/m_Alum_eq);              % rad/s
omegan_Steel_init = sqrt(k_Steel/m_Steel_eq);           % rad/s
fn_Alum_init = omegan_Alum_init/(2*pi);                 % Hz
fn_Steel_init = omegan_Steel_init/(2*pi);               % Hz

%% Mass Adjustment
% Adjust until fn_Alum_final becomes 24.98 Hz
m_adj_Alum = 0.0041;                                      % kg

m_Alum_final= m_Alum_eq + m_adj_Alum;                   % kg

%% Natural Frequency Adjustment
omegan_Alum_final = sqrt(k_Alum/m_Alum_final);
fn_Alum_final = omegan_Alum_final/(2*pi);

%% Display Results
disp('Table 2')
disp('Aluminum')
disp(['Initial Natural Frequency ', num2str(fn_Alum_init), ' Hz'])
disp(['Mass Adjustment           '])
disp(['Stiffness                 ', num2str(k_Alum), ' units'])
