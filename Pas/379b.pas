var     n,i,j : integer;
        a    : array [1..300] of integer;

begin
    readln(n);
    for i := 1 to n do read(a[i]); readln;
    for i := 1 to n-1 do
     begin
     if a[i] > 0 then
      begin
          for j := 1 to a[i] do write('RLP');
      end;
     write('R');
     end;
    if a[n] > 0 then
     for j := 1 to a[n] do write('LRP');  readln;
end.