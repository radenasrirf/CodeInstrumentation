function  pop = bubbleGong2011(depop) <b style='color:red'>Node 1</b>
	[px,py]=size(depop);
	for i=1:px % Branch # 1 <b style='color:red'>Node 2</b>
		q=1;
		p=depop(i,:);
		for j=1:py-1 % Branch #  <b style='color:red'>Node 3</b>
			for k=j+1:py % Branch # 3 <b style='color:red'>Node 4</b>
				d(q,1)=p(k)-p(j)+0.1;
				d(q,1)=1-1.001^(-d(q,1));
				d(q,2)=p(j)-p(k);
				d(q,2)=1-1.001^(-d(q,2));
				if p(j)>p(k) % Branch # 4 <b style='color:red'>Node 5</b>
					temp=p(j); <b style='color:red'>Node 6</b>
					p(j)=p(k);
					p(k)=temp;
					d(q,1)=0;
				else
					d(q,2)=0; <b style='color:red'>Node 7</b>
				end <b style='color:red'>Node 8</b>
				q=q+1;
			end <b style='color:red'>Node 9</b>
		end <b style='color:red'>Node 10</b>
		pop(i,:) = p;
	end
end <b style='color:red'>Node 11</b>
