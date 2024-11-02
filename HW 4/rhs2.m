function dwdt = rhs2(t, omega, A, B, C, nu, L, U, P)

y = L\(P*omega);
psi = U\y; 

dwdt = (-B*psi) .* (C*omega) + (C*psi) .* (B*omega) + (nu*A*omega);
end 