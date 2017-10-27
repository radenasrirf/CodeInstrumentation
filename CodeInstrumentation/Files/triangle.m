function [type] = triangle(sideLengths)
A = sideLengths(1); % First side
B = sideLengths(2); % Second side
C = sideLengths(3); % Third side
if ((A+B > C) && (B+C > A) && (C+A > B)) % 	Branch # 1
	if ((A ~= B) && (B ~= C) && (C ~= A)) % Branch # 2
		type = 'Scalene';
	else 
		if (((A == B) && (B ~= C)) || ((B == C) && (C ~= A)) || ((C == A) && (A ~= B))) % Branch # 3
			type = 'Isosceles';
		else
			type = 'Equilateral';
		end
	end
else
	type = 'Not a triangle';
end