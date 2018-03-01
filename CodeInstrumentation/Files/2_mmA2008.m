function miniMaxi = minimaxi(num)
numLength = length(num);
mini = num(1);
maxi = num(1);
idx = 2;
while (idx <= numLength) % Branching #1
	if maxi < num(idx) % Branching #2
		maxi = num(idx);
	end
	if mini > num(idx) % Branching #3
		mini = num(idx);
	end
	idx = idx+1;
end % while end
miniMaxi = [mini maxi];
end