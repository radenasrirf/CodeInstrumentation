function y = gcd(number) <b style='color:red'>Node 1</b>
a = number(1);
b = number(2);
if (a == 0), <b style='color:red'>Node 2</b>
	y = b; <b style='color:red'>Node 3</b>
else
	while b ~= 0 <b style='color:red'>Node 4</b>
		if a > b <b style='color:red'>Node 5</b>
			a = a - b; <b style='color:red'>Node 6</b>
		else
			b = b - a; <b style='color:red'>Node 7</b>
		end <b style='color:red'>Node 8</b>
	end
	y = a;
	end
end <b style='color:red'>Node 9</b>
