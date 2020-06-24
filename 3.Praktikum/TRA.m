% Trapez-Integration function: TRA.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gruppe 10:
% Konstantin Kuhl
% Nils Leimbach
% Sebastian Schwabe
% Konstantin Wrede
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [z_i_next, x_i_next, iterations_newton] = TRA(u_i, x_i, z_i, J_inv)

%%%% Newton-Raphson-Verfahren %%%%
epsilon = 1e-5; % Toleranzschranke
max_iterations = 5; % maximale Iterationen pro Schritt
p_n = [x_i, z_i]';

n = 0;
while(1)
    n = n + 1;
    phi_n = phi(x_i', z_i', u_i, p_n);
    p_n_next = p_n - J_inv * phi_n;
    
    if n > max_iterations
        fprintf("Maximale Iterationsanzahl %d ueberschritten \n", max_iterations);
        break;
    end
    
    step_difference = norm(J_inv * phi_n);                
    if (step_difference < epsilon)        
        break;
    end
    
    p_n = p_n_next;
end

x_i_next = p_n_next(1:2);
z_i_next = p_n_next(3:6);
iterations_newton = n;

end

%%%%%%% Subfunktionen fuer TRA %%%%%%%

function out = phi(x_i, z_i, u, p)
global h;

x_i_next = p(1:2);
z_i_next = p(3:6); 

out(1:2, 1) = x_i_next - x_i - (h / 2) * (f_differential(x_i, z_i) + f_differential(x_i_next, z_i_next));
out(3:6, 1) = g_algebraic(x_i_next, z_i_next, u);

end

function out = f_differential(x, z)
global C1;
global C2;

out = [ z(1)/C1, z(2)/C2]';

end

function out = g_algebraic(x,z,u)        
global R;

out = [ R * z(4) - z(3),
        x(1) + z(3) - u,
        x(1) - x(2),                           
        z(1) + z(2) - z(4)  ]';

end


