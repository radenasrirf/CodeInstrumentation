function y = remainder(input) <b style='color:red'>Node 1</b>
a = input(1);
d = input(2);
if d == 0 % divisor can not be zero <b style='color:red'>Node 2</b>
	y = NaN; <b style='color:red'>Node 3</b>
else
	if a < d <b style='color:red'>Node 4</b>
		y = a; <b style='color:red'>Node 5</b>
	else
		while a >= d <b style='color:red'>Node 6</b>
			a = a - d; <b style='color:red'>Node 7</b>
		end
		y = a;
	end
end
end <b style='color:red'>Node 8</b>
