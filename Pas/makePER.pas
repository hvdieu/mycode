Uses math;
Const
	out = 'PER.INP';
    maxn = 200001;

Var
	n,i,m : longint;

begin
	randomize;
    assign(output,out); rewrite(output);

    n := 10000; m := 10000; writeln(n,' ',m);
    for i := 1 to n do write(random(n)+1,' ');
    writeln;
    for i := 1 to m do
      begin
          writeln(random(n)+1,' ',random(n)+1);
      end;
end.