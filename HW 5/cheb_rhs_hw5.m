function dudv = cheb_rhs_hw5(t,y,lap_mat,beta,D1,D2,n)
    % separate out U and V from the vector:
    U_f = y(1:n^2);
    V_f = y((n^2+1):end);

    U_t = reshape(U_f,n,n);
    V_t = reshape(V_f,n,n);

    % compute A^2, lambda, omega
    A = sqrt(U_t.^2 + V_t.^2);
    lambda = 1 - A.^2;
    omega = -beta*A.^2;

    % finally, computer dU/dt and output in the FREQUENCY DOMAIN:
    dU = reshape((lambda.*U_t - omega.*V_t),[],1) + D1*lap_mat*U_f;
    dV = reshape((omega.*U_t + lambda.*V_t),[],1) + D2*lap_mat*V_f;
    dudv = [dU;dV];
end 
