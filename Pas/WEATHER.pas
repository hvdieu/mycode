Const   inp = '';
        out = '';
        maxn = 101;
        maxm = 5001;
Var     fi,fo   :       text;
        head,num,low,cha,q,f        :       array [1..maxn] of longint;
        adj     :       array [1..2*maxm] of longint;
        free    :       array [1..maxn] of boolean;
        x1,y1     :       array [1..maxm] of longint;
        n,m,dem,l,r   :       longint;
        res     :       qword;

Procedure input;
Var i,j : longint;
        BEGIN
             assign(fi,inp); reset(fi);
             readln(fi,n);
             readln(fi,m);
             For i := 1 to m do
               BEGIN
                    readln(fi,x1[i],y1[i]);
                    inc(head[x1[i]]);
                    inc(head[y1[i]]);
               END;
             close(fi);
             For i := 2 to n do head[i] := head[i-1] + head[i];
             head[n+1] := 2*m;
             For i := 1 to m do
               BEGIN
                   adj[head[x1[i]]] := y1[i];
                   dec(head[x1[i]]);
                   adj[head[y1[i]]] := x1[i];
                   dec(head[y1[i]]);
               END;
        END;

Procedure BFS(x : longint);
Var i,j,u,v : longint;
        BEGIN
             l := 0; r := 1;
             q[r] := x;
             free[x] := false;
             While l < r do
               BEGIN
                    inc(l);
                    u := q[l];
                    For i := head[u] + 1 to head[u+1] do
                     BEGIN
                         v := adj[i];
                         if free[v] then
                          BEGIN
                              free[v] := false;
                              inc(r);
                              q[r] := v;
                          END;
                     END;
               END;
        END;

Procedure DFS(u : longint);
Var i,j,v : longint;
        BEGIN
             inc(dem); num[u] := dem;
             low[u] := num[u];
             f[u] := 1;
             For i := head[u] + 1 to head[u+1] do
               BEGIN
                   v := adj[i];
                   if cha[v] = 0 then
                     BEGIN
                         cha[v] := u;
                         DFS(v);
                         if low[u] > low[v] then low[u] := low[v];
                         f[u] := f[u] + f[v];
                     END
                      else if (cha[u] <> v) and (cha[v] <> u) then
                        if low[u] > num[v] then low[u] := num[v];
               END;
        END;

Procedure xuly(x : longint);
Var i,j,u,v : longint;
        BEGIN
            For i := 1 to r do
              BEGIN
                  v := q[i];
                  u := cha[v];
                  if (u<>-1) and (low[v] >= num[v]) then
                       res := res + f[v] * (r-f[v]);
              END;
        END;

Procedure main;
Var x : longint;
        BEGIN
             fillchar(free,sizeof(free),true);
             For x := 1 to n do
               if free[x] then
                BEGIN
                    cha[x] := -1;
                    BFS(x);
                    dem := 0;
                    DFS(x);
                    xuly(x);
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