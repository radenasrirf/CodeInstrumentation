function y = remainder(input)
a = input(1);
d = input(2);
if d == 0 % divisor can not be zero
	y = NaN;
else
	if a < d
		y = a;
	else
		while a >= d
			a = a - d;
		end
		y = a;
	end
end
end