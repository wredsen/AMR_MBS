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
K_M = 1/63000;

%%%%%% Linears zeitdiskretes System %%%%%%
% Laden des Simulink Modells
load_system('ZylinderSystem3');

% Berechnung der Matrizen des Zustandsraums
[A, B, C, D] = linmod('ZylinderSystem3'); % ohne weitere Parameter standardmäßig um RL u = x = 0

% Berechnung der Zeitdiskreten Zustandsmatrizen
phi_matrix = expm(A * T_a);

h_matrix = inv(A) * (phi_matrix - eye(size(phi_matrix,1))) * B;

%%%%%% Offener Regelkreis zur Ermittlung von I-Anteil %%%%%% 
K_I_controller = 1;
load_system('OffenerRegelkreis3');
[A_d, B_d, C_d, D_d] = dlinmod('OffenerRegelkreis3', T_a);
figure(1);
dbode(A_d, B_d, C_d, D_d, T_a, 1, logspace(-1, 1, 1000));
grid;

K_I_controller = 0.275;

%%%%%% Überschwingen des Geschlossenen Regelkreises %%%%%% 
U_step = 0.5;
load_system('GeschlossenerRegelkreis3');
sim('GeschlossenerRegelkreis3');

figure(2);
plot(ans.closed_loop_out.time, ans.closed_loop_out.signals.values(:),'.-');
ylabel('F_p / N');
xlabel('t / s');
title_string = "Sprungantworten des geschlossenen Kreises bei U_{0} = " + U_step + " V, K_{I} = " + K_I_controller + " s^{-1}";
title(title_string);
zoom on;
grid on;

%%%%%% Kritische Reglerverstärkung K_I %%%%%% 
K_I_controller = 2.214;
sim('GeschlossenerRegelkreis3');

figure(3);
plot(ans.closed_loop_out.time, ans.closed_loop_out.signals.values(:),'.-');
ylabel('F_p / N');
xlabel('t / s');
title_string = "Sprungantworten des geschlossenen Kreises bei U_{0} = " + U_step + " V, K_{I} = " + K_I_controller + " s^{-1}";
title(title_string);
zoom on;
grid on;