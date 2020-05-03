% MAIN SIMULATION PROGRAM: sim_closed_loop.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gruppe 10:
% Konstantin Kuhl
% Nils Leimbach
% Sebastian Schwabe
% Konstantin Wrede
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;  % Loesche Arbeitsspeicher
tic
% system parameter
global Tm;  % PT1-Zeitkonstante
Tm = 10;

% Hysterese-Weiten
global ha;  
global he;  
ha = 0.065;
he = 0.085;

model_name = 'sys_pt1_hy_cl';
u = 0;          % input modeled in the topology file!

global memo;    % globale Variablen um Hysteresezustand zu speichern
global backup_memo; % Hysterese Zustand speichern fuer wiederholte Berechnungen
backup_memo = 0;

global u_step;   % Sprunghoehe des Eingangs
u_step = 0.17;   

%simulation parameter
t  = 0;                 % simulation start time
tf = 20;                % simulation stop time
h  = 0.1;                 % Initiale Schrittweite

% initial values
x = [0 0 0];            % x ... system state vector
h_array(1) = h;         % Schrittweiten fuer Plot  
ldf_values(1) = 0;      % LDF fuer Plot

% simulation
i=1;
while t <= tf+h         %   loop t = t0...tf
    
    % Berechnung neuer Blockzustaende, -ausgaenge, Schrittweite und LDF
    [x, y, h, d] = stepWidthControl(model_name, h, t, x);  
    
    x_values(i,:) = x;
    y_values(i,:) = y;
    t_values(i)   = t;
    h_array(i+1) = h;
    ldf_values(i+1) = d;
    
    t = t + h;
    i = i+1;
    
end % while
toc
% Trimmen der Plots
h_array = h_array(1:end-1);
ldf_values = ldf_values(1:end-1);

% Analytische Impulsweite und -periode
tau_e = -Tm * log(1-((he-ha)/(1+he-abs(u_step))));
tau_p = Tm * ( log((1-ha/abs(u_step))/(1-he/abs(u_step))) - log(1-(he-ha)/(1+he-abs(u_step))) );

% result visualisation
fprintf("impulse width: %f s  \n", tau_e)
fprintf("impulse period: %f s \n", tau_p)

figure(1);
subplot(3,1,1); plot(t_values, y_values(:,1),'.-'); title('Ausgang Addierer');zoom on;grid on;
subplot(3,1,2); plot(t_values, y_values(:,2),'.-'); title('Ausgang Hysterese');zoom on;grid on;
subplot(3,1,3); plot(t_values, y_values(:,3),'.-'); title('Ausgang PT1-Glied');zoom on;grid on;
xlabel('Zeit, s');

figure(2);
subplot(2,1,1); plot(t_values, ldf_values(:),'.-'); title('LDF nach RK3');zoom on;grid on;
subplot(2,1,2); plot(t_values,h_array,'.-'); title('h-Weite, s');zoom on;grid on;
xlabel('Zeit, s');
