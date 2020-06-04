% Jacobi Matrix wie in Beleg: JacobiMatrix.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gruppe 10:
% Konstantin Kuhl
% Nils Leimbach
% Sebastian Schwabe
% Konstantin Wrede
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [J, J_inv] = JacobiMatrix()
global h;
global C1;
global C2;
global R;

J = [   1,  0,  -h/(2*C1),  0,  0,  0;
        0,  1,  0, -h/(2*C2),   0,  0;
        0,  0,  0,  0,  -1, R;
        1,  0,  0,  0,  1,  0;
        1,  -1, 0,  0,  0,  0;
        0,  0,  1,  1,  0,  -1   ];

    
J_inv = inv(J);

end