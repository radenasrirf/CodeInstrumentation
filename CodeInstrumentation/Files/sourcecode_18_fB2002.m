function a = findBueno2002(numbersIn)
	f = numbersIn(1); % key or index
	a = numbersIn(2:end); % an array of integers to be re-arranged
	% n = length(numbers);
	b = 0;
	m = 1;
	ns = length(a);
	% Probe added on 02.09.2010
	if f > ns
		f = mod(ns,f);
	end
	i = 1;
	while ((m < ns) || b)
		if (~b)
			i = m;
			j = ns;
		else
			b = 0;
		end
		if (i > j)
			if (f > j)
				if (i > f)
				m = ns;
				else
				m = i;
				end
			else
				ns = j;
			end
		else
			while (a(i) < a(f))
				i = i + 1 
			end
			while (a(f) < a(j))
				j = j - 1 ;
			end
			if (i <= j)
				w = a(i);
				a(i) = a(j);
				a(j) = w;
				i = i + 1;
				j = j - 1;
			end
			b = 1;
		end
	end
end