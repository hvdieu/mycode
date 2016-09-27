Uses math;
Const 
	inp = 'QBSEQPAR.INP';
	out = 'QBSEQPAR.OUT';
	maxn = 15001;

Var
	n,k,i : longint;
	a : array [1..maxn] of longint;

procedure main;
	var i,j : longint;
begin
	
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,k);
	for i := 1 to n do read(a[i]);
	main;
end.