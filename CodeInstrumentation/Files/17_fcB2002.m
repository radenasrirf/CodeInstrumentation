function result = floatcompBueno2002(floats)
	f1 = floats(1); % First number
	f2 = floats(2); % Second number
	f3 = floats(3); % Third number
	result = ' ';
	if (f3 > f2) % B1
		if (f2 > f1) % B2
			result = 'f3 > f2 > f1';
			t = f1 + f2;
			if (t < f3)
				result = 'f3 > f1 + f2';
				t2 = f1 * f2;
				if (((t2 - f3) <= 5) && ((t2 - f3) >= 0))
					result = '(((f1 * f2) - f3) <= 5) && (((f1 * f2) - f3) >= 0))';
				end
			else
				result = 'f3 <= f1 + f2';
			end
		end
	end
end