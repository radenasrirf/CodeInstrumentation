function [q, r] = quotientBueno2002(operands)
	n = operands(1); % First number
	d = operands(2); % Second number
	q = 0;
	if (d ~= 0)
		if ( (d > 0) && (n > 0) )
			q = 0;
			r = n;
			t = d;
			while (r >= t)
				t = t * 2;
			end
			while (t ~= d)
				q = q * 2;
				t = t / 2;
				if (t <= r)
					r = r - t;
					q = q + 1;
				end
			end
		end
	end
end