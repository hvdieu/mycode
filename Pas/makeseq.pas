Uses math;
Const
	out = 'seq.inp';

Var
	n,i : longint;

begin
    randomize;
    assign(output,out); rewrite(output);
    n := 10000;
    writeln(n);
    for i := 1 to n do write(random(100),' ');
end.
