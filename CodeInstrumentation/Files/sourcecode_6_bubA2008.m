function sortedArray = bubble(anyArray)
	sorted = 0; % 0 means false
	i = 1; n = length(anyArray);
	while ((i <= (n-1)) && ~sorted), % Branch # 1
		sorted = 1;
		j = n;
		for j=n:-1:i+1 % Branch # 2
			if (anyArray(j) < anyArray(j-1)) % Branch # 3
			%exchange(anyArray(j), anyArray(j-1));
			temp = anyArray(j);
			anyArray(j) = anyArray(j-1);
			anyArray(j-1) = temp;
			sorted = 0;
			end
		end
		i = i + 1;
	end
	sortedArray = anyArray;
end