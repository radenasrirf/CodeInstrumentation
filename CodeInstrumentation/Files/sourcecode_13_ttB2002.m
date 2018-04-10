function [type, area] = tritypeBueno2002(side)
	a = side(1);
	b = side(2);
	c = side(3);
	if ((a < b) || (b < c))
		type = 'Invalid input. Input must be ordered a >= b >= c';
		area = 0;
	elseif ( a >= (b + c) )
		type = 'Not a triangle';
		area = 0;
	elseif ( (a ~= b) && (b ~= c) ) % /* escaleno */
		as = a*a;
		bs = b*b;
		cs = c*c
		if (as == bs + cs) % /* retangulo */
			type = 'Rectangle';
			area = b * c / 2.0;
		else
			s = (a+b+c) / 2.0;
			area = sqrt(s*(s-a)*(s-b)*(s-c));
			if ( as < bs + cs )
				type = 'Agudo'; % /* agudo */
			else
				type ='Obtuso'; % /* obtuso */
			end
		end
	elseif ( (a == b) && (b == c) )
		type = 'Equilateral'; % /* equilatero */
		area = a*a*sqrt(3.0)/4.0;
	else
		type = 'Isosceles'; % /* isoceles */
		if ( a == b )
			area = c*sqrt(4*a*b-c*c)/4;
		else
			area = a*sqrt(4*b*c-a*c)/4;
		end
	end
end