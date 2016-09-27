Uses math;
Const
	out = 'vosplay.inp';

Var
	m, n, q, i, u, v : longint;

begin
    randomize;
    assign(output, out); rewrite(output);
    n := 100000; m := 100000; q := 100000;
    writeln(n,' ', m, ' ', q);
    for i := 1 to m do write(i,' ');
    for i := m+1 to n do write(random(m)+1,' ');
    writeln;
    for i := 1 to q do writeln(random(n)+1,' ',random(n)+1);
end.