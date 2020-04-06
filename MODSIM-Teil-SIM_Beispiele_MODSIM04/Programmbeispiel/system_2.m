% SUBSYSTEM DESCRIPTION: system_2.m

function  [xdot,y] = system_2(x,u,t)

% state equation (derivative)
xdot(1) = -5*x(1) + u(1);

% output equation    
y(1) = 3*x(1);