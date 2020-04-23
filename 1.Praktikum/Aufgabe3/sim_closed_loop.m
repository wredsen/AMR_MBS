% MAIN SIMULATION PROGRAM: sim_closed_loop.m

% system parameter
global Tm;  % time constant PT1 system
Tm = 10;

global ha;  % hysteresis widths
global he;  
ha = 0.065;
he = 0.085;

model_name = 'sys_pt1_hy_cl';
u = 0;          % input modeled in the topology file!

global memo;    % global variable for hysteresis output
memo = 0;

global uStep;
uStep = 0.49;

%simulation parameter
t  = 0;                 % simulation start time
tf = 20;                 % simulation stop time
h  = 0.02;              % constant stepsize
ts = 2;                 % step time

% initial values
x = [0 0 0];              % x ... system state vector

% simulation
i=1;
repeat = 0; % repeats simulation step if != 0
while t <= tf+h         %   loop t = t0...tf
    [x,y,d] = VPG(model_name,x,u,t,h);
    x_values(i,:) = x;
    y_values(i,:) = y;
    t_values(i)   = t;
    
    % only the hysteresis output LDF = system output is of interest
    ldf_values(i) = d(2);
    
    [h, repeat] = stepWideControl(h, d(2));  %TODO: Schrittweitensteuerung einbauen
    if repeat == 0
        t = t + h;
        i = i+1;
    end
end % while

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
