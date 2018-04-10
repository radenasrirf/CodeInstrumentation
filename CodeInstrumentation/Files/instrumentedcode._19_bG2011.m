function [traversedPath, pop] = bubbleGong2011(depop)
traversedPath = [];
traversedPath = [traversedPath '1 ' ];
	[px,py]=size(depop);
	% instrument Branch # 1
	traversedPath = [traversedPath '2 ' ];
	for i=1:px % Branch # 1
		q=1;
		p=depop(i,:);
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 2
		traversedPath = [traversedPath '3 ' ];
		for j=1:py-1 % Branch # 
			traversedPath = [traversedPath '(T) ' ];
			% instrument Branch # 3
			traversedPath = [traversedPath '4 ' ];
			for k=j+1:py % Branch # 3
				d(q,1)=p(k)-p(j)+0.1;
				d(q,1)=1-1.001^(-d(q,1));
				d(q,2)=p(j)-p(k);
				d(q,2)=1-1.001^(-d(q,2));
				traversedPath = [traversedPath '(T) ' ];
				% instrument Branch # 4
				traversedPath = [traversedPath '5 ' ];
				if p(j)>p(k) % Branch # 4
					traversedPath = [traversedPath '(T) ' ];
					traversedPath = [traversedPath '6 ' ];
					temp=p(j);
					p(j)=p(k);
					p(k)=temp;
					d(q,1)=0;
				else
					traversedPath = [traversedPath '(F) ' ];
					traversedPath = [traversedPath '7 ' ];
					d(q,2)=0;
				end
				traversedPath = [traversedPath '8 ' ];
				q=q+1;
			traversedPath = [traversedPath '4 ' ];
			end
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '9 ' ];
		traversedPath = [traversedPath '3 ' ];
		end
		traversedPath = [traversedPath '(F) ' ];
		traversedPath = [traversedPath '10 ' ];
		pop(i,:) = p;
	traversedPath = [traversedPath '2 ' ];
	end
traversedPath = [traversedPath '(F) ' ];
traversedPath = [traversedPath '11 ' ];
end
