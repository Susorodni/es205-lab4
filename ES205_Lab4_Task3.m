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
m_adj_Alum = 0.00374;                                      % kg
m_adj_Steel = 0.0181;

m_Alum_final= m_Alum_eq + m_adj_Alum;                   % kg
m_Steel_final = m_Steel_eq + m_adj_Steel;               % kg

%% Natural Frequency Adjustment
omegan_Alum_final = sqrt(k_Alum/m_Alum_final);
omegan_Steel_final = sqrt(k_Steel/m_Steel_final); 
fn_Alum_final = omegan_Alum_final/(2*pi);
fn_Steel_final = omegan_Steel_final/(2*pi);

%% Dampening Calculation
zeta_Alum = 0.0042;
zeta_Steel = 0.0041;
c_Alum = ((2*zeta_Alum)/omegan_Alum_final)*k_Alum;
c_Steel = ((2*zeta_Steel)/omegan_Steel_final)*k_Steel;

%% Display Results
disp('Table 2')
disp('Aluminum')
disp(['Initial Natural Frequency    ', num2str(fn_Alum_init), ' Hz'])
disp(['Mass Adjustment              ', num2str(m_adj_Alum*1000), ' g'])
disp(['Stiffness                    ', num2str(k_Alum), ' units'])
disp(['Final Mass                   ', num2str(m_Alum_final*1000), ' g'])
disp(['Dampening                    ', num2str(c_Alum)])
disp(' ')
disp('Steel')
disp(['Initial Natural Frequency    ', num2str(fn_Steel_init), ' Hz'])
disp(['Mass Adjustment              ', num2str(m_adj_Steel*1000), ' g'])
disp(['Stiffness                    ', num2str(k_Steel), ' units'])
disp(['Final Mass                   ', num2str(m_Steel_final*1000), ' g'])
disp(['Dampening                    ', num2str(c_Steel)])
