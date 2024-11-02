function [y, E] = forwardeuler(b, c, tinit, tmax, deltat, yinit)
% y' = b*y * c*sin(t)
% y(0) = pi / sqrt(2)

% number of time steps 
dt = deltat;
Nt = (tmax - tinit) / dt;

y_true = @(t) (pi * exp(3.0 * (cos(t) - 1.0)))/ sqrt(2.0);

% initial condition 
y(1) = yinit;
t(1) = tinit; 

% trues 
tgrid = 0:dt:5;
y_trues = y_true(tgrid);

% time loop 
for j=1:Nt
    y(j+1) = y(j) + dt*(b*y(j) * c*sin(t(j))); %#ok<AGROW> 
    t(j+1) = tinit + j*dt; %#ok<AGROW> 
end

E = mean(abs(y_trues - y));
