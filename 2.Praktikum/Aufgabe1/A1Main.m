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

% Laden des Simulink Models
load_system('ZylinderSystem1');

% Berechnung der Matrizen des Zustandsraums
[A, B, C, D] = linmod('ZylinderSystem1'); % ohne weitere Parameter standardmäßig um RL u = x = 0

% Berechnung der UTF und Modellparameter
[num, den] = ss2tf(A, B, C, D);
K_F_sim = num(4) / den(4);
a1_sim = den(3) / den(4);
a2_sim = den(2) / den(4);
a3_sim = den(1) / den(4);

% Analytische Berechnung
K_F_ana = K_L*K_sv*B_1;
a1_ana = B_1/C_p+B_1/C_o;
a2_ana = M_g/C_p;
a3_ana = M_g*B_1/(C_p*C_o);

% Ausgabe der simulierten und analytisch berechneten Parameter
fprintf("Vergleich simulierter und analytischer Parameter: \n")
fprintf("simuliertes K_F = %e, analytisches K_F = %e \n", K_F_sim, K_F_ana)
fprintf("simuliertes a1 = %e, analytisches a1 = %e \n", a1_sim, a1_ana)
fprintf("simuliertes a2 = %e, analytisches a2 = %e \n", a2_sim, a2_ana)
fprintf("simuliertes a3 = %e, analytisches a3 = %e \n", a3_sim, a3_ana)