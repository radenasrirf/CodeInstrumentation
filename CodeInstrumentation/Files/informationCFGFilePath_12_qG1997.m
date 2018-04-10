function [ q r] = quotientGallagher1997(integers) <b style='color:red'>Node 1</b>
	q = 0; % q: quotient
	r = integers(1); % r: remainder; integers(1): nominator
	t = integers(2); % integers(2): denominator
	while (r >= t) <b style='color:red'>Node 2</b>
		t = t * 2; <b style='color:red'>Node 3</b>
	end
	while (t ~= integers(2)) <b style='color:red'>Node 4</b>
		q = q * 2;
		t = t / 2;
		if (t <= r) <b style='color:red'>Node 5</b>
			r = r - t; <b style='color:red'>Node 6</b>
			q = q + 1;
		end <b style='color:red'>Node 7</b>
	end
end <b style='color:red'>Node 8</b>
