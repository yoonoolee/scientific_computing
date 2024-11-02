clear all; close all; clc 
%% part 1: spectral solve 
% generic setup: define your x, y, beta, D1, D2, m, tspan, etc. 
n = 64; 
x = linspace(-10,10,n+1); 
y = linspace(-10,10,n+1); 
[X,Y] = meshgrid(x(1:n),y(1:n));
beta = 1; 
D1 = 0.1; 
D2 = 0.1; 
m = 1; % number of spirals 
tspan = 0:0.5:4; 

% spectral setup: define kx, ky, use meshgrid to get a 2D KX, KY
% define 2D operator matrix, KX.^2 + KY.^2
% then reshape to a vector, n^2 x 1 (!)
L = 20; 
kx = (2*pi/L) * [0:(n/2-1) (-n/2):-1];
ky = (2*pi/L) * [0:(n/2-1) (-n/2):-1];
kx(1) = 1e-6;
ky(1) = 1e-6; 
[KX,KY] = meshgrid(kx,ky);
lap_vec = KX.^2 + KY.^2; 
lap_vec = reshape(lap_vec, [n^2,1]);

% spectral initial condition setup: define your xvec, yvec; use meshgrid 
% to get 2D matrices X and Y; setup your TIME-DOMAIN U and V
% 1i means imaginary unit 
U_t = tanh(sqrt(X.^2+Y.^2)).*cos(m*angle(X+1i*Y)-(sqrt(X.^2+Y.^2))); 
V_t = tanh(sqrt(X.^2+Y.^2)).*sin(m*angle(X+1i*Y)-(sqrt(X.^2+Y.^2))); 

% then take these to the FOURIER SPACE (FREQUENCY-DOMAIN):
% 2D transform 
U_f = fft2(U_t);
V_f = fft2(V_t);

% reshape U_f, V_f to vectors, then stack on top of each other to get a 
% 8192x1 vector (4096x1 each, then stacked vertically) 
U_f = U_f(:);
V_f = V_f(:);
UV_stacked = [U_f;V_f];

% to repeat: you will need a VECTOR of u,v that is in the FREQUENCY_DOMAIN
% into your RHS function. then you will operate and produce a VECTOR of 
% du/dt, dv/dt that is output also in the FREQUENCY DOMAIN

% spectral solve: be sure to keep track of what is fourier and what is 
% time domain! do not mix them in the same expression 

% RHS function: 
[t,y] = ode45(@(t,y) spectral_rhs_hw5(t,y,lap_vec,beta,D1,D2,n), tspan, UV_stacked);

% then timestep as usual. you will get a big output vector, 9x8192.
% output the real and imaginary parts separately, as so:
A1 = real(y); 
A2 = imag(y);

%% part 2: chebyshev polynomial solve 
% tchebyshev = chebyshev

% general setup: note:
beta = 1; 
D1 = 0.1; 
D2 = 0.1; 
m = 1; % number of spirals 
tspan = 0:0.5:4; 
L = 20;
n = 30+1; 
[Dcheb, z] = cheb(n-1);
Dcheb_sqr = Dcheb^2;
Dcheb_sqr(1,:) = zeros(1,n);
Dcheb_sqr(n,:) = zeros(1,n);

% dont forget to scale x according to z, which goes from 1 to -1
x = L*z/2; 
y = x;
[X,Y] = meshgrid(x,y);
U_t = tanh(sqrt(X.^2+Y.^2)).*cos(m*angle(X+1i*Y)-(sqrt(X.^2+Y.^2))); 
V_t = tanh(sqrt(X.^2+Y.^2)).*sin(m*angle(X+1i*Y)-(sqrt(X.^2+Y.^2))); 
U_t = reshape(U_t,[n^2,1]);
V_t = reshape(V_t,[n^2,1]);
UV_stacked = [U_t;V_t];

% set up laplacian matrix:
I = eye(length(Dcheb_sqr));
lap_mat = (4/L^2)*kron(Dcheb_sqr, I) + (4/L^2)*kron(I, Dcheb_sqr);

% then time step as usual
% your RHS function for cheby solve is much simpler than the spectral
% method
[t,y] = ode45(@(t,y) cheb_rhs_hw5(t,y,lap_mat,beta,D1,D2,n), tspan, UV_stacked);

A3 = y;

