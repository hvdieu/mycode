Uses math;
Const
	out = 'tsort.inp';

Var
	n, m, i, j, u, v, t, k : longint;
    a : array [1..1000] of longint;

begin
    randomize;
    assign(output, out); rewrite(output);
    n := 1000; k := 100000;
    for i := 1 to n do a[i] := i;
   { for i := n to n do
      begin
          j := random(n)+1;
          t := a[i]; a[i] := a[j]; a[j] := t;
      end;             }
    writeln(n,' ',k);
    for i := 1 to n do write(a[i],' ');
end.
