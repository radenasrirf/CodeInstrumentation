traversedPath = [traversedPath '1 ' ];
% The function accepts a population of 5-number inputs
function p[traversedPath,op] = spaceGong2011(depop)
traversedPath = [];
	[px,py]=size(depop);
	% instrument Branch # 1
	traversedPath = [traversedPath '2 ' ];
	for i=1:px % Branch # 1
		q=1;
		p=depop(i,:);
		unit1=p(1);
		unit2=p(2);
		u=zeros(1,5);
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 2
		traversedPath = [traversedPath '3 ' ];
		if unit1 == 1 % Branch # 2
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '4 ' ];
			x_ptr=10;
			d(1,1)=0;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '5 ' ];
			d(1,2)=0;
		end
		% instrument Branch # 3
		traversedPath = [traversedPath '6 ' ];
		if unit2 == 2 % Branch # 3
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '7 ' ];
			x_ptr=100;
			d(2,1)=0;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '8 ' ];
			d(2,2)=0;
		end
		% instrument Branch # 4
		traversedPath = [traversedPath '9 ' ];
		if unit3 == 3 % Branch # 4
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '10 ' ];
			x_ptr=1000;
			d(3,1)=0;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '11 ' ];
			d(3,2)=0;
		end
		% instrument Branch # 5
		traversedPath = [traversedPath '12 ' ];
		if error1 == 0 % Branch # 5
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '13 ' ];
			d(4,1)=0;
			% return 1
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '14 ' ];
			d(4,2)=0;
		end
		% instrument Branch # 6
		traversedPath = [traversedPath '15 ' ];
		if error2 == 0 % Branch # 6
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '16 ' ];
			d(5,1)=0;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '17 ' ];
			d(5,2)=0;
		end
		
		% instrument Branch # 7
		traversedPath = [traversedPath '18 ' ];
		if unit1 == 1 % Branch # 2
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '19 ' ];
			x_ptr=10;
			d(1,1)=0;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '20 ' ];
			d(1,2)=0;
		end
		% instrument Branch # 8
		traversedPath = [traversedPath '21 ' ];
		if unit2 == 2 % Branch # 3
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '22 ' ];
			x_ptr=100;
			d(2,1)=0;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '23 ' ];
			d(2,2)=0;
		end
		% instrument Branch # 9
		traversedPath = [traversedPath '24 ' ];
		if unit3 == 3 % Branch # 4
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '25 ' ];
			x_ptr=1000;
			d(3,1)=0;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '26 ' ];
			d(3,2)=0;
		end
		% instrument Branch # 10
		traversedPath = [traversedPath '27 ' ];
		if error1 == 0 % Branch # 5
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '28 ' ];
			d(4,1)=0;
			% return 1
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '29 ' ];
			d(4,2)=0;
		end
		% instrument Branch # 11
		traversedPath = [traversedPath '30 ' ];
		if error2 == 0 % Branch # 6
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '31 ' ];
			d(5,1)=0;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '32 ' ];
			d(5,2)=0;
		end
		% instrument Branch # 12
		traversedPath = [traversedPath '33 ' ];
		if unit1 == 1 % Branch # 2
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '34 ' ];
			x_ptr=10;
			d(1,1)=0;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '35 ' ];
			d(1,2)=0;
		end
		% instrument Branch # 13
		traversedPath = [traversedPath '36 ' ];
		if unit2 == 2 % Branch # 3
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '37 ' ];
			x_ptr=100;
			d(2,1)=0;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '38 ' ];
			d(2,2)=0;
		end
		% instrument Branch # 14
		traversedPath = [traversedPath '39 ' ];
		if unit3 == 3 % Branch # 4
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '40 ' ];
			x_ptr=1000;
			d(3,1)=0;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '41 ' ];
			d(3,2)=0;
		end
		% instrument Branch # 15
		traversedPath = [traversedPath '42 ' ];
		if error1 == 0 % Branch # 5
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '43 ' ];
			d(4,1)=0;
			% return 1
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '44 ' ];
			d(4,2)=0;
		end
		% instrument Branch # 16
		traversedPath = [traversedPath '45 ' ];
		if error2 == 0 % Branch # 6
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '46 ' ];
			d(5,1)=0;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '47 ' ];
			d(5,2)=0;
		end
		traversedPath = [traversedPath '48 ' ];
	pop(i,:) = p;
	traversedPath = [traversedPath '2 ' ];
	end
traversedPath = [traversedPath '(F) ' ];
traversedPath = [traversedPath '49 ' ];
end
