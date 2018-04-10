function [traversedPath,y] = remainder(input)
traversedPath = [];
traversedPath = [traversedPath '1 ' ];
a = input(1);
d = input(2);
% instrument Branch # 1
traversedPath = [traversedPath '2 ' ];
if d == 0 % divisor can not be zero
	traversedPath = [traversedPath '(T) ' ];
	traversedPath = [traversedPath '3 ' ];
	y = NaN;
else
	traversedPath = [traversedPath '(F) ' ];
	% instrument Branch # 2
	traversedPath = [traversedPath '4 ' ];
	if a < d
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '5 ' ];
		y = a;
	else
		traversedPath = [traversedPath '(F) ' ];
		% instrument Branch # 3
		traversedPath = [traversedPath '6 ' ];
		while a >= d
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '7 ' ];
			a = a - d;
		traversedPath = [traversedPath '6 ' ];
		end
		y = a;
	end
end
traversedPath = [traversedPath '(F) ' ];
traversedPath = [traversedPath '8 ' ];
end
