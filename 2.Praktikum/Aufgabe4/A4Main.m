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
load_system('ZylinderSystem4');
set_param('ZylinderSystem4','maxstep','15e-3');

% Berechnung der Matrizen des Zustandsraums
[A, B, C, D] = linmod('ZylinderSystem4'); % ohne weitere Parameter standardmäßig um RL u = x = 0

% Berechnung der Zeitdiskreten Zustandsmatrizen
phi_matrix = expm(A * T_a);

h_matrix = inv(A) * (phi_matrix - eye(size(phi_matrix,1))) * B;

%%%%%% I-Anteil aus Aufgabe 3 %%%%%%
K_I_controller = 0.275;

%%%%%% Vergleich des linearen zeitdiskreten und nichtlinearen zeitkontinuierlichen geschlossenen Regelkreises %%%%%% 
U_step = 0.8;
load_system('VergleichGeschlossenerRK4');
set_param('VergleichGeschlossenerRK4','maxstep','15e-3')
sim('VergleichGeschlossenerRK4');

figure(1);
plot(ans.compare_values.time, ans.compare_values.signals.values(:, 2),'.-',ans.compare_values.time, ans.compare_values.signals.values(:, 1),'.-');
ylabel('F_p / N');
xlabel('t / s');
legend('nichtlinear zeitkontinuierlicher Verlauf', 'linear zeitdiskreter Verlauf');
title_string = "Sprungantworten der Strecken bei U_{0} = " + U_step + " V";
title(title_string);
zoom on;
grid on;


%%%%%% Kritische Reglerverstärkung K_I %%%%%%

% U_step = 0.1
U_step = 0.1;
K_I_controller = 2.47;
load_system('NlZkGeschlossenerKreis');
set_param('NlZkGeschlossenerKreis','maxstep','15e-3')
sim('NlZkGeschlossenerKreis');

figure(2);
plot(ans.nl_zk_out.time, ans.nl_zk_out.signals.values(:),'.-');
ylabel('F_p / N');
xlabel('t / s');
title_string = "Sprungantworten des geschlossenen Kreises bei U_{0} = " + U_step + " V, K_{I} = " + K_I_controller + " s^{-1}";
title(title_string);
zoom on;
grid on;

% U_step = 0.5
U_step = 0.5;
K_I_controller = 5.6;
sim('NlZkGeschlossenerKreis');

figure(3);
plot(ans.nl_zk_out.time, ans.nl_zk_out.signals.values(:),'.-');
ylabel('F_p / N');
xlabel('t / s');
title_string = "Sprungantworten des geschlossenen Kreises bei U_{0} = " + U_step + " V, K_{I} = " + K_I_controller + " s^{-1}";
title(title_string);
zoom on;
grid on;

% U_step = 0.8
U_step = 0.8;
K_I_controller = 17;
sim('NlZkGeschlossenerKreis');

figure(4);
plot(ans.nl_zk_out.time, ans.nl_zk_out.signals.values(:),'.-');
ylabel('F_p / N');
xlabel('t / s');
title_string = "Sprungantworten des geschlossenen Kreises bei U_{0} = " + U_step + " V, K_{I} = " + K_I_controller + " s^{-1}";
title(title_string);
zoom on;
grid on;