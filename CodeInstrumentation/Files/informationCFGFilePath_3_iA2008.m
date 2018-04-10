function sortedArray = insertion(anyArray) <b style='color:red'>Node 1</b>
k = 1; % The smallest integer increment
n = length(anyArray);
i = 2;
for i=2:n  <b style='color:red'>Node 2</b>
	x = anyArray(i);
	j = i - 1;
	while ((j > 0) & (anyArray(j) > x)), <b style='color:red'>Node 3</b>
		anyArray(j+1) = anyArray(j); <b style='color:red'>Node 4</b>
		j = j - 1;
	end <b style='color:red'>Node 5</b>
	anyArray(j+1) = x;
end
sortedArray = anyArray;
end <b style='color:red'>Node 6</b>
