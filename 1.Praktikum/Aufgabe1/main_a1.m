% MODSIM Laborpraktikum, 1. Aufgabe
% Prof. K. Janschek, Dr.-Ing. Th. Range, Dr.-Ing. S. Dyblenko
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gruppe 10:
% Konstantin Kuhl
% Nils Leimbach
% Sebastian Schwabe
% Konstantin Wrede
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main_a1.m - Realisierung der VPG-Methode mit Fehlerschaetzung für PT1-Glied

clear all % Loesche Arbeitsspeicher
tic
Tm = 10; % Konstante des PT1, [s]
global epsilon_float; % Konstante fuer sicheren Float-Vergleich an Sprungstelle
epsilon_float = 1e-12;            
h = 0.1; % Schrittweite, (s)
t0 = 0;  % Integrationsbeginn, [s]
tf = 300; % Integrationsende, [s]
t = []; % Zeitwerte fuer Plot [s]
d = []; % Fehler-Schuetzwerte
u = []; % Stellwerte u(t)
y = []; % Ausgangswerte y(t)
ys = []; % Soll-Ausgangswerte y_soll(t)
% Initialisierung
[dum,x(1)] = system_pt1([],[],[],0);
d(1) = 0;
% Integration nach VPG-Methode
ti = t0;
i = 1;
while ti <= tf
    
 % Analytische Berechnung des Ausgangswertes:
 % y(t) = 5*UnitStep(t-1) - 10*y'(t), AB: y(0) = x(0) = 0   
 if ti < 1.0 - epsilon_float
    ys(i) = 0;
 else
    ys(i) = 5*(1-exp((1-ti)/Tm)); 
 end

 % Berechnung des Stellwertes fuer den Plot
 u(i) = uStep(ti);
 
 % Berechnung des Ausgangswertes
 y(i) = system_pt1( ti , x(i) , uStep(ti) , 3); %die Parameter einsetzen
 % Berechnung der Koeffizienten fuer VPG-Methode
 k1 = system_pt1( ti , x(i) , uStep(ti) , 1); 
 k2 = system_pt1( ti + (h/2) , x(i) + (h/2)*k1 , uStep(ti+(h/2)) , 1);
 k3 = system_pt1( ti + h , x(i) - h*k1 + 2*h*k2 , uStep(ti+h) , 1);
 % Wichtiger Hinweis: Die Parameter bei den Aufrufen von system_pt1(...)
 % muessen unter Beachtung von jeweiligen Zeitpunkten bestimmt werden!
 
 % Berechnung des Zustands-Schaetzwertes x(ti+h)
 x(i+1) = x(i) + h*k2; 
 % Berechnung der LDF Fehlerabschaetzung d(ti+h)
 d(i+1) = (h/6)*(k1-2*k2+k3); 
 
 t(i) = ti; % Zeitwert fuer Plot speichern
 ti = ti + h; % Zeitvariable um einen Schritt erhoehen
 i = i + 1; % Index inkrementieren
 
end
toc

d = d(1:end-1);
result = [t;d];
% Anzeige der Ergebnisse
figure(1);
subplot(2,1,1); plot(t,u); title('Eingang PT1-Glied');zoom on;grid on;
subplot(2,1,2); plot(t,y); title('Ausgang PT1-Glied');zoom on;grid on;
xlabel('Zeit, s');
figure(2);
subplot(2,1,1); plot(t,ys-y,'.-'); title('GDF berechnet');zoom on;grid on;
tit=sprintf('LDF geschätzt: max. Betrag = %g',max(abs(d)));
subplot(2,1,2); plot(t,d,'.-'); title(tit);zoom on;grid on;
xlabel('Zeit, s');

% Berechnung des stetigen Stellwerts u(t) fuer den Funktionsaufruf mit halber Schrittweite
function outU = uStep(t)
    global epsilon_float;
    if t < 1.0 - epsilon_float
        outU = 0;
    else 
        outU = 5;
    end
end 