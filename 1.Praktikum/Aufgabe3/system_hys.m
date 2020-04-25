% SUBSYSTEM DESCRIPTION: system_2.m
% Hysteresis Block

function  [xdot,y] = system_hys(x,u,t, memory)

% state equation (derivative)
xdot(1) = 0; % no states  ---> dummy output

global ha;
global he;

% output equation    
    if memory == -1
        if u < -ha
            y = (-1);
        else
            y = 0;
        end
    end
    
    if memory == 0
        if (u > -he) && (u < he)
            y = 0;
        elseif u >= he
            y = 1;
        elseif u <= -he
            y = (-1);
        end
    end
    
    if memory == 1
        if u > ha 
            y = 1; %u(1);
        else 
            y = 0; 
        end
    end 


