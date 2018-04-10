function itemIndex = binary(itemNumbers) <b style='color:red'>Node 1</b>
	item = itemNumbers(1);
	numbers = itemNumbers(1,2:end);
	lowerIdx = 1;
	upperIdx = length(numbers);
	while (lowerIdx ~= upperIdx), % Branch # 1 <b style='color:red'>Node 2</b>
		temp = lowerIdx + upperIdx; % additional statement
		if (mod(temp, 2) ~= 0),  <b style='color:red'>Node 3</b>
			temp = temp - 1;  <b style='color:red'>Node 4</b>
		end % additional statement
			idx = temp / 2;
		if (numbers(idx) < item), % Branch # 2 <b style='color:red'>Node 5</b>
			lowerIdx = idx + 1; <b style='color:red'>Node 6</b>
		else
			upperIdx = idx; <b style='color:red'>Node 7</b>
		end <b style='color:red'>Node 8</b>
	end
	% Additional code that returns -1 if the item is not found
	if (item == numbers(lowerIdx)), <b style='color:red'>Node 9</b>
		temIndex = lowerIdx; <b style='color:red'>Node 10</b>
	else
		itemIndex = -1; <b style='color:red'>Node 11</b>
	end
end <b style='color:red'>Node 12</b>
