Const   inp = 'ADS.INP';
        out = 'ADS.OUT';
        maxn = 2001;
        maxm = 5001;
Var     fi,fo   :       text;
        x,y     :       array [1..maxm] of longint;
        head    :       array [1..maxn] of longint;
        adj     :       array [1..2*maxm] of longint;
        free    :       array [1..maxn] of boolean;
        m,n,t,i   :       longint;

procedure dfs(u : longint);
var i,v : longint;
        begin
              for i := head[u]+1 to head[u+1] do
                begin
                    v := adj[i];
                    if free[v] then
                      begin
                          free[v] := false;
                          dfs(v);
                      end;
                end;
        end;

begin
      assign(fi,inp); reset(fi);
      readln(fi,n,m);
      for i := 1 to m do
        begin
             readln(fi,x[i],y[i]);
             inc(head[x[i]]); inc(head[y[i]]);
        end;
      for i := 2 to n do head[i] := head[i-1] + head[i];
      head[n+1] := 2*m;
      for i := 1 to m do
        begin
             adj[head[x[i]]] := y[i]; dec(head[x[i]]);
             adj[head[y[i]]] := x[i]; dec(head[y[i]]);
        end;
      close(fi);
      fillchar(free,sizeof(free),true);
      for i := 1 to n do
        if free[i] then
          begin
              free[i] := false; inc(t);
              dfs(i);
          end;
      assign(fo,out); rewrite(fo);
      write(fo,m-n+t);
      close(fo);
end.
