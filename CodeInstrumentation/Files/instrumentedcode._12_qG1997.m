function [ traversedPath,q r] = quotientGallagher1997(integers)
traversedPath = [];
traversedPath = [traversedPath '1 ' ];
	q = 0; % q: quotient
	r = integers(1); % r: remainder; integers(1): nominator
	t = integers(2); % integers(2): denominator
	% instrument Branch # 1
	traversedPath = [traversedPath '2 ' ];
	while (r >= t)
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '3 ' ];
		t = t * 2;
	traversedPath = [traversedPath '2 ' ];
	end
	traversedPath = [traversedPath '(F) ' ];
	% instrument Branch # 2
	traversedPath = [traversedPath '4 ' ];
	while (t ~= integers(2))
		q = q * 2;
		t = t / 2;
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 3
		traversedPath = [traversedPath '5 ' ];
		if (t <= r)
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '6 ' ];
			r = r - t;
			q = q + 1;
		end
		traversedPath = [traversedPath '7 ' ];
	traversedPath = [traversedPath '4 ' ];
	end
traversedPath = [traversedPath '(F) ' ];
traversedPath = [traversedPath '8 ' ];
end
