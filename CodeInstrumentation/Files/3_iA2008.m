function sortedArray = insertion(anyArray)
k = 1; % The smallest integer increment
n = length(anyArray);
i = 2;
for i=2:n 
	x = anyArray(i);
	j = i - 1;
	while ((j > 0) & (anyArray(j) > x)),
		anyArray(j+1) = anyArray(j);
		j = j - 1;
	end
	anyArray(j+1) = x;
end
sortedArray = anyArray;
end