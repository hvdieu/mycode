Const   maxn = 100001;
Var     n,i,u,v     :       longint;
        head,t,pos,kq    :       array [1..maxn] of longint;
        ke,next :       array [-maxn..maxn] of longint;
        free    :       array [1..maxn] of boolean;

{*************************************************************************}
procedure update(i,val : longint);
        begin
            while i <= n do
              begin
                  inc(t[i],val);
                  inc(i,i and (-i));
              end;
        end;
{*************************************************************************}
function get(i : longint) : longint;
var s : longint;
        begin
             s := 0;
             while i > 0 do
               begin
                   inc(s,t[i]);
                   dec(i,i and (-i));
               end;
             exit(s);
        end;
{*************************************************************************}
procedure dfs(u : longint);
var j,v : longint;
        begin
             free[u] := false;
             kq[pos[u]] := get(pos[u]);
             j := head[u];
             update(pos[u],1);
             while j <> 0 do
               begin
                   v := ke[j];
                   if free[v] then dfs(v);
                   j := next[j];
               end;
             update(pos[u],-1);
        end;
{*************************************************************************}
begin
      assign(input,'slowdown.inp'); reset(input);
      assign(output,'slowdown.out'); rewrite(output);
      readln(n);
      for i := 1 to n-1 do
        begin
            read(u,v);
            ke[i] := v; next[i] := head[u]; head[u] := i;
            ke[-i] :=u; next[-i] := head[v]; head[v] := -i;
        end;
      for i := 1 to n do
        begin
            read(u);
            pos[u] := i;
        end;
      fillchar(free,sizeof(free),true);
      dfs(1);
      for i := 1 to n do writeln(kq[i]);
end.