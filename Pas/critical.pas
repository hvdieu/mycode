Const   inp = '';
        out = '';
        maxn = 20001;
        maxm = 200001;
Var     fi,fo   :       text;
        n,m,dem,i,j,left,right,top     :       longint;
        head,num,low,cha,ncon,f,q        :       array [1..maxn] of longint;
        d       :       array [1..maxn] of qword;
        st       :       array [0..maxn] of longint;
        free    :       array [1..maxn] of boolean;
        khop     :       array [1..maxn] of boolean;
        adj     :       array [1..2*maxm] of longint;
        x,y     :       array [1..maxm] of longint;
        res       :       qword;
        kq     :      extended;

Procedure input;
Var i,j : longint;
        BEGIN
             assign(fi,inp); reset(fi);
             readln(fi,n,m);
             For i := 1 to m do
               BEGIN
                    readln(fi,x[i],y[i]);
                    inc(head[x[i]]);
                    inc(head[y[i]]);
               END;
             close(fi);
             for i := 2 to n do head[i] := head[i-1] + head[i];
             head[n+1] := 2*m;
             For i := 1 to m do
               BEGIN
                    adj[head[x[i]]] := y[i];
                    dec(head[x[i]]);
                    adj[head[y[i]]] := x[i];
                    dec(head[y[i]]);
               END;
        END;

Procedure BFS(u : longint);
Var v,i,t : longint;
        BEGIN
             left := 0; right := 1;
             q[1] := u;
             free[u] := false;
             While left < right do
                BEGIN
                    inc(left);
                    v := q[left];
                    For i := head[v] +1 to head[v+1] do
                      BEGIN
                           t := adj[i];
                           if free[t] then
                             BEGIN
                                  inc(right);
                                  q[right] := t;
                                  free[t] := false;
                             END;
                      END;
                END;
        END;

Procedure DFS(u : longint);
Var v,i : longint;
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
                           inc(ncon[u]);
                           DFS(v);
                           if low[u] > low[v] then low[u] := low[v];
                           f[u] := f[u] + f[v];
                       END
                        else if (cha[u] <> v) and (cha[v] <> u) then
                          if low[u] > num[v] then low[u] := num[v];

                END;

        END;

{Procedure tinh(u : longint);
Var v,i,d1,tong: longint;
    sum : qword;
        BEGIN
              d1 := 0; tong := 0;
              s[0] := 0;
              For i := head[u] + 1 to head[u+1] do
                BEGIN
                     v := adj[i];
                     if cha[v] = u then
                       if low[v] >= num[u] then
                         BEGIN
                              inc(d1);
                              s[d1] := f[v];
                              tong := tong + f[v];
                         END;
                END;
              inc(d1); s[d1] := n - tong - 1;
              tong := 0; sum := 0;
              For i := 1 to d1 do
                sum := sum +
              d[u] := sum;
        END; }

Procedure main;
Var u,v,i,j,t,x : longint;
        BEGIN
             fillchar(free,sizeof(free),true);
             For x := 1 to n do
               if free[x] then
                 BEGIN
                      cha[x] := -1;
                      BFS(x);
                      dem := 0;
                      DFS(x);
                      For i := 2 to right do
                        BEGIN
                             v := q[i];
                             u := cha[v];
                             if low[v] >= num[u] then
                               if (u<>x) or (ncon[u] >= 2) then khop[u] := true;
                        END;
                      For i := 1 to right do
                        BEGIN
                            u := q[i];
                            if khop[u] then
                              BEGIN
                                  top := 0;
                                  For j := head[u] + 1 to head[u+1] do
                                    BEGIN
                                        v := adj[j];
                                        if (cha[v] = u) and (low[v] >= num[u]) then
                                            BEGIN
                                                 inc(top);
                                                 st[top] := f[v];
                                            END;
                                    END;
                                  if u <> x then
                                BEGIN
                                   inc(top);
                                   st[top] := right - 1;
                                   For j := 1 to top - 1 do st[top] := st[top] - st[j];
                                END;

                               For j := 1 to top do
                                d[u] := d[u] + st[j] * (right-st[j] - 1);
                                d[u] := d[u] div 2;
                              END;

                        END;

                 END;

        END;

Procedure output;
Var u : longint;
        BEGIN
             assign(fo,out); rewrite(fo);
             res := 0;
             For u := 1 to n do res := res + d[u];
             kq := res / n;
             write(fo,kq:0:2);
             close(fo);
        END;

BEGIN
      input;
      main;
      output;
END.
