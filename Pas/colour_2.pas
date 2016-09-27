Const   maxn = 101;
Var     n,x,y,i,dem       :       longint;
        a,b,head     :       array [1..maxn] of longint;
        free    :    array [1..maxn] of boolean;
        adj     :    array [1..2*maxn] of longint;
        res     :    int64;

procedure dfs(u : longint);
var i,v : longint;
        begin
            free[u] := false;
            for i := head[u]+1 to head[u+1] do
              begin
                  v := adj[i];
                  if free[v] then dfs(v);
              end;
        end;

begin
     assign(input,'colour.inp'); reset(input);
     assign(output,'colour.out'); rewrite(output);
     readln(n);
     for i := 1 to n do
      begin
        read(a[i]);
        inc(head[a[i]]);
      end;
     for i := 1 to n do
      begin
        read(b[i]);
        inc(head[b[i]]);
      end;
     for i := 2 to n do head[i] := head[i-1] + head[i];
     head[n+1] := head[n];
     for i := 1 to n do
       begin
           x := a[i]; y := b[i];
           adj[head[x]] := y; dec(head[x]);
           adj[head[y]] := x; dec(head[y]);
       end;
    fillchar(free,sizeof(Free),true);
    for i := 1 to n do if free[i] then
     begin
       inc(dem);
       dfs(i);
     end;
    res := 1 shl dem;
    write(res);
end.