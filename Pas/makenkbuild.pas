uses math;
const
	out = 'nkbuild.inp';

Var
	n, m, k, i, j : longint;

begin
    randomize;
    assign(output, out); rewrite(output);
    n := 6; m := 10; k := 4;
    writeln(n,' ',m,' ',k);
    for i := 1 to k do write(i,' ');
    writeln;
    for i := 1 to m do
      begin
          writeln(random(n) + 1,' ',random(n)+1,' ',random(10)+1);
      end;
end.
