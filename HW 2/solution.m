% Homework MATLAB template file
% Your main file should be named "solution.m" and it should be saved as UTF-8 file.

% your solution code goes here
% assign the variables you are asked to save here

%%% QUESTION 1 %%%
[eigenfunctions, eigenvalues] = ex1();

A1 = abs(eigenfunctions(:, 1));
A2 = abs(eigenfunctions(:, 2));
A3 = abs(eigenfunctions(:, 3));
A4 = abs(eigenfunctions(:, 4));
A5 = abs(eigenfunctions(:, 5));
A6 = reshape(eigenvalues, 5, 1);

%%% QUESTION 2 %%%
[normPhi, eps_sorted] = ex2();

A7 = abs(normPhi(:, 1));
A8 = abs(normPhi(:, 2));
A9 = abs(normPhi(:, 3));
A10 = abs(normPhi(:, 4));
A11 = abs(normPhi(:, 5));
A12 = eps_sorted(1:5);

%%% QUESTION 3 %%%

% gamma = 0.05
gamma = 0.05;
A = 0.1;
[eigFun, eigVal] = ex3(gamma, A);

A13 = abs(eigFun(:, 1));
A14 = abs(eigFun(:, 2));
A15 = reshape(eigVal, 2, 1);

% gamma = -0.05
gamma = -0.05;
A = 1;
[eigFun, eigVal] = ex3(gamma, A);

A16 = abs(eigFun(:, 1));
A17 = abs(eigFun(:, 2));
A18 = reshape(eigVal, 2, 1);


% your extra functions, if you need them, can be in other files (don't forget to upload them too!)