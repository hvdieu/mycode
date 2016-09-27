Uses math;
Const   maxn = 300;
        maxm = 700;
        maxw = 999999999;

Var     n,m,p,f,mon,s,m1,c,u,v,l,nheap,res,i :       longint;
        d  :       array [1..maxn] of longint;
        head       :    array [1..maxn] of longint;
        ke,next,w :       array [1..maxm] of longint;

{***************************************************************************}
procedure main;
var i,j,k,count : longint;
    stop : boolean;
        begin
             for i := 1 to n do d[i] := maxw;
             d[s] := -mon;
             for count := 1 to n+1 do
               begin
                   if count = n+1 then
                     begin
                         write(-1);
                         exit;
                     end;
                   stop := true;
                   for u := 1 to n do
                     begin
                         j := head[u];
                         while j <> 0 do
                           begin
                               v := ke[j];
                               if d[v] > d[u] + w[j] - mon then
                                 begin
                                     d[v] := d[u] + w[j] - mon;
                                     stop := false;
                                 end;
                               j := next[j];
                           end;

                     end;
                   if stop then break;
               end;
             for i := 1 to n do if res > d[i] then res := d[i];
             writeln(abs(res));
        end;
{**************************************************************************}
begin
     assign(input,'JOB.INP'); reset(input);
     assign(output,'JOB.OUT'); rewrite(output);
     readln(mon,m,n,m1,s);
     for i := 1 to m do
       begin
           inc(c);
           read(u,v);
           ke[c] := v; next[c] := head[u]; head[u] := c;
       end;
     for i := 1 to m1 do
       begin
           inc(c);
           read(u,v,l);
           ke[c] := v; next[c] := head[u]; w[c] := l; head[u] := c;
       end;
     main;
end.
