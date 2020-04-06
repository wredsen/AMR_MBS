%	TU-Dresden Institut für Automatisierungstechnik
%	9.12.1997-T.Boge / 4.10.2002-K.Janschek / 06.04.2014 S.Dyblenko

%  Simulation - ABLAUFSTEUERUNG

% Initialiserung
clear
clf
warning('off','all')
warning
para_mod
para_numint
para_ablauf

plotvorb;
q_ = q0;
w_ = w0;

% Anzeige des Startzustandes
q = q0; w = w0;
h_fig = gcf; 
figure(h_fig);
plotxyz;
pause;

% Simulationsschleife
disp('Experiment gestartet');  

k=1;
for t=h:h:tmax
   
   % Integrationsschritt  
   [q,w]=numint(q_,w_,M,J,h);
   q_ = q;
   w_ = w;

   % Speicherung der Ergebnisse
   %qm(:,k)=q;
   %wm(:,k)=w;
   %k=k+1;

   % Anzeige der Ergebnisse
   plotxyz;
   title('Lage des Körpers (Leertaste zum Stop)');

   fprintf('t= %+.1f  ', t);
   fprintf('w= %+.4f, %+.4f, %+.4f  ', w);
   fprintf('q= %+.4f, %+.4f, %+.4f, %+.4f\n', q);

   % prüfe Abbruchbedingung im Plot-Fenster
   key = get(gcf,'CurrentKey');
   if(strcmp (key , 'space'))
      disp('Experiment gestoppt');  
      title('Lage des Körpers (Experiment gestoppt)');
      figure(h_fig);
      return;
   end   
   
end

disp('Experiment beendet');  
title('Lage des Körpers (Experiment beendet)');
figure(h_fig);


