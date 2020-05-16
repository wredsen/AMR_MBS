%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gruppe 10:
% Konstantin Kuhl
% Nils Leimbach
% Sebastian Schwabe
% Konstantin Wrede
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function i_v = Leistungsstufe(u)

global K_L;
global I_v_max;

if u > 1
    i_v = I_v_max;
elseif u <-1
    i_v = -I_v_max;
else
    i_v = K_L * u;
end
end