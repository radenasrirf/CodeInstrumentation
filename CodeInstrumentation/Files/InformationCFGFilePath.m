function branchVal = fitnessMiniMaxi(branchNo, predicate) <b style='color:red'>Node 1</b>
	k = 1; % the smallest step for integer
	switch (branchNo) <b style='color:red'>Node 2</b>
		case 1,
			% branch #1: (idx <= numLength) <b style='color:red'>Node 3</b>
			branchVal = predicate(1) - predicate(2);
		case 2,
			% branch #2: (maxi < num(idx)) <b style='color:red'>Node 4</b>
			branchVal = predicate(1) - predicate(2);
		case 3,
			% branch #3: (mini > num(idx)) <b style='color:red'>Node 5</b>
			branchVal = predicate(2) - predicate(1);
	end
	if ((branchNo == 2) || (branchNo == 3)), <b style='color:red'>Node 6</b>
		if (branchVal < 0) <b style='color:red'>Node 7</b>
			branchVal = branchVal - k; <b style='color:red'>Node 8</b>
		else
			branchVal = branchVal + k; <b style='color:red'>Node 9</b>
		end
	end
end <b style='color:red'>Node 10</b>
