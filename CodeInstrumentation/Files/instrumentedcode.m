function [traversedPath,type] = triangle(sideLengths) 
traversedPath = [];
traversedPath = [traversedPath '1 ' ];
	A = sideLengths(1); % First side
	B = sideLengths(2); % Second side
	C = sideLengths(3); % Third side
	% instrument Branch # 1
	traversedPath = [traversedPath '2 ' ];
	if ((A+B > C) && (B+C > A) && (C+A > B)) 
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 2
		traversedPath = [traversedPath '3 ' ];
		if ((A ~= B) && (B ~= C) && (C ~= A)) 
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '4 ' ];
			type = 'Scalene'; 
		else
	traversedPath = [traversedPath '(F) ' ];
	% instrument Branch # 3
	traversedPath = [traversedPath '5 ' ];
	if (((A == B) && (B ~= C)) || ((B == C) && (C ~= A)) || ((C == A) && (A ~= B))) 
				traversedPath = [traversedPath '(T) ' ];
				traversedPath = [traversedPath '6 ' ];
				type = 'Isosceles'; 
			else
				traversedPath = [traversedPath '(F) ' ];
				traversedPath = [traversedPath '7 ' ];
				type = 'Equilateral'; 
			end
		end
	else
		traversedPath = [traversedPath '(F) ' ];
		traversedPath = [traversedPath '9 ' ];
		type = 'Not a triangle'; 
	end
traversedPath = [traversedPath '8 ' ];
end 
