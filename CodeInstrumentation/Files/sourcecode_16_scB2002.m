function result = strcompBueno2002(strin)
	result = ' ';
	i = 1;
	% strin is an array of integers (double) with length 8.
	str = char(strin);
	while ((str(i) ~= ' ') && (i <= 5))
		i = i + 1;
	end
	if (~strcmp(str(1:5),'test1'))
		if (str(6) == 'a')
			if (str(7) == 'b')
				if (str(8) < 'c')
					result = 'Gotcha';
				end
			end
		end
	end
end