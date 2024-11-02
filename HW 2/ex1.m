function [eigFun, eigVal] = ex1()
% dy/dx = z
% dz/dx = f(y, x)
K = 1; 
L = 4; 
xspan = -L : 0.1 : L; 
eps_start = 0; 
deps_start = 1; 
tol = 1e-4; 
eigFun = [];
eigVal = [];
A = 1;

% need for loop - outer: modes, inner: epsilon shooting
for modes = 1:5
    eps = eps_start; 
    deps = deps_start;
    % initial conditions
    for j = 1:1000
        % ode45 with -L boundary condition - shoot for +L
        func = sqrt(K * (L^2) - eps);
        y0 = [A; func * A];
        [x, y] = ode45(@(x, y) rhs_ex1(x, y, eps, K), xspan, y0);
        
        if (abs(y(end, 2) + func * y(end, 1)) < tol)
            break; 
        end 
        % adjust epsilon 
        % specify if condition based upon the modes being even or odd
        if ((-1)^(modes+1) * (y(end, 2) + func * y(end, 1))) > 0
            eps = eps + deps; 
        else
            eps = eps - deps/2;
            deps = deps/2; 
        end 
    end 
    eps_start = eps+0.1; 
    normPhi = y(:, 1) ./ sqrt(trapz(xspan, y(:,1) .^ 2));
    eigFun = [eigFun, normPhi];
    eigVal = [eigVal, eps];
end 