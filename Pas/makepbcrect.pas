Uses math;
Const
	out = 'pbcrect.inp';

Var
	m, n, i, j : longint;

begin
    randomize;
    assign(output, out); rewrite(output);
    m := 15000; n := 1000;
    writeln(m,' ',n);
    for i := 1 to m do
    begin
        for j := 1 to n do write(random(2));
        writeln;
    end;
end.
