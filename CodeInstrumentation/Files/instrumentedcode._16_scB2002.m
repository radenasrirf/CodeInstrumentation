function [traversedPath,result] = strcompBueno2002(strin)
traversedPath = [];
traversedPath = [traversedPath '1 ' ];
	result = ' ';
	i = 1;
	% strin is an array of integers (double) with length 8.
	str = char(strin);
	% instrument Branch # 1
	traversedPath = [traversedPath '2 ' ];
	while ((str(i) ~= ' ') && (i <= 5))
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '3 ' ];
		i = i + 1;
	traversedPath = [traversedPath '2 ' ];
	end
	traversedPath = [traversedPath '(F) ' ];
	% instrument Branch # 2
	traversedPath = [traversedPath '4 ' ];
	if (~strcmp(str(1:5),'test1'))
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 3
		traversedPath = [traversedPath '5 ' ];
		if (str(6) == 'a')
			traversedPath = [traversedPath '(T) ' ];
			% instrument Branch # 4
			traversedPath = [traversedPath '6 ' ];
			if (str(7) == 'b')
				traversedPath = [traversedPath '(T) ' ];
				% instrument Branch # 5
				traversedPath = [traversedPath '7 ' ];
				if (str(8) < 'c')
					traversedPath = [traversedPath '(T) ' ];
					traversedPath = [traversedPath '8 ' ];
					result = 'Gotcha';
				end
			end
		end
	end
traversedPath = [traversedPath '9 ' ];
end
