Uses math;
Const
	inp = 'bomb.inp';
	out = 'bomb.out';
	maxn = 501;
	oo = -999999999999999;

Var
	m,n,i,j : longint;
	a,b,c : array [0..maxn,0..maxn] of longint;
	res : int64;

procedure nhap;
	var i,j : longint;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(m,n);
	for i := 1 to m do
	  for j := 1 to n do read(a[i,j]);
end;

procedure init;
	var i,j : longint;
begin
	for i := 1 to m do
	  for j := 1 to n do
	    begin
	    	b[i,j] := b[i-1,j-1]+a[i,j];
	    	c[i,j] := c[i-1,j+1]+a[i,j];
	    end;
end;

procedure main();
	var i,j,k,u1,v1,u2,v2,u3,v3,u4,v4 : longint;
		sum : int64;
begin
	res := oo;
	for i := 1 to m do
	  for j := 1 to n do
	    begin
	    	sum := a[i,j];
	    	res := max(sum,res);
	    	for k := 1 to min(m,n) do
	    	  begin
	    	  	if (i+k>m) or (i-k<=0) or (j+k>n) or (j-k<=0) then break;
	    	  	sum := sum + b[i,j+k]-b[i-k-1,j-1]+b[i+k,j]-b[i-1,j-k-1]
	    	  	           + c[i,j-k]-c[i-k-1,j+1]+c[i+k,j]-c[i-1,j+k+1]
                           -a[i-k,j]-a[i,j+k]-a[i+k,j]-a[i,j-k];
	    	  	res := max(res,sum);
	    	  end;
	    end;
	writeln(res);
end;

begin
	nhap;
	init;
	main;
end.
