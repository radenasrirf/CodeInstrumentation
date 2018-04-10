function [traversedPath,q, r] = quotientBueno2002(operands)
traversedPath = [];
traversedPath = [traversedPath '1 ' ];
	n = operands(1); % First number
	d = operands(2); % Second number
	q = 0;
	% instrument Branch # 1
	traversedPath = [traversedPath '2 ' ];
	if (d ~= 0)
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 2
		traversedPath = [traversedPath '3 ' ];
		if ( (d > 0) && (n > 0) )
			q = 0;
			r = n;
			t = d;
			traversedPath = [traversedPath '(T) ' ];
			% instrument Branch # 3
			traversedPath = [traversedPath '4 ' ];
			while (r >= t)
				traversedPath = [traversedPath '(T) ' ];
				traversedPath = [traversedPath '5 ' ];
				t = t * 2;
			traversedPath = [traversedPath '4 ' ];
			end
			traversedPath = [traversedPath '(F) ' ];
			% instrument Branch # 4
			traversedPath = [traversedPath '6 ' ];
			while (t ~= d)
				q = q * 2;
				t = t / 2;
				traversedPath = [traversedPath '(T) ' ];
				% instrument Branch # 5
				traversedPath = [traversedPath '7 ' ];
				if (t <= r)
					traversedPath = [traversedPath '(T) ' ];
					traversedPath = [traversedPath '8 ' ];
					r = r - t;
					q = q + 1;
				end
				traversedPath = [traversedPath '9 ' ];
			traversedPath = [traversedPath '6 ' ];
			end
		end
	end
traversedPath = [traversedPath '(F) ' ];
traversedPath = [traversedPath '10 ' ];
end
