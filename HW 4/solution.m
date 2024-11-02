% keep these lines to load Fmat and permvec
% DO NOT submit the mat files to Gradescope
%% FROM HOMEWORK 3
[A, B, C] = abc();
% A*psi = omega
A(1,1) = 2; % given in question 
nu = 0.001; 
n = 64; 
x = linspace(-10,10,n+1); 
y = linspace(-10,10,n+1); 
tspan = [0:0.5:4];
[X, Y] = meshgrid(x(1:n), y(1:n));
omega0 = exp(-X.^2 - (Y.^2/20));

%% direct method : A\omega
[t1, omega1] = ode45(@(t, omega) rhs1(t, omega, A, B, C, nu), tspan, omega0);
A1 = omega1; 

%% LU decomposition : [L,U,P] = lu(A); y = L\(P*omega); psi = U\y; 
[L,U,P] = lu(A);
[t2, omega2] = ode45(@(t, omega) rhs2(t, omega, A, B, C, nu, L, U, P), tspan, omega0);
A2 = omega2; 

%% biconjugate 
[t3, omega3] = ode45(@(t, omega) rhs3(t, omega, A, B, C, nu), tspan, omega0);
A3 = omega3; 

%% generalized minimum residual method 
[t4, omega4] = ode45(@(t, omega) rhs4(t, omega, A, B, C, nu), tspan, omega0);
A4 = omega4;

%% FFT 
[t5, omega5] = ode45(@(t, omega) rhs5(t, omega, A, B, C, nu), tspan, omega0);
A5 = omega5; 


% % movies 
% figure 
% Z = peaks; 
% surf(Z)
% axis tight manual
% ax = gca; 
% ax.NextPlot = 'replaceChildren';
% 
% loops = 40;
% F(loops) = struct('cdata', [], 'colormap', []); 
% for j = 1:loops
%     X = sin(j*pi/10)*Z; 
%     surf(X, Z)
%     drawnow
%     F(j) = getframe; 
% end 
% 
% movie(F)

% your extra functions, if you need them, can be in other files (don't forget to upload them too!)