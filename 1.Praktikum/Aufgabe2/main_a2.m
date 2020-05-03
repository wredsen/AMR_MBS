% MODSIM Laborpraktikum, 2. Aufgabe
% Prof. K. Janschek, Dr.-Ing. Th. Range, Dr.-Ing. S. Dyblenko
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gruppe 10:
% Konstantin Kuhl
% Nils Leimbach
% Sebastian Schwabe
% Konstantin Wrede
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main_a2.m - Realisierung der VPG-Methode mit Fehlerschaetzung
% und Schrittweitensteuerung
% für PT1-Glied

clear all % Loesche Arbeitsspeicher
tic
global epsilon_float; % Konstante fuer sicheren Float-Vergleich an Sprungstelle
epsilon_float = 1e-12;                                                                      
global Tm;  % Konstante des PT1, [s]
Tm = 10; 
h = 0.1; % Initialisierung Schrittweite, (s)
t0 = 0; % Integrationsbeginn, [s]
tf = 300; % Integrationsende, [s]
t = []; % Zeitwerte fuer Plot [s]
h_array = []; % Schrittweiten fuer Plot
d = []; % Fehler-Schuetzwerte
u = []; % Stellwerte u(t)
global deltaU; % Sprunghoehe am Eingang
deltaU = 5;
y = []; % Ausgangswerte y(t)
ys = []; % Analytische Ausgangswerte y_s(t)
% Initialisierung
[dum,x(1)] = system_pt1([],[],[],0);
d(1) = 0;
% Integration nach VPG-Methode
ti = t0;
i = 1;

while ti <= tf
    
 % Berechnung des Soll-Ausgangswertes: 
 % y(t) = 5*UnitStep(t-1) - 10*y'(t), AB: y(0) = x(0) = 0
 if ti < 1.0 - epsilon_float
    ys(i) = 0;
 else
    ys(i) = 5*(1-exp((1-ti)/Tm)); 
 end

 % Berechnung des Stellwertes fuer den Plot
 u(i) = uStep(ti); 
 
 % Berechnung von neuer Schrittweite, Zustand, LDF
 [h, x, d(i+1)] = stepWidthControl(h, i, ti, x);
 
 % Berechnung des Ausgangswertes
 y(i) = system_pt1( ti , x(i) , uStep(ti) , 3); %die Parameter einsetzen
 
 t(i) = ti; % Zeitwert fuer Plot speichern
 h_array(i) = h;
 
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
figure(3);
plot(t,h_array,'.-'); title('h-Weite');zoom on;grid on;
xlabel('Zeit, s');
ylabel('h, s');

% Berechnung des stetigen Stellwerts u(t) für den Funktionsaufruf mit halber Schrittweite
function outU = uStep(t)
    global deltaU;
    global epsilon_float;
    
    if t < 1.0 - epsilon_float
        outU = 0;
    else 
        outU = deltaU;
    end
end 

function [h, x, LDF] = stepWidthControl(h, i, ti, x)

repeat = 1;

while repeat == 1
    
    % Berechnung der Koeffizienten fuer VPG-Methode
    k1 = system_pt1( ti , x(i) , uStep(ti) , 1); 
    k2 = system_pt1( ti + (h/2) , x(i) + (h/2)*k1 , uStep(ti+(h/2)) , 1);
    k3 = system_pt1( ti + h , x(i) - h*k1 + 2*h*k2 , uStep(ti+h) , 1);
    % Wichtiger Hinweis: Die Parameter bei den Aufrufen von system_pt1(...)
    % muessen unter Beachtung von jeweiligen Zeitpunkten bestimmt werden!
    
    % Berechnung der LDF Fehlerabschaetzung d(ti+h) (nach Hinweis in MBS VL 3, es handelt sich um d^ (Dach))
    LDF = (h/6)*(k1-2*k2+k3);
    
    global deltaU;
    global Tm;
    epsilon = 5e-6;     % maximal toleriertes LDF

    h_min = epsilon*6/(deltaU/Tm);                                                                                
    h_max = 2*Tm;                                                                                                 
    
    % Schrittweitenalgorithmus nach MODSIM SIM03
    if LDF ~= 0  
        h_new = h*(epsilon/abs(LDF))^(1/3); %Gleichung 3.8 Script MODSIM SIM03, p = p1 = 2
        if h_new < h_min
            h_new = h_min;
        elseif h_new >= h_max
            h_new = 0.99*h_max;             %streng kleiner h_max s. VL
        end

        if h_new > 2*h          %continue integration with new stepsize  
            h = h_new;   
            repeat = 0;
        elseif h_new <= h       %repeat last integration step with new stepsize        
            h = 0.75*h_new;
        else                    %continue integration without change of stepsize
            h = h;             
            repeat = 0;
        end
    else                        %falls LDF d=0
        repeat = 0;
    end
    
    % Berechnung des Zustands-Schaetzwertes x(ti+h)
    x(i+1) = x(i) + h*k2; 
    
end
end