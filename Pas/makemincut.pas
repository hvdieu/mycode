Uses math;
Const
	out = 'MINCUT.INP';
    oo = 1000000;

Var
	m, n, k, i, j, u, v : longint;
    x1, y1, x2, y2 : longint;

procedure swap(var xx, yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

begin
    randomize;
    assign(output, out); rewrite(output);
    m := 1000; n := 1000;
    k := m*n;
    writeln(m,' ',n,' ',k);
    for i := 1 to m do
     begin
         for j := 1 to n do write(random(oo)+1,' ');
         writeln;
     end;
    for i := 1 to k do
      begin
          x1 := random(m)+1; x2 := random(m)+1;
          y1 := random(n)+1; y2 := random(n)+1;
          while ((x1 = x2) and (y1 = y2)) do
           begin
               x1 := random(m)+1;
               y1 := random(n)+1;
           end;
          if (x1 > x2) then swap(x1, x2);
          if (y1 > y2) then swap(y1, y2);
          writeln(x1,' ',y1,' ', x2,' ',y2);
      end;
end.
	
