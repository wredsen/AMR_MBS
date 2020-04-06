%	TU-Dresden Institut für Automatisierungstechnik
%	9.12.1997-T.Boge / 4.10.2002-K.Janschek / 06.04.2014 S.Dyblenko

%	=== NUMERISCHE INTEGRATION ===

%   Omega:               w = f ( lagedyn[w0, Momente , Tragheitsmatrix] )
%   Lagequaternion:      q = f ( lagekin[q0,w0,Schrittweite] ) 
%
%	Inputs:	q0     Vektor (4,1)  Lagequaternion (t)
%           w0     Vektor (3,1)  omega (t)
%           M      Vektor (3,1)  Momente
%           J      Matrix (3,3)  Trägheitsmatrix
%           T      Skalar (1,1)  Schrittweite
%
%	Outputs: q      Vektor (4,1)  Lagequaternion (t+T)
%            w      Vektor (3,1)  omega (t+T)

function [q,w] = numint(q0,w0,M,J,T)

% Zustandsvektor
x0=[w0;q0];

% Runge-Kutta 3. Ordnung
x_dot1 = sysmodel ( x0, M, J );
x_dot2 = sysmodel ( x0+(T/2)*x_dot1, M, J );
x_dot3 = sysmodel ( x0-T*x_dot1+2*T*x_dot2, M, J );

x = x0 + T/6*(x_dot1+4*x_dot2+x_dot3);  

% VPG .... zum Vergleich
%  x = x0 + T*x_dot2;  

w=x([1:3]);
q=x([4:7]);
q=q/norm(q);

