var n,i : longint;
    a : array [0..1] of longint;

begin
    randomize;
    assign(output,'tbike.inp'); rewrite(output);
    n := 20;
    a[0] := -1; a[1] := 1;
    writeln(n);
    for i := 1 to n do write(random(10)*a[1]+1,' ');
end.