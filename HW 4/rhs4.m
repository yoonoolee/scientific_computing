function dwdt = rhs4(t, omega, A, B, C, nu)

psi = gmres(A, omega, 10, 1e-8, 100);

dwdt = (-B*psi) .* (C*omega) + (C*psi) .* (B*omega) + (nu*A*omega);
end 