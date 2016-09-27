Uses math;
Const   maxn = 251;
        maxm = 10001;
        maxw = 999999999;

Var     n,m,k,i,u,v,l,res : longint;
        ke,next,w : array [-maxm..maxm] of longint;
        head,c    : array [1..maxn] of longint;
        a       : array [1..maxn,1..maxn] of longint;
        free    : array [1..maxn] of boolean;
        g,d     : array [1..maxn] of longint;

{***************************************************************************}
procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;
{***************************************************************************}
procedure dij(i : longint);
var j,u,v,temp : longint;
        begin
            fillchar(free,sizeof(free),true);
            for j := 1 to n do d[j] := maxw;
            d[i] := 0;
            repeat
               u := 0; temp := maxw;
               for j := 1 to n do
                if free[j] and (d[j] < temp) then
                  begin
                      u := j; temp := d[j];
                  end;
               if u = 0 then break;
               free[u] := false;
               j := head[u];
               while j <> 0 do
                 begin
                     v := ke[j];
                     if free[v] then
                       begin
                           if (c[v] <= c[i]) and (d[v] > d[u] + w[j]) then
                              d[v] := d[u] + w[j];
                       end;
                     j := next[j];
                 end;
            until false;
            for j := 1 to n do a[i,j] := d[j];
        end;
{***************************************************************************}
procedure main;
var i,j : longint;
        begin
             for i := 1 to n do dij(i);
             for i := 1 to k do
               begin
                   readln(u,v);
                   res := maxw;
                   for j := 1 to n do
                    if a[j,u] + a[j,v] +c[j]< res then res := a[j,u] + a[j,v] + c[j];
                   writeln(res);
               end;
        end;
{***************************************************************************}
begin
     assign(input,'TPATHS.INP'); reset(input);
     assign(output,'TPATHS.OUT'); rewrite(output);
     readln(n,m,k);
     for i := 1 to n do read(c[i]);
     for i := 1 to m do
       begin
           read(u,v,l);
           ke[i] := v; next[i] := head[u]; w[i] := l; head[u] := i;
           ke[-i] := u; next[-i] := head[v]; w[-i] := l; head[v] := -i;
       end;
     main;
end.
