uses math;
Const   maxn = 20001;
        maxm = 50001;

Var     n,m,dem,count     :       longint;
        head,low,num,cha,kq    :       array [1..maxn] of longint;
        ke,next :       array [-maxm..maxm] of longint;

{*************************************************************************}
procedure nhap;
var i,j,u,v : longint;
        begin
             assign(input,'GRAPH.INP'); reset(input);
             assign(output,'GRAPH.OUT'); rewrite(output);
             readln(n,m);
             for i := 1 to m do
               begin
                   read(u,v);
                   ke[i] := v; next[i] := head[u]; head[u] := i;
                   ke[-i] := u; next[-i] := head[v]; head[v] := -i;
               end;
        end;
{*************************************************************************}
procedure dfs(u : longint);
var v,j : longint;
        begin
            if cha[u] = u then kq[u] := 0 else kq[u] := 1;
            inc(dem); num[u] := dem; low[u] := num[u];
            j := head[u];
            while j <> 0 do
              begin
                  v := ke[j];
                  if cha[v] = 0 then
                    begin
                        cha[v] := u;
                        dfs(v);
                        low[u] := min(low[u],low[v]);
                        if low[v] >= num[u] then inc(kq[u]);
                    end
                  else if (cha[u] <> v) and (cha[v] <> u) then
                    low[u] := min(low[u],num[v]);
                  j := next[j];
              end;
        end;
{*************************************************************************}
procedure main;
var i : longint;
        begin
            for i := 1 to n do
             if num[i] = 0 then
               begin
                   cha[i] := i;
                   dfs(i);
                   inc(count);
               end;
            for i := 1 to n do writeln(count+kq[i]-1);
        end;
{*************************************************************************}
begin
     nhap;
     main;
end.
