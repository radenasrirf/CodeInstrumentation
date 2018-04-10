function [traversedPath,y] = gcd(number)
traversedPath = [];
traversedPath = [traversedPath '1 ' ];
a = number(1);
b = number(2);
% instrument Branch # 1
traversedPath = [traversedPath '2 ' ];
if (a == 0),
	traversedPath = [traversedPath '(T) ' ];
	traversedPath = [traversedPath '3 ' ];
	y = b;
else
	traversedPath = [traversedPath '(F) ' ];
	% instrument Branch # 2
	traversedPath = [traversedPath '4 ' ];
	while b ~= 0
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 3
		traversedPath = [traversedPath '5 ' ];
		if a > b
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '6 ' ];
			a = a - b;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '7 ' ];
			b = b - a;
		end
		traversedPath = [traversedPath '8 ' ];
	traversedPath = [traversedPath '4 ' ];
	end
	y = a;
	end
traversedPath = [traversedPath '(F) ' ];
traversedPath = [traversedPath '9 ' ];
end
