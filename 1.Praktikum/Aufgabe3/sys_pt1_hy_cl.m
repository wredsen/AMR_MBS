% TOPOLOGY DESCRIPTION: sys_pt1_hy_cl.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gruppe 10:
% Nils Leimbach
% Konstantin Kuhl
% Sebastian Schwabe
% Konstantin Wrede
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  input:  	x    ... system state vector @ t
%  	     	t    ... current time 
%  output: 	xdot ... system state vector derivative @ t 
%          	y    ... subsystem outputs @ t     

function [xdot,y] = sys_pt1_hy_cl(x,t)

global u_step;
global memo;

% u_ext = u_ext(t) modeled as internal part of the system
ts = 2;
epsilon_float = 1e-12;
if t < ts - epsilon_float
  u_ext = 0;
else
  u_ext = u_step;
end

% PT1-Glied ---> START Block
% REM: xdot ="dumx" is obsolete, input u3 not yet known! 
[dum,y(3)] = system_pt1(x(3),memo,t);

% Addierer
u1(1) = u_ext;
u1(2) = y(3);
[dum,y(1)] = system_sub(x(1),u1,t);   % no states!

% Hysterese
u2(1) = y(1);
[dum,y(2)] = system_hys(x(2),u2,t, memo);   % no states!
memo = y(2);
% system_3    REM: Now xdot is correct because the input is known!
u3(1) = y(2);
[xdot,y(3)] = system_pt1(x(3),u3,t);

end
