function result = expintBueno2002(numbersIn) <b style='color:red'>Node 1</b>
	n = numbersIn(1); % integer
	x = numbersIn(2); % floa
	MAXIT = 100;
	EULER = 0.5772156649;
	FPMIN = 1.0e-30;
	EPS = 1.0e-7;
	nm1 = n - 1;
	if (n < 0 || x < 0.0 || (x == 0.0 && (n == 0.0 || n==1))) <b style='color:red'>Node 2</b>
		result = 0; <b style='color:red'>Node 3</b>
		% disp('bad arguments in expintBueno2002');
	elseif (n == 0)
		result = exp(-x)/x; <b style='color:red'>Node 4</b>
	elseif (x == 0.0)
		result = 1.0/nm1; % strangy: what is nm1? <b style='color:red'>Node 5</b>
	elseif (x > 1.0)
		b = x + n;
		c = 1.0 / FPMIN;
		d = 1.0 / b;
		h = d;
		for i=1 : MAXIT <b style='color:red'>Node 6</b>
			a = -i * (nm1 + i);
			b = b + 2.0;
			d = 1.0 / (a*d+b);
			c = b + a / c;
			del = c * d;
			h = h * del;
			if (abs(del-1.0) < EPS) % abs is fabs in C <b style='color:red'>Node 7</b>
				result = h * exp(-x); <b style='color:red'>Node 8</b>
				return;
			end <b style='color:red'>Node 9</b>
		end
		disp('continuated fraction failed in expint');
	else
		% ans = (nm1!=0 ? 1.0/nm1 : -log(x)-EULER);
		% is interpreted as follows
		if (nm1 ~= 0) <b style='color:red'>Node 11</b>
			result = 1.0 / nm1; <b style='color:red'>Node 12</b>
		else
			result = -log(x)-EULER; <b style='color:red'>Node 13</b>
		end
		fact = 1.0;
		for i = 1 : MAXIT <b style='color:red'>Node 14</b>
			fact = fact * (-x / i);
			if (i ~= nm1) <b style='color:red'>Node 15</b>
				del = -fact / (i - nm1); <b style='color:red'>Node 16</b>
			else
				psi = -EULER;
				for ii = 1 : nm1 <b style='color:red'>Node 17</b>
					psi = psi + (1/ii); <b style='color:red'>Node 18</b>
				end
				del = fact * (-log(x) + psi);
			end
			result = result + del;
			if (abs(del) < abs(result) * EPS) % abs is fabs in C <b style='color:red'>Node 19</b>
				return; <b style='color:red'>Node 20</b>
			end <b style='color:red'>Node 21</b>
		end
		disp('series failed in expint');
	end
end <b style='color:red'>Node 10</b>
