function  type = triangleMansour2004(sideLengths)
	A = sideLengths(1); % First side
	B = sideLengths(2); % Second side
	C = sideLengths(3); % Third side
	type = 'Scalene';
	if (A == B)
		if (B == C)
			type = 'Equilateral';
		else
			type = 'Isosceles';
		end
	else
		if (B == C)
			type = 'Isosceles';
		end
	end
	if (A^2 == (B^2 + C^2))
		type = 'Right';
	end
end