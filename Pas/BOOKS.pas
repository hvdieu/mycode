Uses math;
Const   maxn = 501;
Var     n,i,j,res   :       longint;
        a       :       array [0..maxn,0..maxn] of longint;
        d       :       array [1..4,0..maxn,0..maxn] of longint;

{***************************************************************************}
procedure main;
var i,j : longint;
        begin
             for i := 1 to n do
               begin
                    for j := 1 to n do d[1,i,j] := max(d[1,i,j-1],a[i,j]);
                    for j := n downto 1 do d[2,i,j] := max(d[2,i,j+1],a[i,j]);
               end;
             for j := 1 to n do
               begin
                    for i := 1 to n do d[3,i,j] := max(d[3,i-1,j],a[i,j]);
                    for i := n downto 1 do d[4,i,j] := max(d[4,i+1,j],a[i,j]);
               end;
             for i := 1 to n do
              for j := 1 to n do
               if a[i,j] <> 0 then
                 begin
                     if (a[i,j] > d[1,i,j-1]) or (a[i,j] > d[2,i,j+1])
                      or (a[i,j] > d[3,i-1,j]) or (a[i,j] > d[4,i+1,j]) then
                       inc(Res);
                 end;
             writeln(res);
        end;
{***************************************************************************}
begin
     assign(input,'BOOKS.INP'); reset(input);
     assign(output,'BOOKS.OUT'); rewrite(output);
     readln(n);
     for i := 1 to n do
      for j := 1 to n do read(a[i,j]);
     main;
end.