{$H+}
uses math;
Const
	inp = 'command.inp';
	out = 'command.out';

Var
	s : string;
	d,i,x,y : longint;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	while not seekeof(input) do
	  begin
	  	d := 1;
	  	x := 0; y := 0;
	  	repeat
	  		readln(s);
	  		if s = '[END]' then halt;
	  		if s = '>>' then
	  		  begin
	  		  	if (d = 1) and ((x<>0) or (y<>0)) then writeln('unbounded')
	  		  	 else writeln('bounded');
	  		  	readln;
	  		  	break;
	  		  end;
	  		if (s <> '[CASE]') and (s<>'<<') then
	  		  begin
	  		  	for i := 1 to length(s) do
                 begin
	  		  	 	if s[i] = 'L' then dec(d)
	  		  	  		else if s[i]='R' then inc(d)
	  		  	  		 else begin
	  		  	  		 	if d=1 then inc(y);
	  		  	  		 	if d=2 then inc(x);
	  		  	  		 	if d=3 then dec(y);
	  		  	  		 	if d=4 then dec(x);
	  		  	  		 end;
	  		  		if d < 1 then d := 4
	  		  	 		else if d > 4 then d := 1;
                 end;
	  		  end;
	  	until false;
	  end;
end.
