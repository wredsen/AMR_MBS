% SUBSYSTEM DESCRIPTION: system_1.m
% Subtraction Block

function  [xdot,y] = system_sub(x,u,t)

k = 1;
% state equation (derivative)
xdot(1) = 0;  % no states  ---> dummy output

% output equation    
y(1)= k*(u(1)-u(2));