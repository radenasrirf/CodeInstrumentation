function  pop = bubbleGong2011(depop)
	[px,py]=size(depop);
	for i=1:px % Branch # 1
		q=1;
		p=depop(i,:);
		for j=1:py-1 % Branch # 
			for k=j+1:py % Branch # 3
				d(q,1)=p(k)-p(j)+0.1;
				d(q,1)=1-1.001^(-d(q,1));
				d(q,2)=p(j)-p(k);
				d(q,2)=1-1.001^(-d(q,2));
				if p(j)>p(k) % Branch # 4
					temp=p(j);
					p(j)=p(k);
					p(k)=temp;
					d(q,1)=0;
				else
					d(q,2)=0;
				end
				q=q+1;
			end
		end
		pop(i,:) = p;
	end
end