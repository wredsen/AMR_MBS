% SUBSYSTEM DESCRIPTION: system_1.m

function  [xdot,y] = system_1(x,u,t)

k = 29/24;
% state equation (derivative)
xdot(1) = 0;  % no states  ---> dummy output

% output equation    
y(1)= k*(u(1)-u(2));