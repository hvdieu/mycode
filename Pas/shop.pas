Uses math;
Const
	inp = 'shop.in';
	out = 'shop.out';
	maxn = 501;

Var
	n,i,nn,ntest,res,j : longint;
	a : array [1..maxn] of longint;
	f,g : array [0..maxn,0..maxn] of longint;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	for nn := 1 to ntest do
	  begin
	  	write('Spree #',nn,': ');
	  	read(n);
	  	for i := 1 to n do read(a[i]);
	  	fillchar(f,sizeof(f),0);
	  	fillchar(g,sizeof(g),0);
	  	f[1,1] := a[1]; g[1,1] := a[1];
	  	for i := 2 to n do
	  	 for j := 1 to i do
	  	  begin
	  	  	f[i,j] := max(g[i-1,min(i div 2-1,j-1)]+a[i],f[i-1,j]);
	  	  	g[i,j] := max(g[i-1,j],f[i,j]);
	  	  end;
	  	if n=1 then writeln(a[1])
         else writeln(g[n,n div 2]);
	  end;
end.
