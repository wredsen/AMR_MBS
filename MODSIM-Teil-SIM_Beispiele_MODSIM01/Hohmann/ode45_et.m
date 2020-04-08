function [tout, yout] = ode45_et(FunFcn, t0, tfinal, y0, tol, trace)
%% TR01:
%% Version von ODE45 mit externer Beeinflussung der Schrittweite durch
%% globale Variablen:
%%	event_list		Vektor von Zeitpunkten, die garantiert
%%				erreicht werden müssen
%%	max_step_width		maximale,
%%	min_step_width		minimale,
%%	initial_step_width	initiale (Start-) Schrittweite
%%
%%	T. Range 9.10.95
%%
%ODE45	Integrate a system of ordinary differential equations using
%	4th and 5th order Runge-Kutta formulas.  See also ODE23 and
%	ODEDEMO.M.
%	[T,Y] = ODE45('yprime', T0, Tfinal, Y0) integrates the system
%	of ordinary differential equations described by the M-file
%	YPRIME.M over the interval T0 to Tfinal and using initial
%	conditions Y0.
%	[T, Y] = ODE45(F, T0, Tfinal, Y0, TOL, 1) uses tolerance TOL
%	and displays status while the integration proceeds.
%
% INPUT:
% F     - String containing name of user-supplied problem description.
%         Call: yprime = fun(t,y) where F = 'fun'.
%         t      - Time (scalar).
%         y      - Solution column-vector.
%         yprime - Returned derivative column-vector; yprime(i) = dy(i)/dt.
% t0    - Initial value of t.
% tfinal- Final value of t.
% y0    - Initial value column-vector.
% tol   - The desired accuracy. (Default: tol = 1.e-6).
% trace - If nonzero, each step is printed. (Default: trace = 0).
%
% OUTPUT:
% T  - Returned integration time points (row-vector).
% Y  - Returned solution, one solution column-vector per tout-value.
%
% The result can be displayed by: plot(tout, yout).

%   C.B. Moler, 3-25-87.
%   Copyright (c) 1987 by the MathWorks, Inc.
%   All rights reserved.

global  event_list max_step_width min_step_width initial_step_width %% TR01

% The Fehlberg coefficients:
% alpha = [1/4  3/8  12/13  1  1/2]';		%% TR01
alpha = [1/4  3/8  12/13  0.99999  1/2]';	%% TR01
beta  = [ [    1      0      0     0      0    0]/4
          [    3      9      0     0      0    0]/32
          [ 1932  -7200   7296     0      0    0]/2197
          [ 8341 -32832  29440  -845      0    0]/4104
          [-6080  41040 -28352  9295  -5643    0]/20520 ]';
gamma = [ [902880  0  3953664  3855735  -1371249  277020]/7618050
          [ -2090  0    22528    21970    -15048  -27360]/752400 ]';
pow = 1/5;
if nargin < 6, trace = 0; end
if nargin < 5, tol = 1.e-6; end

% Initialization
t = t0;
if ~isempty(max_step_width)		%% TR01
  hmax = max_step_width;		%% TR01
else					%% TR01
  hmax = (tfinal - t)/5;
end					%% TR01
if ~isempty(min_step_width)		%% TR01
  hmin = min_step_width;		%% TR01
else					%% TR01
  hmin = (tfinal - t)/20000;
end					%% TR01
if ~isempty(initial_step_width)		%% TR01
  h = initial_step_width;		%% TR01
else					%% TR01
  h = (tfinal - t)/100;
end					%% TR01
hlast = h;				%% TR01
y = y0(:);
f = y*zeros(1,6);
tout = t;
yout = y.';
tau = tol * max(norm(y, 'inf'), 1);

if trace
   clc, t, h, y
end

% The main loop
%    while (t < tfinal) & (h >= hmin)				%% TR01
   while (t < tfinal)						%% TR01
      if t + h > tfinal, h = tfinal - t; end
      if exist('event_list')==1					%% TR01
         if ~ isempty(event_list)				%% TR01
            if t + h >= event_list(1)				%% TR01
               hlast = h;					%% TR01
               h = event_list(1) - t;				%% TR01
               next_ev = 2;					%% TR01
               for i=length(event_list):-1:2			%% TR01
                  if event_list(i) > event_list(1)		%% TR01
                     next_ev = i;				%% TR01
                  end						%% TR01
               end						%% TR01
               event_list = event_list(next_ev:length(event_list)); %% TR01
            end							%% TR01
         end							%% TR01
      end							%% TR01
      % Compute the slopes
      temp = feval(FunFcn,t,y);
      f(:,1) = temp(:);
      for j = 1:5
         temp = feval(FunFcn, t+alpha(j)*h, y+h*f*beta(:,j));
         f(:,j+1) = temp(:);
      end

      % Estimate the error and the acceptable error
      delta = norm(h*f*gamma(:,2),'inf');
      tau = tol*max(norm(y,'inf'),1.0);

      % Update the solution only if the error is acceptable
      if delta <= tau
         t = t + h;
         y = y + h*f*gamma(:,1);
         tout = [tout; t];
         yout = [yout; y.'];
      end
      if trace
         home, t, h, y
      end

      % Update the step size
      if delta ~= 0.0
         h = min(hmax, 0.8*h*(tau/delta)^pow);
         if h < hmin, break; end				%% TR01
         hlast = h;						%% TR01
      else							%% TR01
         h = hlast;						%% TR01
      end
   end;

   if (t < tfinal)
      disp('SINGULARITY LIKELY.')
      t
   end
