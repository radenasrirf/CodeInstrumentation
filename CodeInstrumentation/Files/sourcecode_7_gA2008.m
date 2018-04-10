function y = gcd(number)
a = number(1);
b = number(2);
if (a == 0),
	y = b;
else
	while b ~= 0
		if a > b
			a = a - b;
		else
			b = b - a;
		end
	end
	y = a;
	end
end