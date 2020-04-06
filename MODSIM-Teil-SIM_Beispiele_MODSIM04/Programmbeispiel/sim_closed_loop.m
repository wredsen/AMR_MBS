% MAIN SIMULATION PROGRAM: sim_closed_loop.m

% system parameter
model_name = 'sys_pt2_cl';
u = 0;                  % input modeled in the topology file!

%simulation parameter
t  = 0;                 % simulation start time
tf = 5;                 % simulation stop time
h  = 2e-1;              % constant stepsize
ts = 2;                 % step time

% initial values
x = [0 0];              % x ... system state vector

% simulation
i=1;
while t <= tf+h         %   loop t = t0...tf
    [x,y] = RK4(model_name,x,u,t,h);
    x_values(i,:) = x;
    y_values(i,:) = y;
    t_values(i)   = t;
    y_exact(i)    = 29/49*(1-exp(-3.5*(t-ts))*...
                       (cos(3.5*(t-ts))+sin(3.5*(t-ts))))*(t>ts);
    t = t + h;
    i = i+1;
end % while

% result visualisation
plot(t_values,y_values(:,3),t_values,y_exact,...
     t_values,y_values(:,3)-y_exact')
grid on; zoom on