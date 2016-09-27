Const   inp = '';
        out = '';
        maxn = 1001;
Var     fi,fo   :       text;
        n,q,vmax,dem1,dem2     :       longint;
        x,y,z,head,p,num,thoat   :       array [1..maxn] of longint;
        adj,c   :       array [1..2*maxn] of longint;
        free    :       array [1..maxn] of boolean;
        f       :       array [1..maxn,0..maxn] of longint;
        d       :       array [0..maxn,0..maxn] of int64;



Procedure input;
Var i,j,a,b,l : longint;
        BEGIN
              assign(fi,inp); reset(fi);
              assign(fo,out); rewrite(fo);
              readln(fi,n,q);
              fillchar(head,sizeof(head),0);
              For i := 1 to n-1 do
                BEGIN
                     readln(fi,x[i],y[i],z[i]);
                     inc(head[x[i]]); inc(head[y[i]]);
                END;
              For i := 2 to n do head[i] := head[i-1] + head[i];
              head[n+1] := 2*(n-1);
              For i := 1 to n-1 do
                BEGIN
                     adj[head[x[i]]] := y[i]; c[head[x[i]]] := z[i];
                     dec(head[x[i]]);
                     adj[head[y[i]]] := x[i]; c[head[y[i]]] := z[i];
                     dec(head[y[i]]);
                END;
        END;

Procedure DFS(u : longint);
Var v,i,j : longint;
        BEGIN
             free[u] := false;
             inc(dem1); num[u] := dem1;
             For j := 1 to vmax do
              BEGIN
                f[u,j] := f[f[u,j-1],j-1]; // f[u,j] : to tien thu 2^j cua dinh u
                d[u,j] := d[u,j-1] + d[f[u,j-1],j-1];
              END;
             For i := head[u] + 1 to head[u+1] do
                BEGIN
                      v := adj[i];
                      if free[v] then
                         BEGIN
                               p[v] := u; f[v,0] := u;
                               d[v,0] := c[i];
                               free[v] := false;
                               DFS(v);
                         END;
                END;
             inc(dem2);
             thoat[u] := dem2;
        END;

Function check(u,v : longint) : boolean;
   //kiem tra xem dinh u co la cha cua dinh v hay k
        BEGIN
             if (num[u] <= num[v]) and (thoat[u] >= thoat[v]) then exit(true)
               else exit(false);
        END;

Function LCA(u,v : longint) : int64;
   //tim LCA O(log n)
Var i,u1 : longint;
    kq : int64;
        BEGIN
              kq := 0;
              if check(u,v) then
                 BEGIN
                      For i := vmax downto 0 do
                        BEGIN
                             if check(f[v,i],u) = false then
                               BEGIN
                                   kq := kq + d[v,i];
                                   v := f[v,i];
                               END;
                        END;
                      exit(kq+d[v,0]);
                 END;
              if check(v,u) then
                 BEGIN
                      For i := vmax downto 0 do
                        BEGIN
                             if check(f[u,i],v) = false then
                               BEGIN
                                    kq := kq + d[u,i];
                                    u := f[u,i];
                               END;
                        END;
                      exit(kq + d[u,0]);
                 END;
              u1 := u ;
              For i := vmax downto 0 do
                BEGIN
                     if check(f[u,i],v) = false then
                       BEGIN
                            kq := kq + d[u,i];
                            u := f[u,i];
                       END;
                END;
              kq := kq + d[u,0];
             For i := vmax downto 0 do
                BEGIN
                      if check(f[v,i],u1) = false then
                       BEGIN
                           kq := kq + d[v,i];
                           v := f[v,i];
                       END;
                END;
             exit(kq+d[v,0]);
        END;

Procedure init;
Var i,j : longint;
        BEGIN
             vmax := round(ln(n)/ln(2));
             fillchar(free,sizeof(free),true);
             fillchar(d,sizeof(d),0);
             f[1,0] := 1; p[1] := 1;
             dem1 := 0; dem2 := 0;

        END;


Procedure main;
Var st,a,b : longint;
        BEGIN
              init;
              DFS(1);
              For st := 1 to q do
                BEGIN
                     readln(fi,a,b);
                     writeln(fo,LCA(a,b));
                END;
              close(fi); close(fo);
        END;

BEGIN
      input;
      main;
END.
