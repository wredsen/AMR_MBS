% Demoprogramm Mondlandung
%
% Th. Range 7.9.00

disp('Demoprogramm Mondlandung')
disp('========================')
disp(' ')

% Parameter setzen

r = 1738000;		% Mondradius [m]
c1 = 2.77e-4;		% [s/m]
c2 = 4.925e12;		% Grav. Konst. [m^3/s^2]
F1 = 36350;		% Schubkraft Hauptmotor [N]
T1 = 43.2;		% Zeitpunkt zum Umschalten F1 auf F2 [s]
F2 = 1308;		% Schubkraft kl. Düsen [N]
T2 = 210;		% Zeitpunkt zum Abschalten von F2 [s]

% Anfangswerte

h0 = 59404;		% Höhe [m]
v0 = -2003;		% Geschwindigkeit
m0 = 1038.358;		% Masse [kg]

% Simulation

lunland

% Ende
