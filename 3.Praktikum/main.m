% MAIN SIMULATION PROGRAM OF DAE SYSTEM: main.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gruppe 10:
% Konstantin Kuhl
% Nils Leimbach
% Sebastian Schwabe
% Konstantin Wrede
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all;  % Loesche Arbeitsspeicher

% system parameter
global R;
global C1;
global C2;
R = 100;
C1 = 0.01;
C2 = 0.02;

%simulation parameter
t  = 0;                 % simulation start time
tf = 30;                % simulation stop time
global h;               % Schrittweite
h  = 0.001;

% initial values
z(1, :) = [10 * C1 / (R * (C1 + C2)), 10 * C2 / (R * (C1 + C2)), 10, 10/R];
x(1, :) = [0, 0];
us(1) = 10;
t_values(1) = 0;

% use single values
R = single(R);
C1 = single(C1);
C2 = single(C2);
t = single(t);
tf = single(tf);
h = single(h);
z = single(z);
x = single(x);
us = single(us);

u2_ana_values(1) = 0;
u2_errors(1) = 0;
newton_iter(1) = 0;

% Berechnung der Jacobi-Matrix
[J, J_inv] = JacobiMatrix();

% simulation
tic;
i = 1;
while t <= tf+h         %   loop t = t0...tf
    
    % Berechnung Folgezustand / algebraische Variablen mit TRA und Newton-Raphson
    [z(i+1, :), x(i+1, :), newton_iter(i+1)] = TRA(us(i), x(i, :), z(i, :), J_inv);  
    
    % Eingang ist konstanter Sprung bei ts = 0
    us(i+1) = 10;
    
    t = t + h;
    i = i + 1;
    
    % analytischer Vergleichswert und Abweichung
    u2_ana_values(i) = AnalyticU2(t);
    u2_errors(i) = x(i,2) - u2_ana_values(i);
    
    t_values(i) = t;
    
end % while
toc;


% result visualisation
figure(1);
subplot(4,1,1); plot(t_values, us,'.-', t_values, u2_ana_values, '.-'); 
legend("us ", "u2");title('Eingang Us und Ausgang U2 analytisch');zoom on;grid on;
subplot(4,1,2); plot(t_values, x(:,1),':', t_values, x(:,2), '--'); 
legend("u1", "u2");title('Ausgang U1 und U2 simuliert');zoom on;grid on;
subplot(4,1,3); plot(t_values, u2_errors,'.-'); title('Differenz von analytischem und simuliertem U2');zoom on;grid on;
xlabel('Zeit, s');

figure(2)
plot(t_values, newton_iter,'.-'); title('Anzahl der Newton-Raphson-Iterationen');zoom on;grid on;
xlabel('Zeit, s');

figure(3)
title_string = "GDF von U2 bei h = " + h + "";
plot(t_values, u2_errors,'.-'); title(title_string);zoom on;grid on;
xlabel('Zeit, s');