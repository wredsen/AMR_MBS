clear all;

%% common model parameters
l   = 1;    % m
g   = 9.81; % kg/m^2

%% initial values for the variant 2
% arbitrary 
phi0   = 45 *pi/180; % rad
omega0 = 0; % rad/s

%% common simulation parameters
tstop = 5;

%% parameter and simulation of variant 1 - RK4
open('pendel_polar.mdl');
sim('pendel_polar.mdl');
