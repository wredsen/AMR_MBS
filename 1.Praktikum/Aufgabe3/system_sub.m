% SUBSYSTEM DESCRIPTION: system_sub.m
% Addier-Block
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gruppe 10:
% Nils Leimbach
% Konstantin Kuhl
% Sebastian Schwabe
% Konstantin Wrede
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function  [xdot,y] = system_sub(x,u,t)

% state equation (derivative)
xdot(1) = 0;  % no states  ---> dummy output

% output equation    
y(1)= u(1)-u(2);