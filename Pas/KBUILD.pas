uses math;
Const   inp = '';
        out = '';
        maxn = 200001;
Var     fi,fo   :       text;
        head,num,low,cha    :       array [1..maxn] of longint;
        adj,x,y     :       array [1..4*maxn] of longint;
        n,m,res,dem     :       longint;

Procedure input;
Var i,j : longint;
        BEGIN
             assign(fi,inp); reset(fi);
             readln(fi,n);
             For i := 1 to n-1 do
               begin
                   readln(fi, x[i], y[i]);
                   inc(head[x[i]]);
                   inc(head[y[i]]);
               end;
             readln(fi,m); j := i;
             For i := 1 to m do
               begin
                   inc(j);
                   readln(fi,x[j],y[j]);
                   inc(head[x[j]]);
                   inc(head[y[j]]);
               end;
             close(fi);
             for i := 2 to n do head[i] := head[i-1] + head[i];
             head[n+1] := 2*(n-1) + 2*m;
             For i := 1 to m+n-1 do
                BEGIN
                     adj[head[x[i]]] := y[i];
                     dec(head[x[i]]);
                     adj[head[y[i]]] := x[i];
                     dec(head[y[i]]);
                END;
        END;

Procedure DFS(u : longint);
Var i,v : longint;
        BEGIN
            inc(dem); num[u] := dem;
            low[u] := num[u];
            For i := head[u] + 1 to head[u+1] do
              BEGIN
                    v := adj[i];
                    if cha[v] = 0 then
                      BEGIN
                           cha[v] := u;
                           DFS(v);
                           low[u] := min(low[u],low[v]);
                      END
                    else if (u <> cha[v]) and (v <> cha[u]) then
                         low[u] := min(low[u],num[v]);

              END;
        END;
Procedure main;
Var u,v : longint;
        BEGIN
             For u := 1 to n do
               if cha[u] = 0 then
                 BEGIN
                      cha[u] := -1;
                      DFS(u);
                 END;
             For v := 1 to n do
               BEGIN
                    u := cha[v];
                    if (u <> -1) and (low[v] >= num[v]) then inc(res);
               END;
        END;

Procedure output;
        BEGIN
              assign(fo,out); rewrite(fo);
              write(fo,res);
              close(fo);
        END;

BEGIN
      input;
      main;
      output;
END.