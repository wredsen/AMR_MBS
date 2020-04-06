clear all;

%% common model parameters
l   = 1;    % m
g   = 9.81; % kg/m^2

%% initial values for the variant 1
% arbitrary 
x0   = 1; % m
vy0  = 0; % m/s

% dependent
y0   = -sqrt(l^2-x0^2); % m
vx0  = -y0*vy0/x0; % m/s
lamda_t0 = (vx0^2 + vy0^2 -g*y0)/(l^2); %N

%% simulation parameters
tstop = 5;

%% parameter and simulation of variant 1 - RK4
sim('pendel_kartesisch.mdl');
t_v1  = ScopeData_v1_y.time; y_v1  = ScopeData_v1_y.signals.values; x_v1 = ScopeData_v1_x.signals.values;

%% plot results of the variant 1
figure(100); clf;
subplot(2,1,1);
  plot(t_v1, x_v1, 'b','LineWidth',2);
  set(gca,'fontsize',14,'XLim',[0 tstop]);
  grid on;
  xlabel('time, s'); ylabel('x, m');
  title('Pendelmodell in Kartesischen Koordinaten');
subplot(2,1,2);
  plot(t_v1, y_v1, 'b','LineWidth',2);
  set(gca,'fontsize',14,'XLim',[0 tstop]);
  grid on;
  xlabel('time, s'); ylabel('y, m');

figure(200); clf;
plot(x_v1, y_v1, 'k','LineWidth',2);
set(gca,'fontsize',14,'XLim',[-1 1],'YLim',[-1 1]);
grid on;
xlabel('x, m'); ylabel('y, m');
title('XY plot');
axis square;
