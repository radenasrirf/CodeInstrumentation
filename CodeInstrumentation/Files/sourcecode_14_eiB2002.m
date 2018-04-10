function result = expintBueno2002(numbersIn)
	n = numbersIn(1); % integer
	x = numbersIn(2); % floa
	MAXIT = 100;
	EULER = 0.5772156649;
	FPMIN = 1.0e-30;
	EPS = 1.0e-7;
	nm1 = n - 1;
	if (n < 0 || x < 0.0 || (x == 0.0 && (n == 0.0 || n==1)))
		result = 0;
		% disp('bad arguments in expintBueno2002');
	elseif (n == 0)
		result = exp(-x)/x;
	elseif (x == 0.0)
		result = 1.0/nm1; % strangy: what is nm1?
	elseif (x > 1.0)
		b = x + n;
		c = 1.0 / FPMIN;
		d = 1.0 / b;
		h = d;
		for i=1 : MAXIT
			a = -i * (nm1 + i);
			b = b + 2.0;
			d = 1.0 / (a*d+b);
			c = b + a / c;
			del = c * d;
			h = h * del;
			if (abs(del-1.0) < EPS) % abs is fabs in C
				result = h * exp(-x);
				return;
			end
		end
		disp('continuated fraction failed in expint');
	else
		% ans = (nm1!=0 ? 1.0/nm1 : -log(x)-EULER);
		% is interpreted as follows
		if (nm1 ~= 0)
			result = 1.0 / nm1;
		else
			result = -log(x)-EULER;
		end
		fact = 1.0;
		for i = 1 : MAXIT
			fact = fact * (-x / i);
			if (i ~= nm1)
				del = -fact / (i - nm1);
			else
				psi = -EULER;
				for ii = 1 : nm1
					psi = psi + (1/ii);
				end
				del = fact * (-log(x) + psi);
			end
			result = result + del;
			if (abs(del) < abs(result) * EPS) % abs is fabs in C
				return;
			end
		end
		disp('series failed in expint');
	end
end