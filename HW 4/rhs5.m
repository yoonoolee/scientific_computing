function dwdt = rhs5(t, omega, A, B, C, nu)

% FFT : FT(psi) = -FT(omega) / (kx^2 + ky^2); 
%       to use FFT, rescale kx and ky to a 2pi domain as follows:
%       L = 20, kx = ky = (2*pi/L) * [0:(n/2-1)    (-n/2):-1]
%       reshape to a 2D array, use fft2, ifft2 and reshape back to the 
%       original psi to use in the equation for omega_t.
%       lastly, to avoid dividing by 0, you should set kx(1) = ky(1) =
%       1e-6
n = 64; 
L = 20; 
kx = (2*pi/L) * [0:(n/2-1) (-n/2):-1];
ky = (2*pi/L) * [0:(n/2-1) (-n/2):-1];
kx(1) = 1e-6;
ky(1) = 1e-6;
[Kx, Ky] = meshgrid(kx, ky);
psi = ifft2(-fft2(reshape(omega, [n,n]))./(Kx.^2 + Ky.^2));
psi = reshape(psi, [n^2, 1]);

dwdt = (-B*psi) .* (C*omega) + (C*psi) .* (B*omega) + (nu*A*omega);
end 