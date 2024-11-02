function ans = rhs_ex3(x,y,e,K,gamma)
ans = [y(2); (gamma* abs(y(1))^2 + K*x^2 - e)*y(1)];
end