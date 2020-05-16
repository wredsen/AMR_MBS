%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gruppe 10:
% Konstantin Kuhl
% Nils Leimbach
% Sebastian Schwabe
% Konstantin Wrede
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function xdot_o = Servoventil(muxed_input)

f_z = muxed_input(1);
i_v = muxed_input(2); 
global F_N;
global K_sv;

a = 1 - (f_z / F_N) * sign(i_v);

if a > 0
    xdot_o = i_v * K_sv * sqrt(a);
else
    xdot_o = 0;
end
end
