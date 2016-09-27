Const   maxn = 501;

Var     n,m,k   :       longint;
        f       :       array [0..maxn,0..maxn,0..maxn] of qword;

{*************************************************************************}
procedure main;
var i,j,t : longint;
        begin
            for i := 0 to k do
             for j := 0 to m do
             f[i,0,j] := 1;
            for t := 1 to k do
             for i := 0 to n do
              for j := 1 to m do
               begin
                   if i < t then f[t,i,j] := f[t-1,i,j]
                    else f[t,i,j] := f[t-1,i,j] + f[t,i-t,j-1];
               end;
            writeln(f[k,n,m]);
        end;
{*************************************************************************}
begin
     assign(input,'GAME.INP'); reset(input);
     assign(output,'GAME.OUT'); rewrite(output);
     readln(n,m,k);
     main;
end.