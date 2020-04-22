% STEPWIDTH CONTROL ALGORITHM:stepWidthControl.m

function h = stepWideControl(h_alt, LDF)

global Tm;
epsilon = 5e-6;

if LDF == 0
    h_neu = h_alt;
else  
    h_neu = h_alt*(epsilon/abs(LDF))^(1/3);    % Gleichung 3.8 Script MODSIM SIM03, p = p1 = 2
end
    
h_min = 0.001;
h_max = 1;

if h_neu > 2*h_alt
    if h_neu < h_max
        h = h_neu;    %continue integration with new stepsize
    else
        h = h_max;
    end
    
elseif (h_neu <= h_alt)
    if h_neu > h_min    
        h = 0,75*h_neu;  %repeat last integration step with new stepsize
    else
        h = h_min;
    end
    
else
    h = h_alt; %continue integration without change of stepsize
end