function ans = rhs_ex1(x,y,e,K)
ans = [y(2); (K*x^2 - e)*y(1)];
end