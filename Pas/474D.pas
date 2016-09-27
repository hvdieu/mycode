uses math;
const
	inp = '474D.INP';
	out = '474D.out';
	maxn = 100010;
	M = 1000000007;

Var
	n,ntest,k,i,a,b : longint;
	f : array [0..maxn,0..1] of int64;
	g : array [0..maxn] of int64;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest,k);
	f[1][0] := 1;
    if k=1 then f[1][1] := 1 else f[1][1] := 0;
	f[0][1] := 1;
	g[1] := f[1][1]+f[1][0];
	g[0] := 0;
	for i := 2 to 100000 do
	  begin
	  	f[i][0] := (f[i-1][0] + f[i-1][1]) mod M;
	  	if i >= k then f[i][1] := (f[i][1] + f[i-k][1] + f[i-k][0]) mod M;
	  	g[i] := (f[i][0] + f[i][1] + g[i-1]) mod M;
	  end;
	while ntest > 0 do
	  begin
        dec(ntest);
	  	readln(a,b);
	  	writeln((g[b]-g[a-1]+M) mod M);
	  end;
end.
