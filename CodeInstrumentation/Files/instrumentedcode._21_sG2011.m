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
		unit3=p(3);
		error1=p(4);
		error2=p(5);
		d(1,1)=abs(unit1-1);
		d(1,2)=2;
		d(1,1)=1-1.001^(-d(1,1));
		d(1,2)=1-1.001^(-d(1,2));
		d(2,1)=abs(unit2-2);
		d(2,1)=1-1.001^(-d(2,1));
		d(2,2)=2;
		d(2,2)=1-1.001^(-d(2,2));
		d(3,1)=abs(unit3-3);
		d(3,1)=1-1.001^(-d(3,1));
		d(3,2)=2;
		d(3,2)=1-1.001^(-d(3,2));
		d(4,1)=abs(error1-0);
		d(4,1)=1-1.001^(-d(4,1));
		d(4,2)=2;
		d(4,2)=1-1.001^(-d(4,2));
		d(5,1)=abs(error2-0);
		d(5,1)=1-1.001^(-d(5,1));
		d(5,2)=2;
		d(5,2)=1-1.001^(-d(5,2));
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
		traversedPath = [traversedPath '18 ' ];
	pop(i,:) = p;
	traversedPath = [traversedPath '2 ' ];
	end
traversedPath = [traversedPath '(F) ' ];
traversedPath = [traversedPath '19 ' ];
end
