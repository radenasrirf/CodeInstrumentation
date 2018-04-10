function itemIndex = binary(itemNumbers)
	item = itemNumbers(1);
	numbers = itemNumbers(1,2:end);
	lowerIdx = 1;
	upperIdx = length(numbers);
	while (lowerIdx ~= upperIdx), % Branch # 1
		temp = lowerIdx + upperIdx; % additional statement
		if (mod(temp, 2) ~= 0), 
			temp = temp - 1; 
		end % additional statement
			idx = temp / 2;
		if (numbers(idx) < item), % Branch # 2
			lowerIdx = idx + 1;
		else
			upperIdx = idx;
		end
	end
	% Additional code that returns -1 if the item is not found
	if (item == numbers(lowerIdx)),
		temIndex = lowerIdx;
	else
		itemIndex = -1;
	end
end