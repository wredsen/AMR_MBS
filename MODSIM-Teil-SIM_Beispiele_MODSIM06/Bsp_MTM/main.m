%  Beispiel Simulation mittels Transitionsmatrix 
%  S. Dyblenko, TU Dresden, 2017

clear all; format short g

% Systemparameter
T            = 10;               % Zeitkonstante

% Signalparameter
% Sprungeingang implementiert in siehe u_inp.m

% Simulationsparameter
t_end        = 100;              % Simulationszeit

h_ana        = 1;                % Schrittweiten
s_ana        = t_end./h_ana+1;   % Schrittanzahlen

h_rk4        = 20;               % Schrittweiten
s_rk4        = t_end./h_rk4+1;   % Schrittanzahlen

% Anfangswerte
t_ana = 0;
x_ana = 0;
t_rk4 = 0;
x_rk4 = 0;
x_tma = 0;

% Darstellungsparameter
fontsize     = 28;               % Schriftgröße
markersize   = 20;               % Markergröße
linewidth    = 4;                % Linienbreite

% Simulationsrechnung
%---------------------
for i = 1:s_ana-1                                            
    t_ana(i+1)   = h_ana*i;
    x_ana(i+1)   = 1 - exp(-t_ana(i+1)/T);                        % exakter Verlauf
end % for i

for i = 1:s_rk4-1                                            
    t_rk4(i+1)   = h_rk4*i;                                       %**********************
    k1 = f_func(x_rk4(i), u_inp(t_rk4(i)),T);                      % Intergration nach RK4
    k2 = f_func(x_rk4(i)+(h_rk4/2)*k1, u_inp(t_rk4(i)+h_rk4/2),T);
    k3 = f_func(x_rk4(i)+(h_rk4/2)*k2, u_inp(t_rk4(i)+h_rk4/2),T);
    k4 = f_func(x_rk4(i)+h_rk4*k3,     u_inp(t_rk4(i)+h_rk4),T);
    x_rk4(i+1)   = x_rk4(i) + (h_rk4/6)*(k1+2*k2+2*k3+k4);
end % for i

FI = exp(-0.1*h_rk4);
H  = 1-exp(-0.1*h_rk4);
for i = 1:s_rk4-1
    x_tma(i+1)   = FI*x_tma(i)+H*u_inp(t_rk4(i));                  % TM-Methode
end % for i



% Ergebnisauswertung und -präsentation
%--------------------------------------

figure(1);
h = plot(t_ana(1:s_ana),x_ana(1:s_ana), t_rk4(1:s_rk4),x_rk4(1:s_rk4),'or', t_rk4(1:s_rk4),x_tma(1:s_rk4), '*k' );
grid on;zoom on;
set(h,'LineWidth',linewidth,'MarkerSize',markersize);
title('x-Verlauf','FontSize',fontsize);
xlabel('t','FontSize',fontsize);
ylabel('x','FontSize',fontsize);
set(gca,'FontSize',fontsize);
h=legend('Analytische Loesung','RK4 (h=20)','Transitionsmatrix',4);
set(h,'FontSize',fontsize);
%pause

