function Z = expintRapps1985(integers) <b style='color:red'>Node 1</b>
	X = integers(1);
	Y = integers(2);
	if (Y >= 0) <b style='color:red'>Node 2</b>
		power = Y; <b style='color:red'>Node 3</b>
	else
		power = -Y; <b style='color:red'>Node 4</b>
	end
	Z = 1;
	while (power ~= 0) <b style='color:red'>Node 5</b>
		Z = Z * X; <b style='color:red'>Node 6</b>
		power = power - 1;
	end
	if (Y < 0) <b style='color:red'>Node 7</b>
		Z = 1 / Z; % this is the original one; by removing if TRUE <b style='color:red'>Node 8</b>
	end
	Z = Z + 1;
end <b style='color:red'>Node 9</b>
