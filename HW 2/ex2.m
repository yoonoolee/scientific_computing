function [normPhi, eps_sorted] = ex2()
    K = 1;  
    L = 4; 
    dx = 0.1; 
    c = K * (dx^2);
    xspan = -L : dx : L; 
    m = length(xspan);
    % define matrix A 
    A = zeros(m-2,m-2);
    
    for i = 1:m-2
        if i == 1
            A(i,  1:2) = [(2/3) + c * xspan(i+1)^2, -2/3];
        elseif i == m-2
            A(m-2, m-3:m-2) = [-2/3, (2/3) + c * xspan(i+1)^2];
        else
            A(i, [i-1,i,i+1]) = [-1, 2 + c * xspan(i+1)^2, -1];
    end 

    % eig(A) 
    [V, D] = eig(A);
    eps = diag(D) ./ (dx^2);
    % eigenfunction values at -L, L

    [eps_sorted, idx] = sort(eps, "ascend");
    V_sorted = V(:, idx);
    V_new = zeros(81, 79);
    V_new(2: end-1, :) = V_sorted; 

    for i = 1:5
        V_new(1, i) = (4*V_new(2,i) - V_new(3,i)) / (3 + 2*dx*sqrt(K*L^2 - eps_sorted(i)));
        V_new(81,i) = (4*V_new(80,i) - V_new(79,i)) / (3 + 2*dx*sqrt(K*L^2 - eps_sorted(i)));
    end

    normPhi = zeros(size(V_new, 1), 5);

    for i = 1:5
        normPhi(:, i) = V_new(:, i) ./ sqrt(trapz(xspan, V_new(:, i).^2));
    end 
end 