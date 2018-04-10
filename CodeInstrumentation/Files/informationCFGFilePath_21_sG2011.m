% The function accepts a population of 5-number inputs <b style='color:red'>Node 1</b>
function pop = spaceGong2011(depop)
	[px,py]=size(depop);
	for i=1:px % Branch # 1 <b style='color:red'>Node 2</b>
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
		end <b style='color:red'>Node 18</b>
	pop(i,:) = p;
	end
end <b style='color:red'>Node 19</b>
