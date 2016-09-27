Const   maxn = 50000;

Var     n,c       :       longint;
        p       :       array [0..maxn] of longint;
        free    :       array [0..maxn] of boolean;
        res     :       qword;

{***************************************************************************}
procedure sangngto;
var i,j : longint;
        begin
            fillchar(p,sizeof(p),0);
            fillchar(free,sizeof(free),true);
            for i := 2 to trunc(sqrt(n)) do
              if free[i] then
                begin
                    j := i*i;
                    inc(c); p[c] := i;
                    while j <= trunc(sqrt(n)) do
                      begin
                          free[j] := false;
                          j := j + i;
                      end;
                end;
        end;
{****************************************************************************}
procedure main;
var i,j,dem : longint;
        begin
            sangngto;
            res := n;
            for j := 1 to c do
             if n mod p[j] = 0 then
               begin
                   dem := 0;
                   while n mod p[j] = 0 do
                     begin
                         inc(dem);
                         n := n div p[j];
                     end;
                   if dem mod 2 = 1 then res := res * p[j];
               end;
             if n > 0 then res := res * n;
             writeln(res);
        end;
{****************************************************************************}
begin
     assign(input,'drat.inp'); reset(input);
     assign(output,'drat.out'); rewrite(output);
     readln(n);
     main;
end.
