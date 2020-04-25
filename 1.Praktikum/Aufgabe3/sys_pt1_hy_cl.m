% TOPOLOGY DESCRIPTION: sys_pt2_cl.m

%  input:  	x    ... system state vector @ t
%  	     	t    ... current time 
%  output: 	xdot ... system state vector derivative @ t 
%          	y    ... subsystem outputs @ t     

function [xdot,y] = sys_pt1_hy_cl(x,t)

global uStep;
global memo;

% u_ext = u_ext(t) modeled as internal part of the system
ts = 2;
epsilon_float = 1e-12;
if t < ts - epsilon_float
  u_ext = 0;
else
  u_ext = uStep;
end

% system_3 ---> START Block
% REM: xdot ="dumx" is obsolete, input u3 not yet known! 
[dum,y(3)] = system_pt1(x(3),memo,t);

% system_1   
u1(1) = u_ext;
u1(2) = y(3);
[dum,y(1)] = system_sub(x(1),u1,t);   % no states!

% system_2
u2(1) = y(1);
[dum,y(2)] = system_hys(x(2),u2,t, memo);   % no states!
memo = y(2);
% system_3    REM: Now xdot is correct because the input is known!
u3(1) = y(2);
[xdot,y(3)] = system_pt1(x(3),u3,t);

end
