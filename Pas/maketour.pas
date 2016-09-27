Uses math;
Const out = 'tour.inp';

Var
	n, m, i, u, v, l : longint;
    d : array [1..1000,1..1000] of longint;
    dem : array [1..1000] of longint;

begin
    randomize;
    assign(output, out); rewrite(output);
    n := 100; m := 1000;
    writeln(n,' ', m);
    for i := 1 to m do
      begin
           repeat
               u := random(n)+1;
           until dem[u] <> n-1;
           v := random(n)+1;
           while (u = v) do v := random(n)+1;
           writeln(u,' ',v,' ', random(1000000));
      end;
end.
