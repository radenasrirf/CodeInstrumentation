function [traversedPath,itemIndex] = binary(itemNumbers)
traversedPath = [];
traversedPath = [traversedPath '1 ' ];
	item = itemNumbers(1);
	numbers = itemNumbers(1,2:end);
	lowerIdx = 1;
	upperIdx = length(numbers);
	% instrument Branch # 1
	traversedPath = [traversedPath '2 ' ];
	while (lowerIdx ~= upperIdx), % Branch # 1
		temp = lowerIdx + upperIdx; % additional statement
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 2
		traversedPath = [traversedPath '3 ' ];
		if (mod(temp, 2) ~= 0), 
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '4 ' ];
			temp = temp - 1; 
		end % additional statement
			idx = temp / 2;
		% instrument Branch # 3
		traversedPath = [traversedPath '5 ' ];
		if (numbers(idx) < item), % Branch # 2
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '6 ' ];
			lowerIdx = idx + 1;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '7 ' ];
			upperIdx = idx;
		end
		traversedPath = [traversedPath '8 ' ];
	traversedPath = [traversedPath '2 ' ];
	end
	% Additional code that returns -1 if the item is not found
	traversedPath = [traversedPath '(F) ' ];
	% instrument Branch # 4
	traversedPath = [traversedPath '9 ' ];
	if (item == numbers(lowerIdx)),
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '10 ' ];
		temIndex = lowerIdx;
	else
		traversedPath = [traversedPath '(F) ' ];
		traversedPath = [traversedPath '11 ' ];
		itemIndex = -1;
	end
	% instrument Branch # 5
	traversedPath = [traversedPath '12 ' ];
	while (lowerIdx ~= upperIdx), % Branch # 1
		temp = lowerIdx + upperIdx; % additional statement
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 6
		traversedPath = [traversedPath '13 ' ];
		if (mod(temp, 2) ~= 0), 
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '14 ' ];
			temp = temp - 1; 
		end % additional statement
			idx = temp / 2;
		% instrument Branch # 7
		traversedPath = [traversedPath '15 ' ];
		if (numbers(idx) < item), % Branch # 2
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '16 ' ];
			lowerIdx = idx + 1;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '17 ' ];
			upperIdx = idx;
		end
		traversedPath = [traversedPath '18 ' ];
	traversedPath = [traversedPath '12 ' ];
	end
	% Additional code that returns -1 if the item is not found
	traversedPath = [traversedPath '(F) ' ];
	% instrument Branch # 8
	traversedPath = [traversedPath '19 ' ];
	if (item == numbers(lowerIdx)),
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '20 ' ];
		temIndex = lowerIdx;
	else
		traversedPath = [traversedPath '(F) ' ];
		traversedPath = [traversedPath '21 ' ];
		itemIndex = -1;
	end
	% instrument Branch # 9
	traversedPath = [traversedPath '22 ' ];
	while (lowerIdx ~= upperIdx), % Branch # 1
		temp = lowerIdx + upperIdx; % additional statement
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 10
		traversedPath = [traversedPath '23 ' ];
		if (mod(temp, 2) ~= 0), 
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '24 ' ];
			temp = temp - 1; 
		end % additional statement
			idx = temp / 2;
		% instrument Branch # 11
		traversedPath = [traversedPath '25 ' ];
		if (numbers(idx) < item), % Branch # 2
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '26 ' ];
			lowerIdx = idx + 1;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '27 ' ];
			upperIdx = idx;
		end
		traversedPath = [traversedPath '28 ' ];
	traversedPath = [traversedPath '22 ' ];
	end
	% Additional code that returns -1 if the item is not found
	traversedPath = [traversedPath '(F) ' ];
	% instrument Branch # 12
	traversedPath = [traversedPath '29 ' ];
	if (item == numbers(lowerIdx)),
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '30 ' ];
		temIndex = lowerIdx;
	else
		traversedPath = [traversedPath '(F) ' ];
		traversedPath = [traversedPath '31 ' ];
		itemIndex = -1;
	end
	% instrument Branch # 13
	traversedPath = [traversedPath '32 ' ];
	while (lowerIdx ~= upperIdx), % Branch # 1
		temp = lowerIdx + upperIdx; % additional statement
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 14
		traversedPath = [traversedPath '33 ' ];
		if (mod(temp, 2) ~= 0), 
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '34 ' ];
			temp = temp - 1; 
		end % additional statement
			idx = temp / 2;
		% instrument Branch # 15
		traversedPath = [traversedPath '35 ' ];
		if (numbers(idx) < item), % Branch # 2
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '36 ' ];
			lowerIdx = idx + 1;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '37 ' ];
			upperIdx = idx;
		end
		traversedPath = [traversedPath '38 ' ];
	traversedPath = [traversedPath '32 ' ];
	end
	% Additional code that returns -1 if the item is not found
	traversedPath = [traversedPath '(F) ' ];
	% instrument Branch # 16
	traversedPath = [traversedPath '39 ' ];
	if (item == numbers(lowerIdx)),
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '40 ' ];
		temIndex = lowerIdx;
	else
		traversedPath = [traversedPath '(F) ' ];
		traversedPath = [traversedPath '41 ' ];
		itemIndex = -1;
	end
	% instrument Branch # 17
	traversedPath = [traversedPath '42 ' ];
	while (lowerIdx ~= upperIdx), % Branch # 1
		temp = lowerIdx + upperIdx; % additional statement
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 18
		traversedPath = [traversedPath '43 ' ];
		if (mod(temp, 2) ~= 0), 
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '44 ' ];
			temp = temp - 1; 
		end % additional statement
			idx = temp / 2;
		% instrument Branch # 19
		traversedPath = [traversedPath '45 ' ];
		if (numbers(idx) < item), % Branch # 2
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '46 ' ];
			lowerIdx = idx + 1;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '47 ' ];
			upperIdx = idx;
		end
		traversedPath = [traversedPath '48 ' ];
	traversedPath = [traversedPath '42 ' ];
	end
	% Additional code that returns -1 if the item is not found
	traversedPath = [traversedPath '(F) ' ];
	% instrument Branch # 20
	traversedPath = [traversedPath '49 ' ];
	if (item == numbers(lowerIdx)),
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '50 ' ];
		temIndex = lowerIdx;
	else
		traversedPath = [traversedPath '(F) ' ];
		traversedPath = [traversedPath '51 ' ];
		itemIndex = -1;
	end
traversedPath = [traversedPath '52 ' ];
end
