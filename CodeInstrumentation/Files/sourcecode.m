function branchVal = fitnessMiniMaxi(branchNo, predicate)
	k = 1; % the smallest step for integer
	switch (branchNo)
		case 1,
			% branch #1: (idx <= numLength)
			branchVal = predicate(1) - predicate(2);
		case 2,
			% branch #2: (maxi < num(idx))
			branchVal = predicate(1) - predicate(2);
		case 3,
			% branch #3: (mini > num(idx))
			branchVal = predicate(2) - predicate(1);
	end
	if ((branchNo == 2) || (branchNo == 3)),
		if (branchVal < 0)
			branchVal = branchVal - k;
		else
			branchVal = branchVal + k;
		end
	end
end