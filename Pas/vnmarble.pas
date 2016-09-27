Uses math;
Const
	inp = 'vmmarble.inp';
	out = 'vnmarble.out';
	maxn = 1001;
	maxm = 11;
	oo = 100000000000000000;

Var
	n,m,k,i,j : longint;
	a : array [1..maxn,1..maxm] of longint;
	sum : array [1..maxn] of longint;
	f : array [0..maxn,0..1025] of int64;

procedure sub1;
	var i,j,tt,x : longint;
begin
	for i := 1 to n do
	  for j := 1 to m do inc(sum[i],a[i,j]);
	for i := 0 to n do
	 for j := 0 to 1 shl m-1 do f[i,j] := oo;
	f[0,0] := 0;
	for i := 1 to n do
	 for tt := 1 to 1 shl m-1 do
	  for j := 1 to m do
	   if (tt shr (j-1)) and 1 = 1 then
	    begin
	    	x := tt and (not (1 shl (j-1)));
	    	f[i,tt] := min(f[i,tt],min(f[i-1,tt],f[i-1,x])+sum[i]-a[i,j]);
	    end;
	writeln(f[n,1 shl m-1]);
end;

procedure sub2;
	var i,j,tt,x,k,cp : longint;
begin
	for i := 1 to n do
	  for j := 1 to m do inc(sum[i],a[i,j]);
	for i := 0 to n do
	 for j := 0 to 1 shl m-1 do f[i,j] := oo;
	f[0,0] := 0;
	for i := 1 to n do
	  for tt := 1 to 1 shl m-1 do
	   for j := 1 to m do
	    if (tt shr (j-1)) and 1 = 1 then
	     begin
	     	x := tt and (not (1 shl (j-1)));
	     	cp := 0;
	     	for k := 1 to m do
	     	 if k <> j then inc(cp,(a[i,k]+1) div 2);
	     	f[i,tt] := min(f[i,tt],min(f[i-1,tt],f[i-1,x])+cp);
	     end;
	writeln(f[n,1 shl m-1]);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m,k);
	for i := 1 to n do
	  for j := 1 to m do read(a[i,j]);
	if (k=1) then sub1
	 else sub2;
end.
