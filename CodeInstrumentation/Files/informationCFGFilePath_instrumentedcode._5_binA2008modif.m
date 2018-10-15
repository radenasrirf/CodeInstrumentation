function [traversedPath,itemIndex] = binary(itemNumbers) <b style='color:red'>Node 1</b>
traversedPath = [];
traversedPath = [traversedPath '1 ' ];
	item = itemNumbers(1);
	numbers = itemNumbers(1,2:end);
	lowerIdx = 1;
	upperIdx = length(numbers);
	% instrument Branch # 1
	traversedPath = [traversedPath '2 ' ];
	while (lowerIdx ~= upperIdx), % Branch # 1 <b style='color:red'>Node 2</b>
		temp = lowerIdx + upperIdx; % additional statement
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 2
		traversedPath = [traversedPath '3 ' ];
		if (mod(temp, 2) ~= 0),  <b style='color:red'>Node 3</b>
			traversedPath = [traversedPath '(T) ' ]; <b style='color:red'>Node 4</b>
			traversedPath = [traversedPath '4 ' ];
			temp = temp - 1; 
		end % additional statement
			idx = temp / 2;
		% instrument Branch # 3
		traversedPath = [traversedPath '5 ' ];
		if (numbers(idx) < item), % Branch # 2 <b style='color:red'>Node 5</b>
			traversedPath = [traversedPath '(T) ' ]; <b style='color:red'>Node 6</b>
			traversedPath = [traversedPath '6 ' ];
			lowerIdx = idx + 1;
		else
			traversedPath = [traversedPath '(F) ' ]; <b style='color:red'>Node 7</b>
			traversedPath = [traversedPath '7 ' ];
			upperIdx = idx;
		end <b style='color:red'>Node 8</b>
		traversedPath = [traversedPath '8 ' ];
	traversedPath = [traversedPath '2 ' ];
	end
	% Additional code that returns -1 if the item is not found
	traversedPath = [traversedPath '(F) ' ];
	% instrument Branch # 4
	traversedPath = [traversedPath '9 ' ];
	if (item == numbers(lowerIdx)), <b style='color:red'>Node 9</b>
		traversedPath = [traversedPath '(T) ' ]; <b style='color:red'>Node 10</b>
		traversedPath = [traversedPath '10 ' ];
		temIndex = lowerIdx;
	else
		traversedPath = [traversedPath '(F) ' ]; <b style='color:red'>Node 11</b>
		traversedPath = [traversedPath '11 ' ];
		itemIndex = -1;
	end
	% instrument Branch # 5
	traversedPath = [traversedPath '12 ' ];
	while (lowerIdx ~= upperIdx), % Branch # 1 <b style='color:red'>Node 12</b>
		temp = lowerIdx + upperIdx; % additional statement
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 6
		traversedPath = [traversedPath '13 ' ];
		if (mod(temp, 2) ~= 0),  <b style='color:red'>Node 13</b>
			traversedPath = [traversedPath '(T) ' ]; <b style='color:red'>Node 14</b>
			traversedPath = [traversedPath '14 ' ];
			temp = temp - 1; 
		end % additional statement
			idx = temp / 2;
		% instrument Branch # 7
		traversedPath = [traversedPath '15 ' ];
		if (numbers(idx) < item), % Branch # 2 <b style='color:red'>Node 15</b>
			traversedPath = [traversedPath '(T) ' ]; <b style='color:red'>Node 16</b>
			traversedPath = [traversedPath '16 ' ];
			lowerIdx = idx + 1;
		else
			traversedPath = [traversedPath '(F) ' ]; <b style='color:red'>Node 17</b>
			traversedPath = [traversedPath '17 ' ];
			upperIdx = idx;
		end <b style='color:red'>Node 18</b>
		traversedPath = [traversedPath '18 ' ];
	traversedPath = [traversedPath '12 ' ];
	end
	% Additional code that returns -1 if the item is not found
	traversedPath = [traversedPath '(F) ' ];
	% instrument Branch # 8
	traversedPath = [traversedPath '19 ' ];
	if (item == numbers(lowerIdx)), <b style='color:red'>Node 19</b>
		traversedPath = [traversedPath '(T) ' ]; <b style='color:red'>Node 20</b>
		traversedPath = [traversedPath '20 ' ];
		temIndex = lowerIdx;
	else
		traversedPath = [traversedPath '(F) ' ]; <b style='color:red'>Node 21</b>
		traversedPath = [traversedPath '21 ' ];
		itemIndex = -1;
	end
	% instrument Branch # 9
	traversedPath = [traversedPath '22 ' ];
	while (lowerIdx ~= upperIdx), % Branch # 1 <b style='color:red'>Node 22</b>
		temp = lowerIdx + upperIdx; % additional statement
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 10
		traversedPath = [traversedPath '23 ' ];
		if (mod(temp, 2) ~= 0),  <b style='color:red'>Node 23</b>
			traversedPath = [traversedPath '(T) ' ]; <b style='color:red'>Node 24</b>
			traversedPath = [traversedPath '24 ' ];
			temp = temp - 1; 
		end % additional statement
			idx = temp / 2;
		% instrument Branch # 11
		traversedPath = [traversedPath '25 ' ];
		if (numbers(idx) < item), % Branch # 2 <b style='color:red'>Node 25</b>
			traversedPath = [traversedPath '(T) ' ]; <b style='color:red'>Node 26</b>
			traversedPath = [traversedPath '26 ' ];
			lowerIdx = idx + 1;
		else
			traversedPath = [traversedPath '(F) ' ]; <b style='color:red'>Node 27</b>
			traversedPath = [traversedPath '27 ' ];
			upperIdx = idx;
		end <b style='color:red'>Node 28</b>
		traversedPath = [traversedPath '28 ' ];
	traversedPath = [traversedPath '22 ' ];
	end
	% Additional code that returns -1 if the item is not found
	traversedPath = [traversedPath '(F) ' ];
	% instrument Branch # 12
	traversedPath = [traversedPath '29 ' ];
	if (item == numbers(lowerIdx)), <b style='color:red'>Node 29</b>
		traversedPath = [traversedPath '(T) ' ]; <b style='color:red'>Node 30</b>
		traversedPath = [traversedPath '30 ' ];
		temIndex = lowerIdx;
	else
		traversedPath = [traversedPath '(F) ' ]; <b style='color:red'>Node 31</b>
		traversedPath = [traversedPath '31 ' ];
		itemIndex = -1;
	end
	% instrument Branch # 13
	traversedPath = [traversedPath '32 ' ];
	while (lowerIdx ~= upperIdx), % Branch # 1 <b style='color:red'>Node 32</b>
		temp = lowerIdx + upperIdx; % additional statement
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 14
		traversedPath = [traversedPath '33 ' ];
		if (mod(temp, 2) ~= 0),  <b style='color:red'>Node 33</b>
			traversedPath = [traversedPath '(T) ' ]; <b style='color:red'>Node 34</b>
			traversedPath = [traversedPath '34 ' ];
			temp = temp - 1; 
		end % additional statement
			idx = temp / 2;
		% instrument Branch # 15
		traversedPath = [traversedPath '35 ' ];
		if (numbers(idx) < item), % Branch # 2 <b style='color:red'>Node 35</b>
			traversedPath = [traversedPath '(T) ' ]; <b style='color:red'>Node 36</b>
			traversedPath = [traversedPath '36 ' ];
			lowerIdx = idx + 1;
		else
			traversedPath = [traversedPath '(F) ' ]; <b style='color:red'>Node 37</b>
			traversedPath = [traversedPath '37 ' ];
			upperIdx = idx;
		end <b style='color:red'>Node 38</b>
		traversedPath = [traversedPath '38 ' ];
	traversedPath = [traversedPath '32 ' ];
	end
	% Additional code that returns -1 if the item is not found
	traversedPath = [traversedPath '(F) ' ];
	% instrument Branch # 16
	traversedPath = [traversedPath '39 ' ];
	if (item == numbers(lowerIdx)), <b style='color:red'>Node 39</b>
		traversedPath = [traversedPath '(T) ' ]; <b style='color:red'>Node 40</b>
		traversedPath = [traversedPath '40 ' ];
		temIndex = lowerIdx;
	else
		traversedPath = [traversedPath '(F) ' ]; <b style='color:red'>Node 41</b>
		traversedPath = [traversedPath '41 ' ];
		itemIndex = -1;
	end
	% instrument Branch # 17
	traversedPath = [traversedPath '42 ' ];
	while (lowerIdx ~= upperIdx), % Branch # 1 <b style='color:red'>Node 42</b>
		temp = lowerIdx + upperIdx; % additional statement
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 18
		traversedPath = [traversedPath '43 ' ];
		if (mod(temp, 2) ~= 0),  <b style='color:red'>Node 43</b>
			traversedPath = [traversedPath '(T) ' ]; <b style='color:red'>Node 44</b>
			traversedPath = [traversedPath '44 ' ];
			temp = temp - 1; 
		end % additional statement
			idx = temp / 2;
		% instrument Branch # 19
		traversedPath = [traversedPath '45 ' ];
		if (numbers(idx) < item), % Branch # 2 <b style='color:red'>Node 45</b>
			traversedPath = [traversedPath '(T) ' ]; <b style='color:red'>Node 46</b>
			traversedPath = [traversedPath '46 ' ];
			lowerIdx = idx + 1;
		else
			traversedPath = [traversedPath '(F) ' ]; <b style='color:red'>Node 47</b>
			traversedPath = [traversedPath '47 ' ];
			upperIdx = idx;
		end <b style='color:red'>Node 48</b>
		traversedPath = [traversedPath '48 ' ];
	traversedPath = [traversedPath '42 ' ];
	end
	% Additional code that returns -1 if the item is not found
	traversedPath = [traversedPath '(F) ' ];
	% instrument Branch # 20
	traversedPath = [traversedPath '49 ' ];
	if (item == numbers(lowerIdx)), <b style='color:red'>Node 49</b>
		traversedPath = [traversedPath '(T) ' ]; <b style='color:red'>Node 50</b>
		traversedPath = [traversedPath '50 ' ];
		temIndex = lowerIdx;
	else
		traversedPath = [traversedPath '(F) ' ]; <b style='color:red'>Node 51</b>
		traversedPath = [traversedPath '51 ' ];
		itemIndex = -1;
	end
traversedPath = [traversedPath '52 ' ];
end <b style='color:red'>Node 52</b>
