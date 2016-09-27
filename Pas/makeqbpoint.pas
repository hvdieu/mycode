var i : longint;
   a: array [0..1] of longint;
begin
    randomize;
    assign(output,'QBPOINT.INP'); rewrite(output);
    a[0] := 1; a[1] := -1;
    writeln(2000);
    for i := 1 to 2000 do writeln(a[random(2)]*random(10000),' ',a[random(2)]*random(10000));
end.