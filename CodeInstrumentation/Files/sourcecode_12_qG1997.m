function [ q r] = quotientGallagher1997(integers)
	q = 0; % q: quotient
	r = integers(1); % r: remainder; integers(1): nominator
	t = integers(2); % integers(2): denominator
	while (r >= t)
		t = t * 2;
	end
	while (t ~= integers(2))
		q = q * 2;
		t = t / 2;
		if (t <= r)
			r = r - t;
			q = q + 1;
		end
	end
end