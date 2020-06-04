% Trapez-Integration function: TRA.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gruppe 10:
% Konstantin Kuhl
% Nils Leimbach
% Sebastian Schwabe
% Konstantin Wrede
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [z_n_next, x_n_next] = TRA(u_n, x_n, z_n, t, J_inv)

%%%% Newton-Raphson-Verfahren %%%%
epsilon = 1e-5; % Toleranzschranke
max_iterations = 10; % maximale Iterationen pro Schritt
p_n = [x_n, z_n]';

i = 0;
while(1)
    i = i + 1;
    phi_n = phi(x_n', z_n', u_n, p_n, t);
    p_n_next = p_n - J_inv * phi_n;
    
    delta_inf_norm = norm(J_inv * phi_n);                          %%%% ggf. noch norm(..., inf)
    if (delta_inf_norm < epsilon)        
        break;
    end
    
    if i > max_iterations
        fprintf("Maximale Iterationsanzahl ueberschritten");
        break;
    end
    
    p_n = p_n_next;
    
end

x_n_next = p_n_next(1:2);
z_n_next = p_n_next(3:6);

end

%%%%%%% Subfunktionen fuer TRA %%%%%%%

function phi_i_next = phi(x_i, z_i, u, p, t)
global h;

x_i_next = p(1:2);
z_i_next = p(3:6); 

phi_i_next(1:2, 1) = x_i_next - x_i - (h / 2) * (f_differential(x_i, z_i, t) + f_differential(x_i_next, z_i_next, t));
phi_i_next(3:6, 1) = g_algebraic(x_i_next, z_i_next, u, t);

end

function x_dot = f_differential(x, z, t)
global C1;
global C2;

x_dot = [z(1)/C1, z(2)/C2]';

end

function g = g_algebraic(x,z,u,t)        
global R;

g = [   R * z(4) - z(3),
        x(1) + z(3) - u,
        x(1) - x(2),                           
        z(1) + z(2) - z(4)  ]';

end


