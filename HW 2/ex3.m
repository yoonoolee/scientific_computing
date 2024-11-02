function [eFun, eVal] = ex3(g, A)
% dy/dx = z
% dz/dx = f(y, x)
K = 1; 
L = 2; 
xspan = -L : 0.1 : L; 
e_initial = 0; 
d_initial = 1; 
tol = 1e-4; 
eFun = [];
eVal = [];

% need for loop - outer: modes, inner: epsilon shooting
for i = 1:2
    e = e_initial;
    d = d_initial;

    for k = 1:1000
        y0 = [A; sqrt(K*(L^2)-e)*A];
        [x,y] = ode45(@(x,y) rhs_ex3(x, y, e, K, g), xspan, y0);

        norm = trapz(x,y(:,1).^2);

        if abs(norm-1) < tol 
            break;
        else
            A = A/sqrt(norm);
        end

        if (abs(y(end,2) + sqrt(K*(L^2)-e) * y(end,1)) < tol)
            break;
        end

        if ((-1)^(i+1) * (y(end,2) + (g*abs(y(end,1))^2 + sqrt(K*(L^2)-e))*y(end,1))) > 0
            e = e + d;
        else
            e = e - d/2;
            d = d/2;
        end
    end

    e_initial = e + 0.1;
    nP = y(:,1)./sqrt(trapz(x, y(:,1).^2));
    eFun = [eFun, nP];
    eVal = [eVal; e];
end 