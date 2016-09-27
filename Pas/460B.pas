Uses math;
Const
	inp = 'asd.inp';
	out = 'asd.out';
	maxn = 1000000;

Var
	a,b,c,x,j : int64;
	i,k,top,dem : longint;
	st : array [1..maxn] of longint;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(a,b,c);
	i := 0;
	repeat
		inc(i);
        if i > 9*9 then break;
		j := 1;
		for k := 1 to a do j := j*i;
		j := b*j+c; x := j;
		if j >= 1000000000 then break;
		if j > 0 then
		  begin
		  	 dem := 0;
		  	 while j <> 0 do
		  	   begin
		  	   	 inc(dem,j mod 10);
		  	   	 j := j div 10;
		  	   end;
		  	 if dem = i then
		  	   begin
		  	   	inc(top); st[top] := x;
		  	   end;
		  end;
	until false;
	writeln(top);
	for i := 1 to top do write(st[i],' ');
end.
