% Analytische Berechnung von U2: AnalyticU2.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gruppe 10:
% Konstantin Kuhl
% Nils Leimbach
% Sebastian Schwabe
% Konstantin Wrede
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [out] = AnalyticU2(t)
global R;
global C1;
global C2;

out = 10 * (1 - exp(-t / (R * (C1 + C2))));

end