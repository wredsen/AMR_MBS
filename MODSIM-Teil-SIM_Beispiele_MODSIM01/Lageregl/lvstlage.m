% Command File für Vorlesungsbeispiel Attitude Control
%
% Satellit
isat= 480;
%
% 
% Modulator
TM=10;
h_on= 0.08;
h_off= 0.065;
b=1;
%
% Regler 
vr= 10;
%
%
% Lagesollwert in °
phi_soll=3;
%
% Störmoment
m_stoer = 0.5;
%
disp('Demo-Programm Lageregelung')
disp('==========================')
disp(' ')
disp(sprintf('Soll-Lage=%5.3f°, Stoermoment=%5.3f',phi_soll,m_stoer))
phi_soll = phi_soll *pi/180;
%
% Simulations-Struktur Lageregler
attctrl
%
