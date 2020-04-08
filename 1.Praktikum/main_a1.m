% MODSIM Laborpraktikum, 1. Aufgabe
% Prof. K. Janschek, Dr.-Ing. Th. Range, Dr.-Ing. S. Dyblenko
%
% main_a1.m - Realisierung der VPG-Methode mit Fehlerschätzung
% für PT1-Glied
% zu ergänzende Codezeilen sind mit ">>> ergänzen ...." und ...“gekennzeichnet
clear all % Lösche Arbeitsspeicher
Tm = 10; % Konstante des PT1, [s]
h = 0.1; % Schrittweite, (s)
t0 = 0; % Integrationsbeginn, [s]
tf = 300; % Integrationsende, [s]
t = []; % Zeitwerte für Plot [s]
d = []; % Fehler-Schätzwerte
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
 % Berechnung des Soll-Ausgangswertes
 ys(i) = %>>> ergänzen ....
 % Berechnung des Stellwertes
 u(i) = %>>> ergänzen ....
 % Berechnung des Ausgangswertes
 y(i) = system_pt1( ... , ... , ... , 3); %die Parameter einsetzen
 % Berechnung der Koeffizienten für VPG-Methode
 k1 = system_pt1( ... , ... , ... , 1); %die Parameter einsetzen
 k2 = system_pt1( ... , ... , ... , 1); %die Parameter einsetzen
 k3 = system_pt1( ... , ... , ... , 1); %die Parameter einsetzen
 % Wichtiger Hinweis: Die Parameter bei den Aufrufen von system_pt1(...)
 % müssen unter Beachtung von jeweiligen Zeitpunkten bestimmt werden!
 % Berechnung des Zustands-Schätzwertes x(ti+h)
 x(i+1) = %>>> ergänzen ....
 % Berechnung der LDF Fehlerabschätzung d(ti+h)
 d(i+1) = %>>> ergänzen ....

 t(i) = ti; % Zeitwert für Plot speichern
 ti = ti + h; % Zeitvariable um einen Schritt erhöhen
 i = i + 1; % Index inkrementieren
end
d = d(1:end-1);
result = [t;d];
% Anzeige der Ergebnisse
figure(1);
subplot(2,1,1); plot(t,u); title('Eingang PT1-Glied');zoom on;grid on;
subplot(2,1,2); plot(t,y); title('Ausgang PT1-Glied');zoom on;grid on;
xlabel('Zeit, s');
figure(2);
subplot(2,1,1); plot(t,y-ys,'.-'); title('GDF berechnet');zoom on;grid on;
tit=sprintf('LDF geschätzt: max. Betrag = %g',max(abs(d)));
subplot(2,1,2); plot(t,d,'.-'); title(tit);zoom on;grid on;
xlabel('Zeit, s');