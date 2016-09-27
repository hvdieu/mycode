Uses math;
const
	inp = 'lcs2x.inp';
	out = 'lcs2x.in1';
	maxn = 1501;

Var
	n,i,j,x,k,ntest,m : longint;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	writeln(1);
	readln(ntest);
	for k := 1 to ntest do
	  begin
	    readln(m,n);
	  	if k=38 then
	  	  begin
	  	  	writeln(m,' ',n);
	  	  	for i := 1 to m do
	  	  	  begin
	  	  	  	read(x); write(x,' ');
	  	  	  end;
            writeln;
	  	  	for i := 1 to n do
	  	  	  begin
	  	  	  	read(x); write(x,' ');
	  	  	  end;
	  	  end
	  	else for i := 1 to m+n do read(x);
	  end;
end.
