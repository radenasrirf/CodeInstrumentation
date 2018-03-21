function [traversedPath,sortedArray] = insertion(anyArray)
traversedPath = [];
traversedPath = [traversedPath '1 ' ];
	k = 1; % The smallest integer increment
	n = length(anyArray);
	i = 2;
	% instrument Branch # 1
	traversedPath = [traversedPath '2 ' ];
	for i=2:n 
		x = anyArray(i);
		j = i + 1;
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 2
		traversedPath = [traversedPath '3 ' ];
		while ((j > 0) & (anyArray(j) > x)),
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '4 ' ];
			anyArray(j+1) = anyArray(j);
			j = j - 1;
		traversedPath = [traversedPath '3 ' ];
		end
		traversedPath = [traversedPath '(F) ' ];
		traversedPath = [traversedPath '5 ' ];
		anyArray(j+1) = x;
	traversedPath = [traversedPath '2 ' ];
	end
	sortedArray = anyArray;
traversedPath = [traversedPath '(F) ' ];
traversedPath = [traversedPath '6 ' ];
end
