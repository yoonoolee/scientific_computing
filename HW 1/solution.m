% Homework MATLAB template file
% Your main file should be named "solution.m" and it should be saved as UTF-8 file.

% your solution code goes here
% assign the variables you are asked to save here 

%%%%%%%%%% QUESTION 1 %%%%%%%%%%

% 1a
delta_ts = [2^(-2), 2^(-3), 2^(-4), 2^(-5), 2^(-6), 2^(-7), 2^(-8)];
% coefficients of equation y' = b*y * c*sin(t), y(0) = pi / sqrt(2)
b = -3; 
c = 1; 
% initial and final times 
tinit = 0.0;
tmax = 5.0; 
% initial condition 
yinit = pi / sqrt(2);
% exact function 

Es = [];

for deltat = delta_ts
    [y, E] = forwardeuler(b, c, tinit, tmax, deltat, yinit);
    Es(length(Es)+1) = E; %#ok<SAGROW> 
end 

    coefficients = polyfit(log(delta_ts), log(Es), 1);
    slope = coefficients(1);

    A1 = reshape(y, [1281, 1]);
    A2 = Es; % WRONG ANSWER
    A3 = slope;

% 1b
Es = [];

for deltat = delta_ts
    [y, E] = heun(b, c, tinit, tmax, deltat, yinit);
    Es(length(Es)+1) = E; %#ok<SAGROW> 
end 

    coefficients = polyfit(log(delta_ts), log(Es), 1);
    slope = coefficients(1);

    A4 = reshape(y, [1281, 1]);
    A5 = Es; % WRONG 
    A6 = slope; % WRONG


%%%%%%%%%% QUESTION 2 %%%%%%%%%%
% 2a
tspan = [0 : 0.5 : 32]; %#ok<NBRAK> 
y0 = [sqrt(3), 1];
epsilons = [0.1, 1, 20];
results = zeros(length(tspan), length(epsilons));

for i = 1:length(epsilons)
    [t, result] = ode45(@(t,y) vanderpoloscillator(t, y, epsilons(i)), tspan, y0);
    results(:, i) = result(:, 1);
end 

    A7 = results; 

% 2b
tspan2 = [0,32];
epsilon4 = 1; 
y0_2 = [2, pi^2];
tols = [10^(-4), 10^(-5), 10^(-6), 10^(-7), 10^(-8), 10^(-9), 10^(-10)];

% ode45
avgstepsizes = [];
for tol = tols
    options = odeset('AbsTol', tol, 'RelTol', tol);
    [t, result] = ode45(@(t,y) vanderpoloscillator(t, y, epsilon4), tspan2, y0_2, options);
    avgstepsize = mean(diff(t));
    avgstepsizes(length(avgstepsizes)+1) = avgstepsize; %#ok<SAGROW> 
end 
coefficients = polyfit(log(avgstepsizes), log(tols), 1); % line of fit degree of 1
slope = coefficients(1);
A8 = slope;

% ode23
avgstepsizes = [];
for tol = tols
    options = odeset('AbsTol', tol, 'RelTol', tol);
    [t, result] = ode23(@(t,y) vanderpoloscillator(t, y, epsilon4), tspan2, y0_2, options);
    avgstepsize = mean(diff(t));
    avgstepsizes(length(avgstepsizes)+1) = avgstepsize; %#ok<SAGROW> 
end 
coefficients = polyfit(log(avgstepsizes), log(tols), 1); % line of fit degree of 1
slope = coefficients(1);
A9 = slope;

% ode113
avgstepsizes = [];
for tol = tols
    options = odeset('AbsTol', tol, 'RelTol', tol);
    [t, result] = ode113(@(t,y) vanderpoloscillator(t, y, epsilon4), tspan2, y0_2, options);
    avgstepsize = mean(diff(t));
    avgstepsizes(length(avgstepsizes)+1) = avgstepsize; %#ok<SAGROW> 
end 
coefficients = polyfit(log(avgstepsizes), log(tols), 1); % line of fit degree of 1
slope = coefficients(1);
A10 = slope;

%%%%%%%%%% QUESTION 3 %%%%%%%%%%

% 3
a1 = 0.05; 
a2 = 0.25;
b = 0.01;
c = 0.01;
I = 0.1; 
vinit = [0.1, 0.1]; % v1(0) = v2(0) = 0.1
winit = [0.0, 0.0]; % w1(0) = w2(0) = 0.0
tspan3 = [0 : 0.5 : 100]; %#ok<NBRAK> 

% (0, 0)
d = [0,0];
[t, result] = ode15s(@(t,y) fitzhughneurons(t, y, a1, a2, b, c, I, d(1), d(2)), tspan3, [vinit, winit]); 
A11 = result;

% (0, 0.2)
d = [0,0.2];
[t, result] = ode15s(@(t,y) fitzhughneurons(t, y, a1, a2, b, c, I, d(1), d(2)), tspan3, [vinit, winit]); 
A12 = result;

% (-0.1, 0.2)
d = [-0.1,0.2];
[t, result] = ode15s(@(t,y) fitzhughneurons(t, y, a1, a2, b, c, I, d(1), d(2)), tspan3, [vinit, winit]); 
A13 = result;


% (-0.3, 0.2)
d = [-0.3,0.2];
[t, result] = ode15s(@(t,y) fitzhughneurons(t, y, a1, a2, b, c, I, d(1), d(2)), tspan3, [vinit, winit]); %#ok<*ASGLU> 
A14 = result;


% (-0.5, 0.2)
d = [-0.5,0.2];
[t, result] = ode15s(@(t,y) fitzhughneurons(t, y, a1, a2, b, c, I, d(1), d(2)), tspan3, [vinit, winit]); 
A15 = result;


% your extra functions, if you need them, can be in another files (don't forget to upload them too!)