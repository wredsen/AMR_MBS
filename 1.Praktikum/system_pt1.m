% MODSIM Laborpraktikum, 1. Aufgabe
%
% Dr.-Ing. Th. Range, Dr.-Ing. S. Dyblenko
%
% zu ergänzende Codezeilen sind mit ">>> ergänzen ...." gekennzeichnet
% Berechnung des Systems "PT1-Glied"
%
% (Hinweis: Die Struktur des Programms erlaubt eine Einbindung in
% SIMULINK als sog. S-Function; dies ist jedoch im Rahmen des
% Praktikums nicht vorgesehen!)
function [sys, x0] = system_pt1 ( t, x, u, flag )
% Eingabe-Parameter:
% t - Zeit
% x - x(t) Zustandsvektor zum Zeitpunkt t
% u - u(t) Vektor der Eingangssignale zum Zeitpnukt t
% flag - Steuerparameter, legt fest, welche Ausgabe
% gefordert wird:
Tm = 10; % Zeitkonstante des PT1-Gliedes
if flag == 0 % Ausgabe der Anfangswerte für den
 % Zustand auf Vektor x0
 x0 = %>>> ergänzen ....
 sys = [1,0,1,1,0,0];% diese Zeile ist nur für Simulink nötig,
 % sie gilt so NUR in diesem Beispiel!
elseif abs(flag) == 1 % Ausgabe der Ableitungen von x auf
 % Vektor sys = x' = f(x(t),u(t),t)
 sys = %>>> ergänzen ....
elseif flag == 3 % Ausgabe der Ausgangswerte des
 % Systems auf Vektor sys:
 % sys = y = g(x(t),u(t),t)
 sys = %>>> ergänzen ....
else % bei anderen Flagwerten nichts ausgeben
 sys = [];
end