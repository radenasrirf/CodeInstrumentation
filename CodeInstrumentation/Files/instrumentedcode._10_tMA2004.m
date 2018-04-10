function [traversedPath, type] = triangleMansour2004(sideLengths)
traversedPath = [];
traversedPath = [traversedPath '1 ' ];
	A = sideLengths(1); % First side
	B = sideLengths(2); % Second side
	C = sideLengths(3); % Third side
	type = 'Scalene';
	% instrument Branch # 1
	traversedPath = [traversedPath '2 ' ];
	if (A == B)
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 2
		traversedPath = [traversedPath '3 ' ];
		if (B == C)
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '4 ' ];
			type = 'Equilateral';
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '5 ' ];
			type = 'Isosceles';
		traversedPath = [traversedPath '6 ' ];
		end
	else
		traversedPath = [traversedPath '(F) ' ];
		% instrument Branch # 3
		traversedPath = [traversedPath '7 ' ];
		if (B == C)
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '8 ' ];
			type = 'Isosceles';
		end
	end
	% instrument Branch # 4
	traversedPath = [traversedPath '9 ' ];
	if (A^2 == (B^2 + C^2))
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '10 ' ];
		type = 'Right';
	end
traversedPath = [traversedPath '11 ' ];
end
