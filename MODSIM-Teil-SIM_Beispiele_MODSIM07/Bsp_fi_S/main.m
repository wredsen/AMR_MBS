% MODIM 07 Autokorrelationsfunktion , Leistungsdichtespektrum - Beispiel
% TU-Dresden. S. Dyblenko, 13.05.2017

clear all

% einmal sim_model.mdl simulieren
open('sim_model.mdl');
sim('sim_model.mdl');

LEN=20000;

if 1
t = x1.time(1:LEN,1)';
a1 = x1.signals.values(1:LEN,1)';
a2 = x2.signals.values(1:LEN,1)';
a3 = x3.signals.values(1:LEN,1)';

% TMAX=4000;
% tcf = t(1:TMAX+1);
% cf1 = check_white(a1,TMAX); cf1 = [fliplr(cf1(2:end)) cf1];
% cf2 = check_white(a2,TMAX); cf2 = [fliplr(cf2(2:end)) cf2];
% cf3 = check_white(a3,TMAX); cf3 = [fliplr(cf3(2:end)) cf3];
% tcff= [-fliplr(tcf(2:end)) tcf];

figure(1);
subplot(3,3,1); plot(t,a1,'LineWidth',1);set(gca,'YLim',[-3 3]);
title('Signale, \mu=0, \sigma^2=1');
subplot(3,3,4); plot(t,a2,'LineWidth',1);set(gca,'YLim',[-3 3]);
subplot(3,3,7); plot(t,a3,'LineWidth',1);set(gca,'YLim',[-3 3]);
xlabel('t,s');


tcff = linspace(-0.5,0.5,1000);
subplot(3,3,2); %plot(tcff,cf1,'LineWidth',3);set(gca,'YLim',[-0.25 1.5]);
hold on; w0 = 2*0.01; tc = 0.01; cf1t = w0/(2*tc) * exp(-abs(tcff)/tc); plot(tcff, cf1t,'-m','LineWidth',2); hold off
title('r_x_x(\tau)');
subplot(3,3,5); %plot(tcff,cf2,'LineWidth',3);set(gca,'YLim',[-0.25 1.5]);
hold on; w0 = 2*0.05; tc = 0.05; cf1t = w0/(2*tc) * exp(-abs(tcff)/tc); plot(tcff, cf1t,'-m','LineWidth',2); hold off
subplot(3,3,8); %plot(tcff,cf3,'LineWidth',3);set(gca,'YLim',[-0.25 1.5]);
hold on; w0 = 2*0.2; tc = 0.2; cf1t = w0/(2*tc) * exp(-abs(tcff)/tc); plot(tcff, cf1t,'-m','LineWidth',2); hold off
xlabel('\tau,s');


w= 0:200;
wHz = w;%/2/pi;
[MAG,PHASE] = bode([1],[0.01 1], w);
subplot(3,3,3);semilogx(wHz,MAG*0.02,'LineWidth',2);set(gca,'XLim',[wHz(1) wHz(end)],'YLim',[0 0.02]);
grid on;
title('S_x(\omega)');

[MAG,PHASE] = bode([1],[0.05 1], w);
subplot(3,3,6);semilogx(wHz,MAG*0.1,'LineWidth',2);set(gca,'XLim',[wHz(1) wHz(end)],'YLim',[0 0.1]);
grid on;

[MAG,PHASE] = bode([1],[0.2 1], w);
subplot(3,3,9);semilogx(wHz,MAG*0.4,'LineWidth',2);set(gca,'XLim',[wHz(1) wHz(end)],'YLim',[0 0.4]);
grid on;
xlabel('\omega,rad/s');


end

%sd1 = abs(fft(cf1));sd1=sd1(1:TMAX/2);
%w = (0:TMAX/2-1)*10;
%figure(10);%subplot(3,3,3);
%loglog(sd1,'LineWidth',3);
