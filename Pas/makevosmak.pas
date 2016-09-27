Uses math;
Const
	out = 'vosmaxk.inp';
    oo = 20;

Var
	n, k,i : longint;

begin
	randomize;
    assign(output, out) ;rewrite(output);
    n := 1000000; k := 10;
    writeln(n,' ',k);
    for i := 1 to n do write(random(10)+1,' ');
end.