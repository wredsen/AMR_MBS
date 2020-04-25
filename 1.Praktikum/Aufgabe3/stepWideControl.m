% STEPWIDTH CONTROL ALGORITHM:stepWidthControl.m

function [x, y, h, LDF] = stepWideControl(model_name, h, ti, x_in)  

global Tm;
global uStep;
global memo;
global backup_memo;

epsilon = 5e-10;      % kleineres maximales LDF, da Hystereseausgang sonst nicht diskret 1 oder 0, TODO: ist das so?
h_min = epsilon*6/(uStep/Tm);   % -> Beleg, TODO: ist diese hier richtig?, damit epsilon eingehalten wird muss es kleiner gewählt werden...
h_max = 2*Tm;                   % -> Beleg

repeat = 1;

while repeat == 1
    memo = backup_memo;
    [dum1, dum2, LDF] = VPG(model_name, x_in, ti, h);   

    if LDF ~= 0  
        h_neu = h*(epsilon/abs(LDF))^(1/3);    % Gleichung 3.8 Script MODSIM SIM03, p = p1 = 2
        if h_neu < h_min
            h_neu = h_min;
        elseif h_neu > h_max
            h_neu = h_max;
        end

        if h_neu > 2*h          %continue integration with new stepsize  
            h = h_neu;   
            repeat = 0;
        elseif h_neu <= h       %repeat last integration step with new stepsize        
            h = 0.75*h_neu;
        else                    %continue integration without change of stepsize
            h = h;             
            repeat = 0;
        end
    else                        %falls LDF d=0
        h = h;
        repeat = 0;             % TODO: Forenbeitrag: hier sollte h = h_max sein
    end
end

memo = backup_memo;
% Berechnung Systemzustand und -ausgabe mit neuer Schrittweite
[x, y, dum3] = VPG(model_name, x_in, ti, h);
% aktualisieren des Hysterese-Zustands
backup_memo = memo;