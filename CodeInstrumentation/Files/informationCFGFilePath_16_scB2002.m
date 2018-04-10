function result = strcompBueno2002(strin) <b style='color:red'>Node 1</b>
	result = ' ';
	i = 1;
	% strin is an array of integers (double) with length 8.
	str = char(strin);
	while ((str(i) ~= ' ') && (i <= 5)) <b style='color:red'>Node 2</b>
		i = i + 1; <b style='color:red'>Node 3</b>
	end
	if (~strcmp(str(1:5),'test1')) <b style='color:red'>Node 4</b>
		if (str(6) == 'a') <b style='color:red'>Node 5</b>
			if (str(7) == 'b') <b style='color:red'>Node 6</b>
				if (str(8) < 'c') <b style='color:red'>Node 7</b>
					result = 'Gotcha'; <b style='color:red'>Node 8</b>
				end
			end
		end
	end
end <b style='color:red'>Node 9</b>
