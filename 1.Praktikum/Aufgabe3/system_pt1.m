% SUBSYSTEM DESCRIPTION: system_pt1.m
% PT1-Block
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gruppe 10:
% Konstantin Kuhl
% Nils Leimbach
% Sebastian Schwabe
% Konstantin Wrede
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function  [xdot,y] = system_pt1(x,u,t)

global Tm;

% state equation (derivative)
xdot = (1/Tm)*(-x + u);

% output equation    
y(1)= x(1);