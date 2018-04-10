function [traversedPath,branchVal] = fitnessMiniMaxi(branchNo, predicate)
traversedPath = [];
traversedPath = [traversedPath '1 ' ];
	k = 1; % the smallest step for integer
	traversedPath = [traversedPath '2 ' ];
	switch (branchNo)
		case 1,
		traversedPath = [traversedPath '3 ' ];
			% branch #1: (idx <= numLength)
			branchVal = predicate(1) - predicate(2);
		case 2,
		traversedPath = [traversedPath '4 ' ];
			% branch #2: (maxi < num(idx))
			branchVal = predicate(1) - predicate(2);
		case 3,
		traversedPath = [traversedPath '5 ' ];
			% branch #3: (mini > num(idx))
			branchVal = predicate(2) - predicate(1);
	end
	% instrument Branch # 1
	traversedPath = [traversedPath '6 ' ];
	if ((branchNo == 2) || (branchNo == 3)),
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 2
		traversedPath = [traversedPath '7 ' ];
		if (branchVal < 0)
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '8 ' ];
			branchVal = branchVal - k;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '9 ' ];
			branchVal = branchVal + k;
		end
	end
traversedPath = [traversedPath '10 ' ];
end
