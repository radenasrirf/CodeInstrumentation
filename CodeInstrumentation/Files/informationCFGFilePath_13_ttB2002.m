function [type, area] = tritypeBueno2002(side) <b style='color:red'>Node 1</b>
	a = side(1);
	b = side(2);
	c = side(3);
	if ((a < b) || (b < c)) <b style='color:red'>Node 2</b>
		type = 'Invalid input. Input must be ordered a >= b >= c'; <b style='color:red'>Node 3</b>
		area = 0;
	elseif ( a >= (b + c) )
		type = 'Not a triangle'; <b style='color:red'>Node 4</b>
		area = 0;
	elseif ( (a ~= b) && (b ~= c) ) % /* escaleno */
		as = a*a;
		bs = b*b;
		cs = c*c
		if (as == bs + cs) % /* retangulo */ <b style='color:red'>Node 5</b>
			type = 'Rectangle'; <b style='color:red'>Node 6</b>
			area = b * c / 2.0;
		else
			s = (a+b+c) / 2.0;
			area = sqrt(s*(s-a)*(s-b)*(s-c));
			if ( as < bs + cs ) <b style='color:red'>Node 7</b>
				type = 'Agudo'; % /* agudo */ <b style='color:red'>Node 8</b>
			else
				type ='Obtuso'; % /* obtuso */ <b style='color:red'>Node 9</b>
			end
		end <b style='color:red'>Node 10</b>
	elseif ( (a == b) && (b == c) )
		type = 'Equilateral'; % /* equilatero */ <b style='color:red'>Node 11</b>
		area = a*a*sqrt(3.0)/4.0;
	else
		type = 'Isosceles'; % /* isoceles */
		if ( a == b ) <b style='color:red'>Node 12</b>
			area = c*sqrt(4*a*b-c*c)/4; <b style='color:red'>Node 13</b>
		else
			area = a*sqrt(4*b*c-a*c)/4; <b style='color:red'>Node 14</b>
		end
	end
end <b style='color:red'>Node 15</b>
