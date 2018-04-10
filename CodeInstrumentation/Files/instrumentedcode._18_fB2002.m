function [traversedPath,a] = findBueno2002(numbersIn)
traversedPath = [];
traversedPath = [traversedPath '1 ' ];
	f = numbersIn(1); % key or index
	a = numbersIn(2:end); % an array of integers to be re-arranged
	% n = length(numbers);
	b = 0;
	m = 1;
	ns = length(a);
	% Probe added on 02.09.2010
	% instrument Branch # 1
	traversedPath = [traversedPath '2 ' ];
	if f > ns
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '3 ' ];
		f = mod(ns,f);
	end
	i = 1;
	% instrument Branch # 2
	traversedPath = [traversedPath '4 ' ];
	while ((m < ns) || b)
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 3
		traversedPath = [traversedPath '5 ' ];
		if (~b)
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '6 ' ];
			i = m;
			j = ns;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '7 ' ];
			b = 0;
		end
		% instrument Branch # 4
		traversedPath = [traversedPath '8 ' ];
		if (i > j)
			traversedPath = [traversedPath '(T) ' ];
			% instrument Branch # 5
			traversedPath = [traversedPath '9 ' ];
			if (f > j)
				traversedPath = [traversedPath '(T) ' ];
				% instrument Branch # 6
				traversedPath = [traversedPath '10 ' ];
				if (i > f)
				traversedPath = [traversedPath '(T) ' ];
				traversedPath = [traversedPath '11 ' ];
				m = ns;
				else
				traversedPath = [traversedPath '(F) ' ];
				traversedPath = [traversedPath '12 ' ];
				m = i;
				end
			else
				traversedPath = [traversedPath '(F) ' ];
				traversedPath = [traversedPath '14 ' ];
				ns = j;
			traversedPath = [traversedPath '15 ' ];
			end
		else
			traversedPath = [traversedPath '(F) ' ];
			% instrument Branch # 8
			traversedPath = [traversedPath '15 ' ];
			while (a(i) < a(f))
				traversedPath = [traversedPath '(T) ' ];
				traversedPath = [traversedPath '16 ' ];
				i = i + 1 
			end
			% instrument Branch # 7
			traversedPath = [traversedPath '13 ' ];
			traversedPath = [traversedPath '(F) ' ];
			while (a(f) < a(j))
				traversedPath = [traversedPath '(T) ' ];
				traversedPath = [traversedPath '17 ' ];
				j = j - 1 ;
			traversedPath = [traversedPath '13 ' ];
			end
			traversedPath = [traversedPath '(F) ' ];
			% instrument Branch # 9
			traversedPath = [traversedPath '18 ' ];
			if (i <= j)
				traversedPath = [traversedPath '(T) ' ];
				traversedPath = [traversedPath '19 ' ];
				w = a(i);
				a(i) = a(j);
				a(j) = w;
				i = i + 1;
				j = j - 1;
			end
			b = 1;
		end
		traversedPath = [traversedPath '20 ' ];
	traversedPath = [traversedPath '4 ' ];
	end
traversedPath = [traversedPath '(F) ' ];
traversedPath = [traversedPath '21 ' ];
end
