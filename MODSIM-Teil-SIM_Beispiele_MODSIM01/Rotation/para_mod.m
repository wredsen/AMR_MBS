%	TU-Dresden Institut f�r Automatisierungstechnik
%	9.12.1997-T.Boge / 4.10.2002-K.Janschek / 06.04.2014 S.Dyblenko

%   EXPERIMENTRAHMEN: Simulations-PARAMETER

% === System-MODELL ====================================
%  Tr�gheitsmatrix [kgm^2]  
J = [100      0      0
      0      50      0
      0       0     10 ];

%  Anfangswert Drehrate:  omega0 [1/s] 
  
  % instabil: Rotation um mittleres Tr�gheitsmoment
  %w0 =[0.00001  0.01  .00001]';

  % stabil: Rotation um gr��tes Tr�gheitsmoment 
  w0 =[0.01  0.00001  .00001]';

%  Anfangswert Lagequaternion:  q0  
   q0 =[0 0  0 1]';
%  St�rmoment [Nm] 
   M =[ 0 0 0]';
