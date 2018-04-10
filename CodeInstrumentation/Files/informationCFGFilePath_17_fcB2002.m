function result = floatcompBueno2002(floats) <b style='color:red'>Node 1</b>
	f1 = floats(1); % First number
	f2 = floats(2); % Second number
	f3 = floats(3); % Third number
	result = ' ';
	if (f3 > f2) % B1 <b style='color:red'>Node 2</b>
		if (f2 > f1) % B2 <b style='color:red'>Node 3</b>
			result = 'f3 > f2 > f1';
			t = f1 + f2;
			if (t < f3) <b style='color:red'>Node 4</b>
				result = 'f3 > f1 + f2';
				t2 = f1 * f2;
				if (((t2 - f3) <= 5) && ((t2 - f3) >= 0)) <b style='color:red'>Node 5</b>
					result = '(((f1 * f2) - f3) <= 5) && (((f1 * f2) - f3) >= 0))'; <b style='color:red'>Node 6</b>
				end
			else
				result = 'f3 <= f1 + f2'; <b style='color:red'>Node 8</b>
			end
		end
	end
end <b style='color:red'>Node 7</b>
