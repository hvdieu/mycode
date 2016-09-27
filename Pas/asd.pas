Var
    a, b : string;
    n, i : integer;

begin
    readln(a);
    n := length(a);
    for i := n downto 1 do b := b + a[i];
    if (a = b) then writeln('YES')
    else writeln('NO');
    readln;
end.