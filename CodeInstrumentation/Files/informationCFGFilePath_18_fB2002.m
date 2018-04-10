function a = findBueno2002(numbersIn) <b style='color:red'>Node 1</b>
	f = numbersIn(1); % key or index
	a = numbersIn(2:end); % an array of integers to be re-arranged
	% n = length(numbers);
	b = 0;
	m = 1;
	ns = length(a);
	% Probe added on 02.09.2010
	if f > ns <b style='color:red'>Node 2</b>
		f = mod(ns,f); <b style='color:red'>Node 3</b>
	end
	i = 1;
	while ((m < ns) || b) <b style='color:red'>Node 4</b>
		if (~b) <b style='color:red'>Node 5</b>
			i = m; <b style='color:red'>Node 6</b>
			j = ns;
		else
			b = 0; <b style='color:red'>Node 7</b>
		end
		if (i > j) <b style='color:red'>Node 8</b>
			if (f > j) <b style='color:red'>Node 9</b>
				if (i > f) <b style='color:red'>Node 10</b>
				m = ns; <b style='color:red'>Node 11</b>
				else
				m = i; <b style='color:red'>Node 12</b>
				end
			else
				ns = j; <b style='color:red'>Node 14</b>
			end
		else
			while (a(i) < a(f)) <b style='color:red'>Node 15</b>
				i = i + 1  <b style='color:red'>Node 16</b>
			end
			while (a(f) < a(j)) <b style='color:red'>Node 13</b>
				j = j - 1 ; <b style='color:red'>Node 17</b>
			end
			if (i <= j) <b style='color:red'>Node 18</b>
				w = a(i); <b style='color:red'>Node 19</b>
				a(i) = a(j);
				a(j) = w;
				i = i + 1;
				j = j - 1;
			end
			b = 1;
		end <b style='color:red'>Node 20</b>
	end
end <b style='color:red'>Node 21</b>
