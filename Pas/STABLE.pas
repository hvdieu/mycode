Const   inp = '';
        out = '';
        maxn = 10010;
        maxm = 50010;
Var     fi,fo   :       text;
        head,f,cha,q  :       array [1..maxn] of longint;
        d       :       array [1..maxn] of longint;
        adj     :       array [1..maxm] of longint;
        x,y     :       array [1..maxm] of longint;
        n,m,s,dem,l,r   :       longint;

Procedure input;
Var i,u,v : longint;
        BEGIN
             assign(fi,inp); reset(fi);
             readln(fi,n,m,s);
             dem := 0;
             for i := 1 to m do
               begin
                   readln(fi,u,v);
                     begin
                          x[i] := u; y[i] := v;
                          inc(head[u]);
                     end;
               end;
             for i := 2 to n do head[i] := head[i-1] + head[i];
             head[n+1] := m;
             for i := 1 to m do
                begin
                     adj[head[x[i]]] := y[i];
                     dec(head[x[i]]);
                end;
             close(fi);
        END;

Procedure BFS;
Var i,j,vt,v,u : longint;
        BEGIN
              cha[s] := -1; f[s] := 1;
              d[s] := 1;
              l := 0; r := 1; q[1] := s;
              While l < r do
                 begin
                     vt := r; inc(l);
                     for i := l to vt do
                        begin
                            u := q[i];
                            for j := head[u] + 1 to head[u+1] do
                              begin
                                   v := adj[j];
                                   if cha[v] = 0 then
                                      begin
                                          cha[v] := u;
                                          inc(r); q[r] := v;
                                          f[v] := f[u];
                                          d[v] := d[u] + 1;
                                      end
                                   else if (cha[v] <> u) and (d[v] = d[u]+1) then
                                     begin
                                        f[v] := f[u] + f[v];
                                        if f[v] > 2 then f[v] := 2;
                                        cha[v] := u;
                                     end;
                              end;
                        end;
                     l := vt;
                 end;
        END;

Procedure output;
Var i,res : longint;
        BEGIN
             assign(fo,out); rewrite(fo);
             res := 0;
             for i := 1 to n do if f[i] >= 2 then inc(Res);
             write(fo,res);
             close(fo);
        END;

BEGIN
     input;
     BFS;
     output;
END.
