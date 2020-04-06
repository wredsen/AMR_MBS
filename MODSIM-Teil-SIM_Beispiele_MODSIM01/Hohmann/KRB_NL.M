function zdot = krb_nl(t,z)
%
% Satellitenbahnmodell nichtlinear, ebene Kreisbahn
%
% T. Range 9.10.95
%
% Globale Variablen:
%
%	ur   - (String) Funktionsname der externen Funktion zur
%	       Berechnung von ur(t) [km/s^2]
%	uphi - (String) Funktionsname der externen Funktion zur
%	       Berechnung von uphi(t) [km/s^2]
%
% z(1)... r [km]
% z(2)... dr/dt [km/s]
% z(3)... phi [rad]
% z(4)... d(phi)/dt [rad/s]
%
global ur uphi

Mue = 3.986018E5;  		% [km^3/s^2]
%
zdot(1) = z(2);
zdot(2) = z(1)*z(4)^2 - Mue/z(1)^2 + feval(ur,t);
zdot(3) = z(4);
zdot(4) = -2*z(2)*z(4)/z(1) + feval(uphi,t)/z(1);
