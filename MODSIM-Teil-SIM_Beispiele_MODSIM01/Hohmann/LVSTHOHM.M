% LVSTHOHM.M  -  Bahnmanöver für Kreisbahn (nach HOHMANN)
%                (Demo für LV Simulationstechnik)
%
% T. Range 7.9.00
%
disp('Demo-Programm: Bahnanhebung eines Satelliten nach HOHMANN')
disp('=========================================================')
disp(' ')

t0 = 0;			% Startzeit [s]
n = 3;			% Anzahl Umläufe
global R0;
R0 = 6378 + 400;	% Radius der 1. Kreisbahn [km]
R1 = 6378 + 1400;	% Radius der 2. Kreisbahn [km]

global ur uphi;
ur   = 'hm_ur';		% ur(t)
uphi = 'hm_uphi';	% uphi(t)

Mue = 3.986018E5;  	% [km^3/s^2]
Omega0 = sqrt(Mue/R0^3);
tf = n * 2*pi/Omega0;	% Integrationszeit-Ende (n Umläufe) [s]

global max_step_width
max_step_width = (tf-t0)/100;	% für mehr Stützwerte (bessere Plots...)

disp('1. Loesung mit Steuersignal aus linearem Ansatz')

% Berechnung der Parameter des Steuersignales uphi(t)
% fuer eine Bahnanhebung von R0 nach R1 nach HOHMANN

% 1. Impuls zur Zeit hm_t1

global hm_uphi1 hm_t1 hm_dt1 hm_uphi2 hm_t2 hm_dt2
hm_uphi1 = Omega0/4*(R1-R0);	% * Dirac(t-hm_t1)
hm_t1 = pi/Omega0;		% nach 1/2 Umkreisung
hm_dt1 = 1;

% 2. Impuls zur Zeit hm_t2

hm_uphi2 = Omega0/4*(R1-R0);	% * Dirac(t-hm_t2)
hm_t2 = hm_t1 + pi/Omega0;
hm_dt2 = 1;

% Erzeugung der zugehörigen Ereignistabelle fuer odeXX_et

global event_list
ev_list = [hm_t1-hm_dt1 hm_t1 hm_t1+hm_dt1 hm_t2-hm_dt2 hm_t2 hm_t2+hm_dt2]';
% Bem:	Die "Ereignisse" bei t1-dt1 und t2-dt2 dienen NUR dazu, uphi(t)
%	im Plot annähernd impulsförmig aussehen zu lassen. Läßt man diese
%	beiden Ereigniseinträge weg, ändert sich das ERGEBNIS nicht, aber
%	im Plot sieht uphi(t) u.U. sägezahnförmig aus, je nach vom RK-
%	Algorithmus gewählter Schrittweite...

disp('   Integration des nichtlinearen Modells...')
z0=[R0 0 0 Omega0]';
event_list = ev_list;
[t_lin,z_lin] = ode45_et('krb_nl',t0,tf,z0);

% uphi für Plot speichern
uphi_lin = [];
for i = 1:length(t_lin)
  uphi_lin(i) = feval(uphi,t_lin(i));
end

disp('2. Loesung mit Steuersignal aus nichtlinearem Ansatz')

% Berechnung der Parameter des Steuersignales uphi(t)

[dv_total dv1 dv2 t2] = hohmann(R0,R1);

% 1. Impuls zur Zeit hm_t1

hm_uphi1 = dv1;			% * Dirac(t-hm_t1)
hm_t1 = pi/Omega0;		% nach 1/2 Umkreisung
hm_dt1 = 1;

% 2. Impuls zur Zeit hm_t2

hm_uphi2 = dv2;			% * Dirac(t-hm_t2)
hm_t2 = hm_t1 + t2;
hm_dt2 = 1;

% Erzeugung der zugehörigen Ereignistabelle für odeXX_et

ev_list = [hm_t1-hm_dt1 hm_t1 hm_t1+hm_dt1 hm_t2-hm_dt2 hm_t2 hm_t2+hm_dt2]';

disp('   Integration des nichtlinearen Modells...')
z0=[R0 0 0 Omega0]';
event_list = ev_list;
[t_nl,z_nl] = ode45_et('krb_nl',t0,tf,z0);

% uphi für Plot speichern
uphi_nl = [];
for i = 1:length(t_nl)
  uphi_nl(i) = feval(uphi,t_nl(i));
end

disp('Anzeige der Steuersignale uphi(t)...')

fig1 = figure('Position',[40 40 580 390]);
clf
axis([t0 tf 0 1.1*hm_uphi1]);
subplot(211), plot(t_lin,uphi_lin,'b'), title('uphi(t) - lin. Ansatz')
subplot(212), plot(t_nl,uphi_nl,'r'), title('uphi(t) - nl. Ansatz')

input('Anzeige des Bahnverlaufs r(t):');

figure(fig1);
fig2 = figure('Position',[20 20 580 390]);
clf
axis([t0 tf R0-100 R1+300]);
subplot(111)
plot(t_lin,z_lin(:,1),'b',t_nl,z_nl(:,1),'r'), title('r(t) - lin. Ansatz (blau) / nl. Ansatz (rot)')

input('Anzeige in Polarkoordinaten:');

figure(fig1);
figure(fig2);
fig3 = figure('Position',[0 0 420 390]);
clf
axis([-(R1+500) R1+500 -(R1+500) R1+500]);
hold on
% subplot(121), 
polar(z_lin(:,3),z_lin(:,1),'b'), title (' ')
% , title('r(phi) (lin. Ansatz)')
% subplot(122), 
polar(z_nl(:,3),z_nl(:,1),'r'), title('r(phi) - lin. Ansatz (blau) / nl. Ansatz (rot)')
% title('r(phi) (nl. Ansatz)')
