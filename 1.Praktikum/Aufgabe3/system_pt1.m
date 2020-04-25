% SUBSYSTEM DESCRIPTION: system_3.m
% PT1 Block

function  [xdot,y] = system_pt1(x,u,t)

global Tm;

% state equation (derivative)
xdot = (1/Tm)*(-x + u);

% output equation    
y(1)= x(1);