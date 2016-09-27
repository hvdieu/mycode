Uses math;
Const 
	inp = 'CTNCLN.INP';
	out = 'CTNCLN.OUT';
	maxn = 40001;
	maxm = 201;

Var
	n,m : longint;
	a : array [1..maxn] of longint;

procedure nhap();
	var i,j : longint;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m);
	for i := 1 to n do read(a[i]);
end;

begin
	nhap;
	main;
end.