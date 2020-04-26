% VPG 2. Ordnung mit RK3 LDF-Schaetzer: VPG.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gruppe 10:
% Nils Leimbach
% Konstantin Kuhl
% Sebastian Schwabe
% Konstantin Wrede
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [x_VPG, y, d_RK3] = VPG(model_name,x, t, h)

% Blockausgaenge, k-Faktoren
[k1, y]   = feval(model_name, x,        t     );
[k2, dum] = feval(model_name, x+(h/2)*k1, t+h/2 );
[k3, dum] = feval(model_name, x-h*k1+2*h*k2, t+h );

% Schaetzung des LDFs d_(i+1) nach RK3
d_RK3 = (h/6)*(k1-2*k2+k3);

% VPG Integrationsschritt
x_VPG = x + h*k2;

end