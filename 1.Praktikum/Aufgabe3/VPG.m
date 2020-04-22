% STANDARD VPG 2 ORDER WITH RK3 LDF ESTIMATOR: VPG.m

function [x_VPG,y,d_RK3] = VPG(model_name,x,u,t,h)

% derivatives
[k1, y]   = feval(model_name, x,        t     );
[k2, dum] = feval(model_name, x+(h/2)*k1, t+h/2 );
[k3, dum] = feval(model_name, x-h*k1+2*h*k2, t+h );

% estimation of next LDF d_(i+1) by RK3
d_RK3 = (h/6)*(k1-2*k2+k3);
 
% VPG integration step
x_VPG = x + h*k2;