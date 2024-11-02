clear all; close all; % clear all variables and figures 

% keep these lines to load Fmat and permvec
% DO NOT submit the mat files to Gradescope

load Fmat.mat 
load permvec.mat
    
% your solution code goes here
    
% assign the variables you are asked to save here  
%%% QUESTION 1 %%%
m = 8; 
n = m*m;
L = 10;
delta = (L - (-L))/ m;

% Ad
Ad = -4  * eye(n); % -4 * identity vector 
Ad = full(Ad);

% Ax
e1 = ones(n, 1); % vector of ones 
B = spdiags([e1 -e1 e1 -e1], [-56, -8, 8, 56], n, n);
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

A1 = A;
A2 = B / (2*delta);
A3 = C / (2*delta);


%%% QUESTION 2 %%%
% 1. break interior of Fmat into 16 20x20 blocks 
% hint: the interior can be accessed as Fmat(161:240, 161:240)
% hint: you may want to use a cell array OR a 3D array, with each slice
% a 20x20 matrix. This turns the permutation step into a simple indexing
% problem. 
fullimage = Fmat; 
image = Fmat(161:240, 161:240); % 80x80
perm = permvec; 
image_array = {};
for col=1:4
    for row=1:4
        subimage = image(20*(row-1)+1:20*row, 20*(col-1)+1:20*col);
        image_array(end+1) = {subimage}; %#ok<*SAGROW> 
    end 
end 

% 2. rearrange the blocks according to the permutation 
% block 7 in original -> block 1 in new 
% block 11 in original -> block 2 in new 
% ... 
image_perm_array = {};
for i=perm
    image_perm_array(end+1) = image_array(i); 
end 

image_perm_array = reshape(image_perm_array, 4, 4);
image = cell2mat(image_perm_array); 

% 3. take the absolute value of the resulting matrix; A4
fullimage(161:240, 161:240) = image; 
A4 = abs(fullimage);

% 4. use ifftshift to shift the permutated matrix, NOT of the absolute
% value matrix in A4
fullimage = ifftshift(fullimage);

% 5. use ifft2 to inverse fourier transform 
fullimage = ifft2(fullimage);
A5 = abs(fullimage); 

% 6. check your work by using the command:
% set(gcf,'colormap',gray); imagesc(A5);

% your extra functions, if you need them, can be in other files (don't forget to upload them too!)