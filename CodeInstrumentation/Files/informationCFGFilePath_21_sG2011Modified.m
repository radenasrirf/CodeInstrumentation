% The function accepts a population of 5-number inputs <b style='color:red'>Node 1</b>
function pop = spaceGong2011(depop)
	[px,py]=size(depop);
	for i=1:px % Branch # 1 <b style='color:red'>Node 2</b>
		q=1;
		p=depop(i,:);
		unit1=p(1);
		unit2=p(2);
		u=zeros(1,5);
		if unit1 == 1 % Branch # 2 <b style='color:red'>Node 3</b>
			x_ptr=10; <b style='color:red'>Node 4</b>
			d(1,1)=0;
		else
			d(1,2)=0; <b style='color:red'>Node 5</b>
		end
		if unit2 == 2 % Branch # 3 <b style='color:red'>Node 6</b>
			x_ptr=100; <b style='color:red'>Node 7</b>
			d(2,1)=0;
		else
			d(2,2)=0; <b style='color:red'>Node 8</b>
		end
		if unit3 == 3 % Branch # 4 <b style='color:red'>Node 9</b>
			x_ptr=1000; <b style='color:red'>Node 10</b>
			d(3,1)=0;
		else
			d(3,2)=0; <b style='color:red'>Node 11</b>
		end
		if error1 == 0 % Branch # 5 <b style='color:red'>Node 12</b>
			d(4,1)=0; <b style='color:red'>Node 13</b>
			% return 1
		else
			d(4,2)=0; <b style='color:red'>Node 14</b>
		end
		if error2 == 0 % Branch # 6 <b style='color:red'>Node 15</b>
			d(5,1)=0; <b style='color:red'>Node 16</b>
		else
			d(5,2)=0; <b style='color:red'>Node 17</b>
		end
		
		if unit1 == 1 % Branch # 2 <b style='color:red'>Node 18</b>
			x_ptr=10; <b style='color:red'>Node 19</b>
			d(1,1)=0;
		else
			d(1,2)=0; <b style='color:red'>Node 20</b>
		end
		if unit2 == 2 % Branch # 3 <b style='color:red'>Node 21</b>
			x_ptr=100; <b style='color:red'>Node 22</b>
			d(2,1)=0;
		else
			d(2,2)=0; <b style='color:red'>Node 23</b>
		end
		if unit3 == 3 % Branch # 4 <b style='color:red'>Node 24</b>
			x_ptr=1000; <b style='color:red'>Node 25</b>
			d(3,1)=0;
		else
			d(3,2)=0; <b style='color:red'>Node 26</b>
		end
		if error1 == 0 % Branch # 5 <b style='color:red'>Node 27</b>
			d(4,1)=0; <b style='color:red'>Node 28</b>
			% return 1
		else
			d(4,2)=0; <b style='color:red'>Node 29</b>
		end
		if error2 == 0 % Branch # 6 <b style='color:red'>Node 30</b>
			d(5,1)=0; <b style='color:red'>Node 31</b>
		else
			d(5,2)=0; <b style='color:red'>Node 32</b>
		end
		if unit1 == 1 % Branch # 2 <b style='color:red'>Node 33</b>
			x_ptr=10; <b style='color:red'>Node 34</b>
			d(1,1)=0;
		else
			d(1,2)=0; <b style='color:red'>Node 35</b>
		end
		if unit2 == 2 % Branch # 3 <b style='color:red'>Node 36</b>
			x_ptr=100; <b style='color:red'>Node 37</b>
			d(2,1)=0;
		else
			d(2,2)=0; <b style='color:red'>Node 38</b>
		end
		if unit3 == 3 % Branch # 4 <b style='color:red'>Node 39</b>
			x_ptr=1000; <b style='color:red'>Node 40</b>
			d(3,1)=0;
		else
			d(3,2)=0; <b style='color:red'>Node 41</b>
		end
		if error1 == 0 % Branch # 5 <b style='color:red'>Node 42</b>
			d(4,1)=0; <b style='color:red'>Node 43</b>
			% return 1
		else
			d(4,2)=0; <b style='color:red'>Node 44</b>
		end
		if error2 == 0 % Branch # 6 <b style='color:red'>Node 45</b>
			d(5,1)=0; <b style='color:red'>Node 46</b>
		else
			d(5,2)=0; <b style='color:red'>Node 47</b>
		end <b style='color:red'>Node 48</b>
	pop(i,:) = p;
	end
end <b style='color:red'>Node 49</b>
