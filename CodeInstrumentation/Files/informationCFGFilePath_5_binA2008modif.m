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
	while (lowerIdx ~= upperIdx), % Branch # 1 <b style='color:red'>Node 12</b>
		temp = lowerIdx + upperIdx; % additional statement
		if (mod(temp, 2) ~= 0),  <b style='color:red'>Node 13</b>
			temp = temp - 1;  <b style='color:red'>Node 14</b>
		end % additional statement
			idx = temp / 2;
		if (numbers(idx) < item), % Branch # 2 <b style='color:red'>Node 15</b>
			lowerIdx = idx + 1; <b style='color:red'>Node 16</b>
		else
			upperIdx = idx; <b style='color:red'>Node 17</b>
		end <b style='color:red'>Node 18</b>
	end
	% Additional code that returns -1 if the item is not found
	if (item == numbers(lowerIdx)), <b style='color:red'>Node 19</b>
		temIndex = lowerIdx; <b style='color:red'>Node 20</b>
	else
		itemIndex = -1; <b style='color:red'>Node 21</b>
	end
	while (lowerIdx ~= upperIdx), % Branch # 1 <b style='color:red'>Node 22</b>
		temp = lowerIdx + upperIdx; % additional statement
		if (mod(temp, 2) ~= 0),  <b style='color:red'>Node 23</b>
			temp = temp - 1;  <b style='color:red'>Node 24</b>
		end % additional statement
			idx = temp / 2;
		if (numbers(idx) < item), % Branch # 2 <b style='color:red'>Node 25</b>
			lowerIdx = idx + 1; <b style='color:red'>Node 26</b>
		else
			upperIdx = idx; <b style='color:red'>Node 27</b>
		end <b style='color:red'>Node 28</b>
	end
	% Additional code that returns -1 if the item is not found
	if (item == numbers(lowerIdx)), <b style='color:red'>Node 29</b>
		temIndex = lowerIdx; <b style='color:red'>Node 30</b>
	else
		itemIndex = -1; <b style='color:red'>Node 31</b>
	end
	while (lowerIdx ~= upperIdx), % Branch # 1 <b style='color:red'>Node 32</b>
		temp = lowerIdx + upperIdx; % additional statement
		if (mod(temp, 2) ~= 0),  <b style='color:red'>Node 33</b>
			temp = temp - 1;  <b style='color:red'>Node 34</b>
		end % additional statement
			idx = temp / 2;
		if (numbers(idx) < item), % Branch # 2 <b style='color:red'>Node 35</b>
			lowerIdx = idx + 1; <b style='color:red'>Node 36</b>
		else
			upperIdx = idx; <b style='color:red'>Node 37</b>
		end <b style='color:red'>Node 38</b>
	end
	% Additional code that returns -1 if the item is not found
	if (item == numbers(lowerIdx)), <b style='color:red'>Node 39</b>
		temIndex = lowerIdx; <b style='color:red'>Node 40</b>
	else
		itemIndex = -1; <b style='color:red'>Node 41</b>
	end
	while (lowerIdx ~= upperIdx), % Branch # 1 <b style='color:red'>Node 42</b>
		temp = lowerIdx + upperIdx; % additional statement
		if (mod(temp, 2) ~= 0),  <b style='color:red'>Node 43</b>
			temp = temp - 1;  <b style='color:red'>Node 44</b>
		end % additional statement
			idx = temp / 2;
		if (numbers(idx) < item), % Branch # 2 <b style='color:red'>Node 45</b>
			lowerIdx = idx + 1; <b style='color:red'>Node 46</b>
		else
			upperIdx = idx; <b style='color:red'>Node 47</b>
		end <b style='color:red'>Node 48</b>
	end
	% Additional code that returns -1 if the item is not found
	if (item == numbers(lowerIdx)), <b style='color:red'>Node 49</b>
		temIndex = lowerIdx; <b style='color:red'>Node 50</b>
	else
		itemIndex = -1; <b style='color:red'>Node 51</b>
	end
end <b style='color:red'>Node 52</b>
