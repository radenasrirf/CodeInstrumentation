function Z = expintRapps1985(integers)
	X = integers(1);
	Y = integers(2);
	if (Y >= 0)
		power = Y;
	else
		power = -Y;
	end
	Z = 1;
	while (power ~= 0)
		Z = Z * X;
		power = power - 1;
	end
	if (Y < 0)
		Z = 1 / Z; % this is the original one; by removing if TRUE
	end
	Z = Z + 1;
end
