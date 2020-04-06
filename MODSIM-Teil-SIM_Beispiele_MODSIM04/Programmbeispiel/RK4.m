% STANDARD RUNGE KUTTA 4 ORDER: RK4.m

function [x_RK4,y] = RK4(model_name,x,u,t,h)

% derivatives @ t, t+h/2, t+h
[k1, y]   = feval(model_name, x,        t     );
[k2, dum] = feval(model_name, x+h/2*k1, t+h/2 );
[k3, dum] = feval(model_name, x+h/2*k2, t+h/2 );
[k4, dum] = feval(model_name, x+h*k3,   t+h   );

% RK4 integration step
x_RK4 = x + h/6*(k1+2*k2+2*k3+k4);