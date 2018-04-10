function [q, r] = quotientBueno2002(operands) <b style='color:red'>Node 1</b>
	n = operands(1); % First number
	d = operands(2); % Second number
	q = 0;
	if (d ~= 0) <b style='color:red'>Node 2</b>
		if ( (d > 0) && (n > 0) ) <b style='color:red'>Node 3</b>
			q = 0;
			r = n;
			t = d;
			while (r >= t) <b style='color:red'>Node 4</b>
				t = t * 2; <b style='color:red'>Node 5</b>
			end
			while (t ~= d) <b style='color:red'>Node 6</b>
				q = q * 2;
				t = t / 2;
				if (t <= r) <b style='color:red'>Node 7</b>
					r = r - t; <b style='color:red'>Node 8</b>
					q = q + 1;
				end <b style='color:red'>Node 9</b>
			end
		end
	end
end <b style='color:red'>Node 10</b>
