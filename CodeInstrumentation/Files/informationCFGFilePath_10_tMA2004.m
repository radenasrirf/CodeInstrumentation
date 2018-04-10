function  type = triangleMansour2004(sideLengths) <b style='color:red'>Node 1</b>
	A = sideLengths(1); % First side
	B = sideLengths(2); % Second side
	C = sideLengths(3); % Third side
	type = 'Scalene';
	if (A == B) <b style='color:red'>Node 2</b>
		if (B == C) <b style='color:red'>Node 3</b>
			type = 'Equilateral'; <b style='color:red'>Node 4</b>
		else
			type = 'Isosceles'; <b style='color:red'>Node 5</b>
		end <b style='color:red'>Node 6</b>
	else
		if (B == C) <b style='color:red'>Node 7</b>
			type = 'Isosceles'; <b style='color:red'>Node 8</b>
		end
	end
	if (A^2 == (B^2 + C^2)) <b style='color:red'>Node 9</b>
		type = 'Right'; <b style='color:red'>Node 10</b>
	end
end <b style='color:red'>Node 11</b>
