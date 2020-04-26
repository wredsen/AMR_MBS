% Test des Hysterese-Blocks: hysterese.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gruppe 10:
% Nils Leimbach
% Konstantin Kuhl
% Sebastian Schwabe
% Konstantin Wrede
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% system I/O
u_values = [];  % input
y_values = [];  % output
u = -0.1;
y = -1;  

% hysteresis width
global he;
global ha;
he = 0.085;
ha = 0.065;

%simulation parameter
t  = 0;                 % simulation start time
tf = 0.4;                 % simulation stop time
h  = 1e-3;              % constant stepsize


% simulation
i=1;
while t <= tf+h         %   loop t = t0...tf
    
    if (t < 0.2)
        u = u+h;
    else
        u = u-h;
    end
    
    
    
    y = hysteresis(u, y);
    
    u_v(i) = u;
    y_v(i) = y;
    t_v(i) = t;
    
    t = t + h;
    i = i+1;
    
end % while

% result visualisation
figure(1);
plot(t_v, u_v,'.-'); title('input');zoom on;grid on;

figure(2);
plot(t_v, y_v,'.-'); title('output');zoom on;grid on;


function out = hysteresis(u, y_old)

    global he;
    global ha;

    if sign(y_old) == -1
        if u < -ha
            out = -2;
        else
            out = 0;
        end
    end
    
    if y_old == 0
        if (u > -he) && (u < he)
            out = 0;
        elseif u >= he
            out = 2;
        elseif u <= -he
            out = -2;
        end
    end
    
    if sign(y_old) == 1
        if u > ha 
            out = 2;
        else 
            out = 0;
        end
    end 
end