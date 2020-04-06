% SUBSYSTEM DESCRIPTION: system_3.m

function  [xdot,y] = system_3(x,u,t)

% state equation (derivative)
xdot(1) = -2*x(1) + u(1);

% output equation    
y(1)= 4*x(1);