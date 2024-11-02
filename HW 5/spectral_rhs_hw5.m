function dudv = spectral_rhs_hw5(t,y,lap_vec,beta,D1,D2,n)
    % separate out the FREQUENCY DOMAIN components of y:
    U_f = y(1:n^2);
    V_f = y((n^2+1):end);

    % obtain the TIME DOMAIN versions of U,V:
    U_t = real(ifft2(reshape(U_f,n,n))); 
    V_t = real(ifft2(reshape(V_f,n,n))); 

    % define lambda,omega,A which use TIME DOMAIN versions of U and V:
    A = sqrt(U_t.^2 + V_t.^2);
    lambda = 1 - A.^2;
    omega = -beta*A.^2;

    % finally, compute dU/dt and dV/dt and output in the FREQUENCY DOMAIN:
    dU_f = reshape(fft2(lambda.*U_t - omega.*V_t),[],1) - D1*lap_vec.*U_f;
    dV_f = reshape(fft2(omega.*U_t + lambda.*V_t),[],1) - D2*lap_vec.*V_f;

    dudv = [dU_f;dV_f];
end 