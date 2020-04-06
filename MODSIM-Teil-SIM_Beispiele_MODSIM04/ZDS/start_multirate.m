clear all

[t,x,y] = sim('multirate');

figure(1);clf; hold on;
stairs(t, y(:,1), '-b', 'LineWidth', 3); plot(t, y(:,1), '.b', 'MarkerSize', 35);
stairs(t, y(:,2), '-m', 'LineWidth', 3); plot(t, y(:,2), 'om', 'MarkerSize', 15);
grid on;
set(gca, 'FontSize', 24);
