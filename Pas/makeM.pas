Uses math;
Const
	out = 'M.inp';

Var
	n, m, i : longint;

begin
    randomize;
    assign(output, out); rewrite(output);
    n := 1000; writeln(n);
    for i := 1 to n do write(random(10000000),' ');
end.