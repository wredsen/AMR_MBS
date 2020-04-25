% MAIN SIMULATION PROGRAM: sim_closed_loop.m

clear all;  % Workspace leeren
% system parameter
global Tm;  % time constant PT1 system
Tm = 10;

global ha;  % hysteresis widths
global he;  
ha = 0.065;
he = 0.085;

model_name = 'sys_pt1_hy_cl';
u = 0;          % input modeled in the topology file!

global memo;    % global variable to memorize hysteresis output
global backup_memo; % Hysterese Zustand speichern fuer wiederholte Berechnungen
backup_memo = 0;

global uStep;
uStep = 0.49;

%simulation parameter
t  = 0;                 % simulation start time
tf = 20;                 % simulation stop time
h  = 0.02;              % constant stepsize

% initial values
x = [0 0 0];              % x ... system state vector
h_array(1) = h;
ldf_values(1) = 0;

% simulation
i=1;
while t <= tf+h         %   loop t = t0...tf
    
    [x, y, h, d] = stepWideControl(model_name, h, t, x);  %TODO: Schrittweitensteuerung fixen
    
    x_values(i,:) = x;
    y_values(i,:) = y;
    t_values(i)   = t;
    h_array(i+1) = h;
    
    ldf_values(i+1) = d;
    
    t = t + h;
    i = i+1;
    
end % while
% Trimmen der Plots
h_array = h_array(1:end-1);
ldf_values = ldf_values(1:end-1);

% analytic impulsewidth and -period
tau_e = -Tm * log(1-((he-ha)/(1+he-abs(uStep))));
tau_p = Tm * ( log((1-ha/abs(uStep))/(1-he/abs(uStep))) - log(1-(he-ha)/(1+he-abs(uStep))) );

% result visualisation

fprintf("impulse width: %f s  \n", tau_e)
fprintf("impulse period: %f s \n", tau_p)

figure(1);
plot(t_values, y_values(:,1),'.-'); title('output substractor');zoom on;grid on;

figure(2);
plot(t_values, y_values(:,2),'.-'); title('output hysteresis');zoom on;grid on;

figure(3);
plot(t_values, y_values(:,3),'.-'); title('output PT1');zoom on;grid on;

figure(4);
plot(t_values, ldf_values(:),'.-'); title('RK3 estimatet LDF');zoom on;grid on;

figure(5);
plot(t_values,h_array,'.-'); title('h-Weite');zoom on;grid on;