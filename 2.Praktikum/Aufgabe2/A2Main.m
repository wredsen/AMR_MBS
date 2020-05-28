%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gruppe 10:
% Konstantin Kuhl
% Nils Leimbach
% Sebastian Schwabe
% Konstantin Wrede
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;

% Modellparameter
global I_v_max;
I_v_max = 1;
global K_L;
K_L = 1;
global F_N;
F_N = 63000;
global K_sv;
K_sv = 0.796;
B_1 = 2.39e6;
C_o = 36.5e6;
M_k = 8.7;
M_p = 260;
M_g = M_k + M_p;
C_p = 75e6;
T_a = 0.015;


% Laden des Simulink Models
load_system('ZylinderSystem2');

% Berechnung der Matrizen des Zustandsraums
[A, B, C, D] = linmod('ZylinderSystem2'); % ohne weitere Parameter standardmäßig um RL u = x = 0

% Berechnung der Zeitdiskreten Zustandsmatrizen
phi_matrix = expm(A * T_a)

h_matrix = inv(A) * (phi_matrix - eye(size(phi_matrix,1))) * B

% Vergleich lineares zeitdiskretes Modell und 
% nichtlineares zeitkontinuierliches Modell
U_step = 5e-4;                  % im Beleg fuer U_step = 10e-4, 5*10e-4 und 10e-3 dargestellt
load_system('ModellVergleich2');
sim('ModellVergleich2');

plot(ans.compare_values.time, ans.compare_values.signals.values(:, 1),'.-',ans.compare_values.time, ans.compare_values.signals.values(:, 2),'.-');
ylabel('F_p / N');
xlabel('t / s');
legend('nichtlinear zeitkontinuierlicher Verlauf', 'linear zeitdiskreter Verlauf');
title_string = "Sprungantworten der Strecken bei U_{0} = " + U_step + " V";
title(title_string);
zoom on;
grid on;




