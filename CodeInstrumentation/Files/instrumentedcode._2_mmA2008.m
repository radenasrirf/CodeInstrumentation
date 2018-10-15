function [traversedPath,miniMaxi] = minimaxi(num)
traversedPath = [];
traversedPath = [traversedPath '1 ' ];
numLength = length(num);
mini = num(1);
maxi = num(1);
idx = 2;
% instrument Branch # 1
traversedPath = [traversedPath '2 ' ];
while (idx <= numLength) % Branching #1
	traversedPath = [traversedPath '(T) ' ];
	% instrument Branch # 2
	traversedPath = [traversedPath '3 ' ];
	if maxi < num(idx) % Branching #2
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '4 ' ];
		maxi = num(idx);
	end
	% instrument Branch # 3
	traversedPath = [traversedPath '5 ' ];
	if mini > num(idx) % Branching #3
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '6 ' ];
		mini = num(idx);
	end
	traversedPath = [traversedPath '7 ' ];
	idx = idx+1;
												traversedPath = [traversedPath '2 ' ];
end % while end
miniMaxi = [mini maxi];
traversedPath = [traversedPath '(F) ' ];
traversedPath = [traversedPath '8 ' ];
end
