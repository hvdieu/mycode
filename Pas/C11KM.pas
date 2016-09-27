Uses math;
Const   maxn = 1010;
        maxw = 999999999;
Var     n,i,res       :       longint;
        p       : array [1..maxn] of longint;
        f       : array [0..maxn,0..maxn] of longint;

{**************************************************************************}
procedure main;
var i,j : longint;
        begin
            for i := 0 to n do
             for j := 0 to n do f[i,j] := maxw;
             f[0,0] := 0;
             f[1,0] := p[1];
             if p[1] > 100 then f[1,1] := p[1];
            for i := 2 to n do
             for j := i-1 downto 0 do
              if p[i] <= 100 then
                begin
                 if j > 0 then f[i,j] := min(f[i-1,j-1],f[i-1,j] + p[i])
                  else f[i,j] := f[i-1,j] + p[i];
                 end
               else
                 begin
                   if j > 0 then
                    begin
                      f[i,j] := min(f[i,j], f[i-1,j]);
                      f[i,j+1] := min(f[i,j+1],f[i-1,j] + p[i]);
                    end
                   else
                       begin
                           f[i,j+1] := min(f[i,j+1],f[i-1,j]+p[i]);
                       end;
                 end;
            res := maxw;
            for j := 0 to n do res := min(res,f[n,j]);
            writeln(Res);
        end;
{**************************************************************************}
begin
     assign(input,'asd.inp'); reset(input);
     assign(output,'asd.out'); rewrite(output);
     readln(n);
     for i := 1 to n do read(p[i]);
     main;
end.