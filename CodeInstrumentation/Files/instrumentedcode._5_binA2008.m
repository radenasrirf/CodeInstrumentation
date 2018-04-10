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
traversedPath = [traversedPath '12 ' ];
end
