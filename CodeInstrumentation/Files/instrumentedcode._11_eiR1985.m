function [traversedPath,Z] = expintRapps1985(integers)
traversedPath = [];
traversedPath = [traversedPath '1 ' ];
	X = integers(1);
	Y = integers(2);
	% instrument Branch # 1
	traversedPath = [traversedPath '2 ' ];
	if (Y >= 0)
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '3 ' ];
		power = Y;
	else
		traversedPath = [traversedPath '(F) ' ];
		traversedPath = [traversedPath '4 ' ];
		power = -Y;
	end
	Z = 1;
	% instrument Branch # 2
	traversedPath = [traversedPath '5 ' ];
	while (power ~= 0)
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '6 ' ];
		Z = Z * X;
		power = power - 1;
	traversedPath = [traversedPath '5 ' ];
	end
	traversedPath = [traversedPath '(F) ' ];
	% instrument Branch # 3
	traversedPath = [traversedPath '7 ' ];
	if (Y < 0)
		traversedPath = [traversedPath '(T) ' ];
		traversedPath = [traversedPath '8 ' ];
		Z = 1 / Z; % this is the original one; by removing if TRUE
	end
	Z = Z + 1;
traversedPath = [traversedPath '9 ' ];
end
