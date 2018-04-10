function pop = flexGong2011(depop) <b style='color:red'>Node 1</b>
	[px,py]=size(depop);
	for i=1:px % Branch # 1 <b style='color:red'>Node 2</b>
		q=1;
		p=depop(i,:);
		lex_compat=p(1);
		C_plus_plus=p(2);
		fulltbl=p(3);
		csize =p(4);
		unspecified=p(5);
		fullspd=p(6);
		C_plus=p(7);
		d(1,1)=2;
		d(1,1)=1-1.001^(-d(1,1));
		d(1,2)=lex_compat;
		d(1,2)=1-1.001^(-d(1,2));
		d(1,3)=0;
		d(2,1)=2;
		d(2,1)=1-1.001^(-d(2,1));
		d(2,2)=C_plus_plus;
		d(2,2)=1-1.001^(-d(2,2));
		d(2,3)=0;
		d(3,1)=2;
		d(3,1)=1-1.001^(-d(3,1));
		d(3,2)=fulltbl;
		d(3,2)=1-1.001^(-d(3,2));
		d(3,3)=0;
		d(4,1)=abs( csize-unspecified)+2;
		d(4,1)=1-1.001^(-d(4,1));
		d(4,2)=2;
		d(4,2)=1-1.001^(-d(4,2));
		d(4,3)=0;
		d(5,1)=2;
		d(5,1)=1-1.001^(-d(5,1));
		d(5,2)=fullspd;
		d(5,2)=1-1.001^(-d(5,2));
		d(5,3)=0;
		d(6,1)=2;
		d(6,1)=1-1.001^(-d(5,1));
		d(6,2)=C_plus;
		d(6,2)=1-1.001^(-d(5,2));
		d(5,3)=0;
		u=3*ones(1,6);
		if (lex_compat ~= 0) % Branch # 2 <b style='color:red'>Node 3</b>
			d(1,1)=0;
			u(1)=1;
			if (C_plus_plus ~= 0) % Branch # 3 <b style='color:red'>Node 4</b>
				flexerror = 'Can not use -+ with -l option'; <b style='color:red'>Node 5</b>
				d(2,1)=0;
			else
				d(2,2)=0; <b style='color:red'>Node 6</b>
			end
			if (fulltbl ~= 0) % Branch # 4 <b style='color:red'>Node 7</b>
				flexerror='Can not use -f or -F with -l option'; <b style='color:red'>Node 8</b>
				d(3,1)=0;
			else
				d(3,2)=0; <b style='color:red'>Node 9</b>
			end
		else
			d(1,2)=0; <b style='color:red'>Node 11</b>
		end
		if (csize == unspecified) % Branch # 5 <b style='color:red'>Node 10</b>
			d(4,1)=0;
			if (fullspd ~= 0) % Branch # 6 <b style='color:red'>Node 12</b>
				csize = 'DEFAULT_CSIZE'; <b style='color:red'>Node 13</b>
				d(5,1)=0;
			else
				d(5,2)=0; <b style='color:red'>Node 14</b>
				csize = csize;
			end
		else
			d(4,2)=0; <b style='color:red'>Node 16</b>
		end
	if (C_plus ~= 0) % Branch # 7 <b style='color:red'>Node 15</b>
		suffix='cc'; <b style='color:red'>Node 17</b>
		d(6,1)=0;
	else
		d(6,2)=0; <b style='color:red'>Node 18</b>
		suffix='c';
		outfilename = 'outfile_path';
	end <b style='color:red'>Node 19</b>
	pop(i,:) = p;
end <b style='color:red'>Node 20</b>
