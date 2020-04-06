%	TU-Dresden, Institut für Automatisierungstechnik
%	9.12.1997-T.Boge / 4.10.2002-K.Janschek

%	=== MODELL der Lagedynamik ============================================= 

%   sys = d_omega / d_t = J^(-1) * ( M - omega x  J * omega )
%
%	Inputs:	x      Vektor (3,1)  Zustandsvektor [w;q]
%           M      Vektor (3,1)  Moment
%           J      Matrix (3,3)  Trägheitsmatrix
%           T      Skalar        Schrittweite
%
%	Outputs: x_dot  Vektor (3,1)  Ableitung des Zustandsvektors [d_w;d_q]

function [x_dot] = sysmodel (x,M,J)

% Zustandsvektor [w=Omega,q=Lagequaternion] 
w=x([1:3]);
q=x([4:7]);

% Lagedynamik: w_dot = d_omega/d_t = J^(-1) * (M - omega x J*omega )
Jinv=inv(J);
Jw=J*w ;
wJw=cross(w,Jw);
w_dot=Jinv*(M-wJw);

% Lagekinematik:  q_dot = d_q/d_t = 1/2 * OMEGA * q
% generate "OMEGA-Matrix"
wm= [   0,  w(3), -w(2),  w(1);
    -w(3),     0,  w(1),  w(2);
     w(2), -w(1),     0,  w(3);
    -w(1), -w(2), -w(3),     0];
q_dot=1/2*wm*q;

% Schreiben der Ausgänge
x_dot=[w_dot;q_dot];
