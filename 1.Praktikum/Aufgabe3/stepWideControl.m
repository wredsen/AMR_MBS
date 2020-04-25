% STEPWIDTH CONTROL ALGORITHM:stepWidthControl.m

function [h, repeat] = stepWideControl(h_alt, LDF)

global Tm;
global uStep;

repeat = 0;
epsilon = 5e-9; % kleineres maximales LDF, da Hystereseausgang sonst nicht diskret 1 oder 0, TODO: ist das so?

h_min = epsilon*6/(uStep/Tm);   % -> Beleg
h_max = 2*Tm;                   % -> Beleg

if LDF ~= 0  
    h_neu = h_alt*(epsilon/abs(LDF))^(1/3);    % Gleichung 3.8 Script MODSIM SIM03, p = p1 = 2
    if h_neu < h_min
        h_neu = h_min;
    elseif h_neu > h_max
        h_neu = h_max;
    end

    if h_neu > 2*h_alt          %continue integration with new stepsize  
        h = h_neu;   
    elseif h_neu <= h_alt       %repeat last integration step with new stepsize        
        h = 0.75*h_neu;
        repeat = 1;
    else
        h = h_alt;              %continue integration without change of stepsize
    end
else
    h = h_alt;                  % falls LDF d=0 -> TODO: Begründung
end