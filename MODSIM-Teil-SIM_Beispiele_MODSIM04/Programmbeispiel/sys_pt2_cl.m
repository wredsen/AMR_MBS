% TOPOLOGY DESCRIPTION: sys_pt2_cl.m

%  input:  	x    ... system state vector @ t
%  	     	t    ... current time 
%  output: 	xdot ... system state vector derivative @ t 
%          	y    ... subsystem outputs @ t

function [xdot,y] = sys_pt2_cl(x,t)

% u_ext = u_ext(t) modeled as internal part of the system
ts = 2;
if t < ts
  u_ext = 0;
elseif t >= ts 
  u_ext = 1;
else
  u_ext = 0;
end % if t < 2

% system_3 ---> START Block
% REM: xdot ="dumx" is obsolete, input u3 not yet known! 
[dumx,y3] = system_3(x(2),0,t);

% system_1   
u1(1) = u_ext;
u1(2) = y3;
[dumx,y(1)] = system_1(0,u1,t);   % no states!

% system_2
u2(1) = y(1);
[xdot(1),y(2)] = system_2(x(1),u2,t);

% system_3    REM: Now xdot is correct because the input is known!
u3(1) = y(2);
[xdot(2),y(3)] = system_3(x(2),u3,t);