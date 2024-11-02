function f = vanderpoloscillator(t, y, epsilon)

f1 = y(2);
f2 = -y(1) - epsilon*(y(1)^2 - 1)*y(2);

f = [f1; f2]; % return this 