function miniMaxi = minimaxi(num) <b style='color:red'>Node 1</b>
numLength = length(num);
mini = num(1);
maxi = num(1);
idx = 2;
while (idx <= numLength) % Branching #1 <b style='color:red'>Node 2</b>
	if maxi < num(idx) % Branching #2 <b style='color:red'>Node 3</b>
		maxi = num(idx); <b style='color:red'>Node 4</b>
	end
	if mini > num(idx) % Branching #3 <b style='color:red'>Node 5</b>
		mini = num(idx); <b style='color:red'>Node 6</b>
	end <b style='color:red'>Node 7</b>
	idx = idx+1;
end % while end
miniMaxi = [mini maxi];
end <b style='color:red'>Node 8</b>
