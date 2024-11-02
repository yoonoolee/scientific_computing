function dwdt = rhs3(t, omega, A, B, C, nu)

psi = bicgstab(A, omega, 1e-8); 

dwdt = (-B*psi) .* (C*omega) + (C*psi) .* (B*omega) + (nu*A*omega);
end 