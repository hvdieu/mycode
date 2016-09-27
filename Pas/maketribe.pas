Uses math;
Const
	out = 'tribe.inp';

Var
	n,i : longint;

begin
	randomize;
	assign(output,out); rewrite(output);
	n := 100000;
	writeln(n);
	for i := 2 to n do writeln(random(i-1)+1,' ',i);
end.
