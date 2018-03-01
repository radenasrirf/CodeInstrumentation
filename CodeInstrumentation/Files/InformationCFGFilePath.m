function type = triangle(sideLengths)  <b style='color:red'>Node 1</b>
	A = sideLengths(1); % First side
	B = sideLengths(2); % Second side
	C = sideLengths(3); % Third side
	if ((A+B > C) && (B+C > A) && (C+A > B))  <b style='color:red'>Node 2</b>
		if ((A ~= B) && (B ~= C) && (C ~= A))  <b style='color:red'>Node 3</b>
			type = 'Scalene';  <b style='color:red'>Node 4</b>
		else
	if (((A == B) && (B ~= C)) || ((B == C) && (C ~= A)) || ((C == A) && (A ~= B)))  <b style='color:red'>Node 5</b>
				type = 'Isosceles';  <b style='color:red'>Node 6</b>
			else
				type = 'Equilateral';  <b style='color:red'>Node 7</b>
			end
		end
	else
		type = 'Not a triangle';  <b style='color:red'>Node 9</b>
	end
end  <b style='color:red'>Node 8</b>
