function [dv_total,dv1,dv2,t2]=hohmann(r1,r2)
% Hohman Transfer       (circular orbit --> circular orbit)
%                       2 tangential burns (t0,t2)
%
% inputs:       r1 [km] ........... initial orbit radius
%               r2 [km] ........... final orbit radius
% outputs:      dv_total [km/s] ... total velocity increment
%               dv1 [km/s] ........ velocity increment 1-st burn
%               dv2 [km/s] ........ velocity increment 2-nd burn
%               t2 [s] ............ burn time 2-nd burn
%
%
%  24-Aug-95, janschek
%
mue_earth=3.986e5;  % km**3/s**2, earth gravitational constant
a_to=(r1+r2)/2; % km, semi-major axis
v1=sqrt(mue_earth/r1);  % km/s, 
v2=sqrt(mue_earth/r2);  % km/s
v1_to=sqrt(mue_earth*(2/r1-1/a_to));  % km/s
v2_to=sqrt(mue_earth*(2/r2-1/a_to));  % km/s
dv1=v1_to-v1;  % km/s
dv2=v2-v2_to;  % km/s
dv_total=dv1+dv2; % km/s 
t2=pi*sqrt(a_to^3/mue_earth); % s
