Uses math;
Const
	inp = 'TELEWIRE.INP';
	out = 'TELEWIRE.OUT';
	maxn = 100001;
	maxm = 101;
	oo = 999999999;

Var
	i,j,n,c,tg,res : longint;
	a : array [1..maxn] of longint;
	f,g,h : array [1..maxn,0..maxm] of longint;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,c);
	for i := 1 to n do read(a[i]);
	for i := 1 to n do
	  for j := 0 to 101 do
	   begin
	     f[i,j] := oo;
	     g[i,j] := oo;
	     h[i,j] := oo;
	   end;
	for j := a[1] to 100 do f[1,j] := sqr(j-a[1]);
	for j := 1 to 100 do g[1,j] := min(g[1,j-1],f[1,j]-j*c);
	for j := 100 downto 1 do h[1,j] := min(h[1,j+1],f[1,j]+j*c);
	for i := 2 to n do
	  begin
	  	 for j := a[i] to 100 do
	  	   begin
	  	      tg := min(g[i-1,j]+sqr(a[i]-j)+j*c,h[i-1,j]+sqr(a[i]-j)-j*c);
	  	   	  f[i,j] := min(f[i,j],tg);
	  	   end;
         for j := 1 to 100 do g[i,j] := min(g[i,j-1],f[i,j]-j*c);
	  	 for j := 100 downto 1 do h[i,j] := min(h[i,j+1],f[i,j]+j*c);
	  end;
	res := oo;
	for j := a[n] to 100 do res := min(res,f[n,j]);
	writeln(res);
end.
