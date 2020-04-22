% MODSIM Laborpraktikum, 1. Aufgabe
% Prof. K. Janschek, Dr.-Ing. Th. Range, Dr.-Ing. S. Dyblenko
%y(t) = c_1 e^(-t/10) - 5 e^((1 - t)/10) θ(t - 1) + 5 θ(t - 
% main_a1.m - Realisierung der VPG-Methode mit Fehlerschaetzung
% für PT1-Glied
% zu ergänzende Codezeilen sind mit ">>> ergänzen ...." und ...gekennzeichnet

clear all % Loesche Arbeitsspeicher
Tm = 10; % Konstante des PT1, [s]
h = 0.1; % Schrittweite, (s)
t0 = 0; % Integrationsbeginn, [s]
tf = 300; % Integrationsende, [s]
t = []; % Zeitwerte fuer Plot [s]
h_array = [];
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
    
 % Berechnung des Soll-Ausgangswertes: into WolframAlpha: 
 % y(t) = 5*UnitStep(t-1) - 10*y'(t), AB: y(0) = x(0) = 0
 if ti < 1
    ys(i) = 0;
 else
    ys(i) = 5*(1-exp((1-ti)/Tm)); 
 end

  % Berechnung des Stellwertes fuer den Plot
 u(i) = uStep(ti);
 
 % Berechnung des Ausgangswertes
 y(i) = system_pt1( ti , x(i) , uStep(ti) , 3); %die Parameter einsetzen
 % Berechnung der Koeffizienten fuer VPG-Methode(aus VL, Übungslösung Sim02)
 k1 = system_pt1( ti , x(i) , uStep(ti) , 1); %die Parameter einsetzen
 k2 = system_pt1( ti + (h/2) , x(i) + (h/2)*k1 , uStep(ti+(h/2)) , 1);
 k3 = system_pt1( ti + h , x(i) - h*k1 + 2*h*k2 , uStep(ti+h) , 1);
 % Wichtiger Hinweis: Die Parameter bei den Aufrufen von system_pt1(...)
 % muessen unter Beachtung von jeweiligen Zeitpunkten bestimmt werden!
 
 % Berechnung des Zustands-Schaetzwertes x(ti+h)
 x(i+1) = x(i) + h*k2; 
 % Berechnung der LDF Fehlerabschaetzung d(ti+h) (nach Hinweis in MBS VL 3, es handelt sich um d^ (Dach))
 d(i+1) = (h/6)*(k1-2*k2+k3); 
 
 h = stepWideControl(Tm, h, d(i+1));
 
 t(i) = ti; % Zeitwert fuer Plot speichern
 h_array(i) = h;
 ti = ti + h; % Zeitvariable um einen Schritt erhoehen
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
figure(3);
plot(t,h_array,'.-'); title('h-Weite');zoom on;grid on;

% Berechnung des stetigen Stellwerts u(t) für den Funktionsaufruf mit halber Schrittweite
function outU = uStep(t)
    if t < 1
        outU = 0;
    else 
        outU = 5;
    end
end 

function h = stepWideControl(Tm, h_alt, d)
epsilon = 5e-6;
if d == 0
    h_neu = h_alt;
else  
    h_neu = h_alt*(epsilon/abs(d))^(1/3);    % Gleichung 3.8 Script MODSIM SIM03, p = p1 = 2
end
    
h_min = 0.001;
h_max = 1;

if h_neu > 2*h_alt
    if h_neu < h_max
        h = h_neu;    %continue integration with new stepsize
    else
        h = h_max;
    end
    
elseif (h_neu <= h_alt)
    if h_neu > h_min    
        h = 0,75*h_neu;  %repeat last integration step with new stepsize
    else
        h = h_min;
    end
    
else
    h = h_alt; %continue integration without change of stepsize
end
end