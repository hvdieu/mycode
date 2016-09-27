Uses math;
Const
	inp = 'asd.inp';
	out = 'asd.out';
	maxn = 1001;

Var
	n,s,i,dem,prev : longint;
	x,y : array [1..maxn] of longint;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(s,n);
	for i := 1 to n do read(x[i],y[i]);
	repeat
		prev := dem;
		for i := 1 to n do
		  if s > x[i] then
		    begin
		    	s := s+y[i];
		    	x[i] := maxlongint;
		    	inc(dem);
		    end;
		if dem=prev then break;
	until false;
	if dem=n then writeln('YES') else writeln('NO');
end.
