clear all;

%% common model parameters
m1   = 0.1; % kg
m2   = 0.2; % kg
Fmax = 100; % N
f    = 10;  % Hz

%% initial values for the variant 1
% arbitrary 
x3_0 = 0; % m, position of m2
x4_0 = 0; % m, velocity of m2
% dependent
x1_0 = x3_0;
x2_0 = x4_0;

%% initial values for the variant 2
% arbitrary 
y2_0  = 0; % m, position of m2
y2p_0 = 0; % m, velocity of m2
% dependent
y1_0  = y2_0;
y1p_0 = y2p_0;

%% common simulation parameters
tstop = 0.3;

%% parameter and simulation of variant 1 - RK4
h_v1  = 0.0001;
sim('TwoMasssystemRigid_v1.mdl');
t_v1 = ScopeData_v1_y1.time; y1_v1 = ScopeData_v1_y1.signals.values;


%% parameter and simulation of variant 2 - RK4
% für MATLAB with symbolic tool box:
% m=sym('[L, -1, 0, 0; k/m1, L, -k/m1, 0; 0, 0, L, -1; -k/m2, 0, k/m2, L]'); % (L*I-J) matrix
% solve(det(m),'L')

k = 1e+2;
h_v2 = 2.8/abs((-k*m1*m2*(m1 + m2))^(1/2)/(m1*m2))  * 0.05;
sim('TwoMasssystemRigid_v2.mdl');
t_v2_1 = ScopeData_v2_y1.time'; y1_v2_1 = ScopeData_v2_y1.signals.values';

k = 1e+3;
h_v2 = 2.8/abs((-k*m1*m2*(m1 + m2))^(1/2)/(m1*m2))  * 0.05;
sim('TwoMasssystemRigid_v2.mdl');
t_v2_2 = ScopeData_v2_y1.time'; y1_v2_2 = ScopeData_v2_y1.signals.values';

k = 1e+4;
h_v2 = 2.8/abs((-k*m1*m2*(m1 + m2))^(1/2)/(m1*m2))  * 0.05;
sim('TwoMasssystemRigid_v2.mdl');
t_v2_3 = ScopeData_v2_y1.time'; y1_v2_3 = ScopeData_v2_y1.signals.values';

%% plot results
figure(100); clf;
plot(t_v1, y1_v1, 'k','LineWidth',4);
hold on;
plot(t_v2_1, y1_v2_1, 'r','LineWidth',2);
plot(t_v2_2, y1_v2_2, 'b','LineWidth',2);
plot(t_v2_3, y1_v2_3, 'g','LineWidth',2);
hold off;
grid on;
set(gca,'fontsize',14,'XLim',[0 tstop]);
xlabel('time, s'); ylabel('y_1, m');
legend('rigid','k=10^2 N/m','k=10^3 N/m','k=10^4 N/m',0);
