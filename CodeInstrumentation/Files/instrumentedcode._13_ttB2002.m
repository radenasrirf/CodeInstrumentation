function [traversedPath,type, area] = tritypeBueno2002(side)
traversedPath = [];
traversedPath = [traversedPath '1 ' ];
	a = side(1);
	b = side(2);
	c = side(3);
	% instrument Branch # 1
	traversedPath = [traversedPath '2 ' ];
	if ((a < b) || (b < c))
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '3 ' ];
		type = 'Invalid input. Input must be ordered a >= b >= c';
		area = 0;
	elseif ( a >= (b + c) )
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '4 ' ];
		type = 'Not a triangle';
		area = 0;
	elseif ( (a ~= b) && (b ~= c) ) % /* escaleno */
		as = a*a;
		bs = b*b;
		cs = c*c
		traversedPath = [traversedPath '(T) ' ];
		% instrument Branch # 2
		traversedPath = [traversedPath '5 ' ];
		if (as == bs + cs) % /* retangulo */
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '6 ' ];
			type = 'Rectangle';
			area = b * c / 2.0;
		else
			s = (a+b+c) / 2.0;
			area = sqrt(s*(s-a)*(s-b)*(s-c));
			traversedPath = [traversedPath '(F) ' ];
			% instrument Branch # 3
			traversedPath = [traversedPath '7 ' ];
			if ( as < bs + cs )
				traversedPath = [traversedPath '(T) ' ];
				traversedPath = [traversedPath '8 ' ];
				type = 'Agudo'; % /* agudo */
			else
				traversedPath = [traversedPath '(F) ' ];
				traversedPath = [traversedPath '9 ' ];
				type ='Obtuso'; % /* obtuso */
			end
		traversedPath = [traversedPath '10 ' ];
		end
	elseif ( (a == b) && (b == c) )
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '11 ' ];
		type = 'Equilateral'; % /* equilatero */
		area = a*a*sqrt(3.0)/4.0;
	else
		type = 'Isosceles'; % /* isoceles */
		traversedPath = [traversedPath '(F) ' ];
		% instrument Branch # 4
		traversedPath = [traversedPath '12 ' ];
		if ( a == b )
			traversedPath = [traversedPath '(T) ' ];
			traversedPath = [traversedPath '13 ' ];
			area = c*sqrt(4*a*b-c*c)/4;
		else
			traversedPath = [traversedPath '(F) ' ];
			traversedPath = [traversedPath '14 ' ];
			area = a*sqrt(4*b*c-a*c)/4;
		end
	end
traversedPath = [traversedPath '15 ' ];
end
