%% MODSIM 07 Kontinuierliches quasiweiﬂes Rauschen im begrenzten Frequenzbereich  - Beispiel
% TU-Dresden. S. Dyblenko, 13.05.2017

clear all

%% Vorgaben
Sn     = 2.5e-8;           % dim_x^2/Hz
wgn    = 125;              % rad/s  

% Parametrierung 
fgn    = 2*pi/wgn;         % rad/s  
Ta     = (1/100)*fgn;      % s
sigzg2 = Sn/Ta;            % dim_x^2 


%% Anzeige
w=linspace(0.01,1000,1000);
% Leistungsspektrum des kontinuierlichen quasiweiﬂen Rauschens
sntilde = sigzg2 * Ta * (sin(Ta*w/2)./(Ta*w/2)).^2; % dim_x^2/Hz
% Plot
figure(1);
plot(w,sntilde,'-b','LineWidth',3);
set(gca,'YLim', [0 max(sntilde)*1.05]);
grid on;
xlabel('\omega'); ylabel('S_n(tilde)(\omega)');
set(gca,'FontSize',12);

