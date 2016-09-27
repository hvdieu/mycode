Uses math;
Const
	out = 'input.txt';

Var
	n, k ,m, t, j: longint;
	i : longint;
    a : array [1..1000] of longint;

begin
    randomize;
    assign(output, out); rewrite(output);
    n := 1000; m := 456;
    writeln(n,' ',m);
    for i := 1 to n do a[i] := i;
    for i := 1 to n do
     begin
         j := random(n) + 1;
         t := a[i]; a[i] := a[j]; a[j] := t;
     end;
    for i := 1 to n do write(a[i],' ');
end.