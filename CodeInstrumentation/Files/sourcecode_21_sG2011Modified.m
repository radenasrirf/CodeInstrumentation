% The function accepts a population of 5-number inputs
function pop = spaceGong2011(depop)
	[px,py]=size(depop);
	for i=1:px % Branch # 1
		q=1;
		p=depop(i,:);
		unit1=p(1);
		unit2=p(2);
		u=zeros(1,5);
		if unit1 == 1 % Branch # 2
			x_ptr=10;
			d(1,1)=0;
		else
			d(1,2)=0;
		end
		if unit2 == 2 % Branch # 3
			x_ptr=100;
			d(2,1)=0;
		else
			d(2,2)=0;
		end
		if unit3 == 3 % Branch # 4
			x_ptr=1000;
			d(3,1)=0;
		else
			d(3,2)=0;
		end
		if error1 == 0 % Branch # 5
			d(4,1)=0;
			% return 1
		else
			d(4,2)=0;
		end
		if error2 == 0 % Branch # 6
			d(5,1)=0;
		else
			d(5,2)=0;
		end
		
		if unit1 == 1 % Branch # 2
			x_ptr=10;
			d(1,1)=0;
		else
			d(1,2)=0;
		end
		if unit2 == 2 % Branch # 3
			x_ptr=100;
			d(2,1)=0;
		else
			d(2,2)=0;
		end
		if unit3 == 3 % Branch # 4
			x_ptr=1000;
			d(3,1)=0;
		else
			d(3,2)=0;
		end
		if error1 == 0 % Branch # 5
			d(4,1)=0;
			% return 1
		else
			d(4,2)=0;
		end
		if error2 == 0 % Branch # 6
			d(5,1)=0;
		else
			d(5,2)=0;
		end
		if unit1 == 1 % Branch # 2
			x_ptr=10;
			d(1,1)=0;
		else
			d(1,2)=0;
		end
		if unit2 == 2 % Branch # 3
			x_ptr=100;
			d(2,1)=0;
		else
			d(2,2)=0;
		end
		if unit3 == 3 % Branch # 4
			x_ptr=1000;
			d(3,1)=0;
		else
			d(3,2)=0;
		end
		if error1 == 0 % Branch # 5
			d(4,1)=0;
			% return 1
		else
			d(4,2)=0;
		end
		if error2 == 0 % Branch # 6
			d(5,1)=0;
		else
			d(5,2)=0;
		end
	pop(i,:) = p;
	end
end