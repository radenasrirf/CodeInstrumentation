function [traversedPath,result] = floatcompBueno2002(floats)
traversedPath = [];
traversedPath = [traversedPath '1 ' ];
	f1 = floats(1); % First number
	f2 = floats(2); % Second number
	f3 = floats(3); % Third number
	result = ' ';
	% instrument Branch # 1
	traversedPath = [traversedPath '2 ' ];
	if (f3 > f2) % B1
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 2
		traversedPath = [traversedPath '3 ' ];
		if (f2 > f1) % B2
			result = 'f3 > f2 > f1';
			t = f1 + f2;
			traversedPath = [traversedPath '(T) ' ];
			% instrument Branch # 3
			traversedPath = [traversedPath '4 ' ];
			if (t < f3)
				result = 'f3 > f1 + f2';
				t2 = f1 * f2;
				traversedPath = [traversedPath '(T) ' ];
				% instrument Branch # 4
				traversedPath = [traversedPath '5 ' ];
				if (((t2 - f3) <= 5) && ((t2 - f3) >= 0))
					traversedPath = [traversedPath '(T) ' ];
					traversedPath = [traversedPath '6 ' ];
					result = '(((f1 * f2) - f3) <= 5) && (((f1 * f2) - f3) >= 0))';
				end
			else
				traversedPath = [traversedPath '(F) ' ];
				traversedPath = [traversedPath '8 ' ];
				result = 'f3 <= f1 + f2';
			end
		end
	end
traversedPath = [traversedPath '7 ' ];
end
