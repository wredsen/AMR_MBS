% STEPWIDTH CONTROL ALGORITHM:stepWidthControl.m

function [h, repeat] = stepWideControl(h_alt, LDF)

global Tm;

repeat = 0;
epsilon = 5e-6;

if LDF ~= 0  
    h_neu = h_alt*(epsilon/abs(LDF))^(1/3);    % Gleichung 3.8 Script MODSIM SIM03, p = p1 = 2

    h_min = 0.001;
    h_max = 1;

    if h_neu > 2*h_alt       %continue integration with new stepsize
        if h_neu < h_max  
            h = h_neu;   
        else
            h = h_max;
        end

    elseif (h_neu <= h_alt)
        if (0.75*h_neu) > h_min         %repeat last integration step with new stepsize
            h = 0.75*h_neu;
            repeat = 1;
        else
            h = h_min;
        end

    else
        h = h_alt; %continue integration without change of stepsize
    end
else
    h = h_alt;  % case: LDF=0
end