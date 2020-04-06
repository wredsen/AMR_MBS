% LV Elemente der Modellbildung und Simulationstechnik
% Beispiel zu MODSIM03 
% Beispiel für numerische Stabilität bei EULER-Verfahren
% S. Dyblenko, TU Dresden, SS2017

clear all;

% Systemparameter
lambda        = -1;

% Simulationsparameter
h     = 0.1;      % Schrittweite
tf    = 10;       % Simulationszeit

% Anfangswerte
t     = 0;
x_eul = 1;

% Darstellungsparameter
fontsize   = 16;  % Schriftgröße
markersize = 28;  % Markergröße
linewidth  = 3;   % Linienbreite

% Simulationsrechnung
%---------------------
for i = 1:tf/h                                        % entspricht von i = 0 in LV
    t(i+1)    = h*i;                                  
    x_eul(i+1)= x_eul(i) + h*(lambda * x_eul(i));     % Intergration nach EULER
end % for i

% analytischer exakter Verlauf - in feiner Auflösung
%---------------------
t_ana = linspace(0,tf,100); x_ana = x_eul(1) * exp(lambda*t_ana);

% Ergebnispräsentation
%--------------------------------------

figure(1);
plot(t_ana, x_ana, '-b', 'LineWidth',linewidth,'MarkerSize',markersize);
hold on;
plot(t, x_eul, '.-r', 'LineWidth',1,'MarkerSize',markersize);
hold off;
grid on;zoom on;
xlabel('t','FontSize',fontsize+4);
set(gca,'FontSize',fontsize);
text(6.1,0.7,['h\lambda = ' sprintf('%.2f',h*lambda)],'FontSize',fontsize+12);

