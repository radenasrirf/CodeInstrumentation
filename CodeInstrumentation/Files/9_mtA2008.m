function [minimaxi, type] = mmTriangle(num)
	numLength = length(num);
	mini = num(1);
	maxi = num(1);
	idx = 2;
	while (idx <= numLength)
		if maxi < num(idx) % Branching #2
			maxi = num(idx);
		end
		if mini > num(idx) % Branching #3
			mini = num(idx);
		end
		idx = idx+1;
	end
	minimaxi = [mini maxi];
	A = num(1); % First side
	B = num(2); % Second side
	C = num(3); % Third side
	if ((A+B > C) & (B+C > A) & (C+A > B))
		if ((A ~= B) & (B ~= C) & (C ~= A)) % Branch # 5
			type = 'Scalene';
		else
			if (((A == B) & (B ~= C)) | ((B == C) & (C ~= A)) | ((C == A) & (A ~= B)))
				type = 'Isosceles';
			else
				type = 'Equilateral';
			end
		end
	else
		type = 'Not a triangle';
	end
end