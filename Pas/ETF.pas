Uses math;
Const
	inp = 'etf.inp';
	out = 'etf.out';
	maxn = 1000001;

Var
	p,f : array [1..maxn] of longint;
	i,ntest,n,j,x,k : longint;
	z : extended;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	for i := 1 to maxn do p[i] := i;
	for i := 2 to trunc(sqrt(maxn)) do
	 if p[i]=i then
	  begin
	  	 j := i*i;
	  	 while j <= maxn do
	  	   begin
	  	   	  p[j] := i;
	  	   	  j := j+i;
	  	   end;
	  end;
	f[1] := 1;
	for i := 2 to maxn do
	  begin
	  	 j := i;
	  	 k := p[i];
	  	 while j mod k=0 do j := j div k;
	  	 f[i] := f[j]*(i div j - i div j div k);
	  end;
	while ntest > 0 do
	  begin
	  	dec(ntest);
	  	readln(n);
	  	writeln(f[n]);
	  end;
end.
