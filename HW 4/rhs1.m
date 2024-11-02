function dwdt = rhs1(t, omega, A, B, C, nu)

psi = A\omega; 

dwdt = (-B*psi) .* (C*omega) + (C*psi) .* (B*omega) + (nu*A*omega);
end 