% LV Elemente der Modellbildung und Simulationstechnik
% Beispiel zu MODSIM03 
% Simulation der Sprungantwort eines instabilen System mit RK4 
% S. Dyblenko, TU Dresden, SS2017

clear all;

% numerische Lösung 
h = 0.01;  % Schrittweite
sim('beispiel_inst_system');
tn=ScopeData.time;
sn=ScopeData.signals(1).values;

% analytische Lösung 
[sa,ta]=step(tf([1],[1 -0.001 +4.00000025]),0:h:1000);

% presentation
figure(1);
plot(ta,sa);
grid on;
title('Analytische Lösung','FontSize',14);
set(gca,'FontSize',18)

figure(2);
plot(tn,sn);
grid on;
title('Numerische Lösung','FontSize',14);
set(gca,'FontSize',18)
set(gca,'YLim',[-0.2 0.8]);

figure(3);
plot(ta,sa-sn);
grid on;
set(gca,'FontSize',18)
title('GDF','FontSize',14);

% figure(4);
% plot(ta,(sa-sn)./sa*100);
% grid on;
% set(gca,'FontSize',18)
% title('GDF in %','FontSize',14);

