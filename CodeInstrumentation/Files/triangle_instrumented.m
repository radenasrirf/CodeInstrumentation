function [type] = triangle(sideLengths)
A = sideLengths(1); % First side
B = sideLengths(2); % Second side
C = sideLengths(3); % Third side
traversedPath = [];
% instrument Branch # 1
traversedPath = [traversedPath 1];
if ((A+B > C) && (B+C > A) && (C+A > B)) % 	Branch # 1
	% instrument Branch # 2
	traversedPath = [traversedPath 2];
	if ((A ~= B) && (B ~= C) && (C ~= A)) % Branch # 2
		type = 'Scalene';
	else 
		% instrument Branch # 3
		traversedPath = [traversedPath 3];
		if (((A == B) && (B ~= C)) || ((B == C) && (C ~= A)) || ((C == A) && (A ~= B))) % Branch # 3
			type = 'Isosceles';
		else
			type = 'Equilateral';
		end
	end
else
	type = 'Not a triangle';
end
