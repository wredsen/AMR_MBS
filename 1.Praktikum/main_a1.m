% MODSIM Laborpraktikum, 1. Aufgabe
% Prof. K. Janschek, Dr.-Ing. Th. Range, Dr.-Ing. S. Dyblenko
%y(t) = c_1 e^(-t/10) - 5 e^((1 - t)/10) θ(t - 1) + 5 θ(t - 
% main_a1.m - Realisierung der VPG-Methode mit Fehlersch�tzung
% f�r PT1-Glied
% zu erg�nzende Codezeilen sind mit ">>> erg�nzen ...." und ...�gekennzeichnet

clear all % L�sche Arbeitsspeicher
Tm = 10; % Konstante des PT1, [s]
h = 0.1; % Schrittweite, (s)
t0 = 0; % Integrationsbeginn, [s]
tf = 300; % Integrationsende, [s]
t = []; % Zeitwerte f�r Plot [s]
d = []; % Fehler-Sch�tzwerte
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
 % Berechnung des Soll-Ausgangswertes: into WolframAlpha: y(t) =
 % 5*UnitStep(t-1) - 10*y'(t), AB: y(0) = x(0) = 0
 if ti < 1
    ys(i) = 0;
 else
    ys(i) = 5*(1-exp((1-ti)/Tm)); 
 end
 
 % Berechnung des Stellwertes
 if ti < 1
    u(i) = 0;
 else
    u(i) = 5;
 end 
 
 % Berechnung des Ausgangswertes
 y(i) = system_pt1( ti , x(i) , u(i) , 3); %die Parameter einsetzen
 % Berechnung der Koeffizienten f�r VPG-Methode(aus VL, Übungslösung Sim02)
 k1 = system_pt1( ti , x(i) , u(i) , 1); %die Parameter einsetzen
 k2 = system_pt1( ti + (h/2) , x(i) + (h/2)*k1 , uStep(ti+(h/2)) , 1); % u(i) müsste eigentlich u(ti + h/2)
 k3 = system_pt1( ti + h , x(i) - h*k1 + 2*h*k2 , uStep(ti+h) , 1); % u(i) müsste eigentlich u(ti + h)
 % Wichtiger Hinweis: Die Parameter bei den Aufrufen von system_pt1(...)
 % m�ssen unter Beachtung von jeweiligen Zeitpunkten bestimmt werden!
 % Berechnung des Zustands-Sch�tzwertes x(ti+h)
 x(i+1) = x(i) + h*k2; %>>> erg�nzen ....
 % Berechnung der LDF Fehlerabsch�tzung d(ti+h) (nach Script MODSIM02 Gl. 2.26)
 k1_exakt = system_pt1( ti , ys(i) , u(i) , 1); %die Parameter einsetzen
 k2_exakt = system_pt1( ti + (h/2) , ys(i) + (h/2)*k1 , uStep(ti+(h/2)) , 1); % u(i) müsste eigentlich u(ti + h/2)
 k3_exakt = system_pt1( ti + h , ys(i) - h*k1 + 2*h*k2 , uStep(ti+h) , 1); % u(i) müsste eigentlich u(ti + h)
 d(i+1) = x(i+1) - x(i) - (h/6)*(k1_exakt + 4*k2_exakt + k3_exakt);

 t(i) = ti; % Zeitwert f�r Plot speichern
 ti = ti + h; % Zeitvariable um einen Schritt erh�hen
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
tit=sprintf('LDF gesch�tzt: max. Betrag = %g',max(abs(d)));
subplot(2,1,2); plot(t,d,'.-'); title(tit);zoom on;grid on;
xlabel('Zeit, s');