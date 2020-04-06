function uphi = hm_uphi(t)
%
% Funktion zur Berechnung der Steuergröße uphi(t)
% für Bahnanhebung nach HOHMANN
%
% Globale Variablen:
%	hm_uphi1 - Höhe des 1. Impulses
%	hm_t1    - Zeitpunkt des 1. Impulses
%	hm_dt1   - Länge des 1. Impulses
%	hm_uphi2 - Höhe des 2. Impulses
%	hm_t2    - Zeitpunkt des 2. Impulses
%	hm_dt2   - Länge des 2. Impulses
%
% T. Range 9.10.95
%
global hm_uphi1 hm_t1 hm_dt1 hm_uphi2 hm_t2 hm_dt2

uphi = 0;

if (t >= hm_t1) & (t < hm_t1+hm_dt1)
  uphi = hm_uphi1;
end
if (t >= hm_t2) & (t < hm_t2+hm_dt2)
  uphi = hm_uphi2;
end
