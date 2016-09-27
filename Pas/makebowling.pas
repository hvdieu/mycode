uses math;
Const
	out = 'bowling.inp';
    maxa = 101;

Var
	n,r : longint;
    i : longint;
    x : int64;

begin
    randomize;
    assign(output, out); rewrite(output);
    writeln(1);
    n := random(20)+1; r := random(n+1);
    writeln(n,' ', r);
    for i := 1 to n do
      begin
          x := random(maxa);
          if (random(2) = 1) then x := -x;
          write(x,' ');
      end;
end.