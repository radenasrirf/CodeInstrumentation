function [traversedPath,result] = expintBueno2002(numbersIn)
traversedPath = [];
traversedPath = [traversedPath '1 ' ];
	n = numbersIn(1); % integer
	x = numbersIn(2); % floa
	MAXIT = 100;
	EULER = 0.5772156649;
	FPMIN = 1.0e-30;
	EPS = 1.0e-7;
	nm1 = n - 1;
	% instrument Branch # 1
	traversedPath = [traversedPath '2 ' ];
	if (n < 0 || x < 0.0 || (x == 0.0 && (n == 0.0 || n==1)))
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '3 ' ];
		result = 0;
		% disp('bad arguments in expintBueno2002');
	elseif (n == 0)
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '4 ' ];
		result = exp(-x)/x;
	elseif (x == 0.0)
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '5 ' ];
		result = 1.0/nm1; % strangy: what is nm1?
	elseif (x > 1.0)
		b = x + n;
		c = 1.0 / FPMIN;
		d = 1.0 / b;
		h = d;
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 2
		traversedPath = [traversedPath '6 ' ];
		for i=1 : MAXIT
			a = -i * (nm1 + i);
			b = b + 2.0;
			d = 1.0 / (a*d+b);
			c = b + a / c;
			del = c * d;
			h = h * del;
			traversedPath = [traversedPath '(T) ' ];
			% instrument Branch # 3
			traversedPath = [traversedPath '7 ' ];
			if (abs(del-1.0) < EPS) % abs is fabs in C
				traversedPath = [traversedPath '(T) ' ];
				traversedPath = [traversedPath '8 ' ];
				result = h * exp(-x);
				return;
			end
			traversedPath = [traversedPath '9 ' ];
		traversedPath = [traversedPath '6 ' ];
		traversedPath = [traversedPath '14 ' ];
		end
		disp('continuated fraction failed in expint');
	else
		% ans = (nm1!=0 ? 1.0/nm1 : -log(x)-EULER);
		% is interpreted as follows
		traversedPath = [traversedPath '(F) ' ];
		% instrument Branch # 4
		traversedPath = [traversedPath '11 ' ];
		if (nm1 ~= 0)
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '12 ' ];
			result = 1.0 / nm1;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '13 ' ];
			result = -log(x)-EULER;
		end
		fact = 1.0;
		% instrument Branch # 5
		traversedPath = [traversedPath '14 ' ];
		for i = 1 : MAXIT
			fact = fact * (-x / i);
			traversedPath = [traversedPath '(T) ' ];
			% instrument Branch # 6
			traversedPath = [traversedPath '15 ' ];
			if (i ~= nm1)
				traversedPath = [traversedPath '(T) ' ];
				traversedPath = [traversedPath '16 ' ];
				del = -fact / (i - nm1);
			else
				psi = -EULER;
				traversedPath = [traversedPath '(F) ' ];
				% instrument Branch # 7
				traversedPath = [traversedPath '17 ' ];
				for ii = 1 : nm1
					traversedPath = [traversedPath '(T) ' ];
					traversedPath = [traversedPath '18 ' ];
					psi = psi + (1/ii);
				traversedPath = [traversedPath '17 ' ];
				end
				del = fact * (-log(x) + psi);
			end
			result = result + del;
			traversedPath = [traversedPath '(F) ' ];
			% instrument Branch # 8
			traversedPath = [traversedPath '19 ' ];
			if (abs(del) < abs(result) * EPS) % abs is fabs in C
				traversedPath = [traversedPath '(T) ' ];
				traversedPath = [traversedPath '20 ' ];
				return;
			end
			traversedPath = [traversedPath '21 ' ];
		end
		disp('series failed in expint');
	end
traversedPath = [traversedPath '(F) ' ];
traversedPath = [traversedPath '10 ' ];
end
