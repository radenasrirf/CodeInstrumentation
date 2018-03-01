function roots = bisection(input)
EPS_ABS = 1e-2; % constant
EPS_STEP = 1e-2; % constant
a = input(1);
b = input(2);
c = NaN;
if (f(a) * f(b)) >= 0,
	return;
end
while (b-a >= EPS_STEP || (abs(f(a)) >= EPS_ABS && abs(f(b)) >= EPS_ABS))
	c = (a + b)/2;
	if (f(c) == 0)
		roots = c;
	return;
	else
		if (f(a)*f(c) < 0)
			b = c;
		else
			a = c;
		end
	end
end
roots = c;
end
% find the root of the following function y = 3*x^2 + 10*x - 3
function y = f(x)
% y = 3*x^2 + 10*x - 3;
y = x^2 - 3; % root = 1.7344
end

