clear all

[t,x,y] = sim('kont');

figure(1);clf; hold on;
plot(t, y(:,1), '.-r', 'LineWidth', 3, 'MarkerSize', 35);
grid on;
set(gca, 'FontSize', 24);
