Uses math;
Const 
	inp = 'QBMARKET.INP';
	out = 'QBMARKET.OUT';
	maxn = 100010;

Var
	n,s : longint;
	c,m : array [1..maxn] of longint;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,s);

end.