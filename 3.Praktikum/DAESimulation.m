% MAIN SIMULATION PROGRAM: DAESimulation.m
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
u2_values(1) = 0;
u2_errors(1) = 0;

% Berechnung der Jacobi-Matrix
[J, J_inv] = JacobiMatrix();

% simulation
tic;
n = 1;
while t <= tf+h         %   loop t = t0...tf
    
    % Berechnung Folgezustand / algebraische Variablen mit TRA und Newton-Raphson
    [z(n+1, :), x(n+1, :)] = TRA(us(n), x(n, :), z(n, :), t, J_inv);  
    
    % Eingang ist konstanter Sprung bei ts = 0
    us(n+1) = 10;
    
    t = t + h;
    n = n + 1;
    
    % analytischer Vergleichswert und Abweichung
    u2_values(n) = AnalyticU2(t);
    u2_errors(n) = x(n,2) - u2_values(n);
    
    t_values(n) = t;
    
end % while
toc;


% result visualisation
figure(1);
subplot(4,1,1); plot(t_values, x(:,2),'.-', t_values, u2_values, '.-'); 
legend("u2 approx", "u2 analytic");title('u2 approx and u2 analytic');zoom on;grid on;
subplot(4,1,2); plot(t_values, u2_errors,'.-'); title('u2 error');zoom on;grid on;
subplot(4,1,3); plot(t_values, us,'.-', t_values, u2_values, '.-'); 
legend("u_s ", "u2 analytic");title('u_s and u2 analytic');zoom on;grid on;
subplot(4,1,4); plot(t_values, x(:,1),'.-', t_values, x(:,2), '.-'); 
legend("u1 approx ", "u2 approx");title('u1 and u2 approx');zoom on;grid on;
xlabel('Zeit, s');

