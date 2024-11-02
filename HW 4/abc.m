function [A, B, C] = abc()

m = 64; 
n = m*m;
L = 10;
delta = (L - (-L))/ m;

% Ad
Ad = -4  * eye(n); % -4 * identity vector 
Ad = full(Ad);

% Ax
e1 = ones(n, 1); % vector of ones 
B = spdiags([e1 -e1 e1 -e1], [-m*(m-1), -m, m, m*(m-1)], n, n);
B = full(B); 

% Ay
C = spdiags([-e1 e1], [-1 1], n, n);
for i=1:m
    C(m*i, m*(i-1)+1) = 1; 
    C(m*(i-1)+1, m*i) = -1; 
end 
for i=1:m-1
    C(m*i+1, m*i) = 0;
    C(m*i, m*i+1) = 0; 
end 
C = full(C);

% final answers 
A = (Ad + abs(B) + abs(C)) / (delta).^2; 
B = B / (2*delta);
C = C / (2*delta);