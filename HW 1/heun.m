function [y, E] = heun(b, c, tinit, tmax, deltat, yinit)

% number of time steps 
dt = deltat;
Nt = (tmax - tinit) / dt;

% exact function 
y_true = @(t) (pi * exp(3.0 * (cos(t) - 1.0)))/ sqrt(2.0);

% initial condition 
y(1) = yinit;
t(1) = tinit; 

% trues 
tgrid = 0:dt:5;
y_trues = y_true(tgrid);

% time loop 
for j=1:Nt
    y(j+1) = y(j) + (dt/2)*((b*y(j) * c*sin(t(j))) + (-3*(y(j) + dt*(-3*y(j)*sin(t(j))))*sin(t(j)+dt))); %#ok<*AGROW> 
    t(j+1) = tinit + j*dt;
end

E = mean(abs(y_trues - y));

