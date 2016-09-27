Const   inp = 'lubenica.inp';
        out = 'lubenica.out';
        maxn = 100001;
Var     fi,fo   :       text;
        n,vmax,kq1,kq2,dem1,dem2,k       :       longint;
        head,x,y,z,p,num,thoat    :       array [1..maxn] of longint;
        free    :       array [1..maxn] of boolean;
        adj,c     :       array [1..2*maxn] of longint;
        f,lmin,lmax  :       array [1..maxn,0..20] of longint;

Function min(xx,yy : longint) : longint;
        BEGIN
             if xx >= yy then min := yy
               else min := xx;
        END;

Function max(xx,yy : longint) : longint;
        BEGIN
             if xx >= yy then max := xx
               else max := yy;
        END;

Procedure input;
Var i,j,a,b,l : longint;
        BEGIN
              assign(fi,inp); reset(fi);
              assign(fo,out); rewrite(fo);
              readln(fi,n);
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
                lmax[u,j] := max(lmax[u,j-1],lmax[f[u,j-1],j-1]);
                lmin[u,j] := min(lmin[u,j-1],lmin[f[u,j-1],j-1]);
              END;
             For i := head[u] + 1 to head[u+1] do
                BEGIN
                      v := adj[i];
                      if free[v] then
                         BEGIN
                               p[v] := u; f[v,0] := u;
                               lmin[v,0] := c[i];
                               lmax[v,0] := c[i];
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

Procedure LCA(u,v : longint);
   //tim LCA O(log n)
Var i,u1,mi1,mi2,ma1,ma2 : longint;
        BEGIN
              mi1 := maxlongint; mi2 := mi1;
              ma1 :=-maxlongint; ma2 := ma1;
              if check(u,v) then
                 BEGIN
                      For i := vmax downto 0 do
                        BEGIN
                             if check(f[v,i],u) = false then
                               BEGIN
                                   mi1 := min(mi1,lmin[v,i]);
                                   ma1 := max(ma1,lmax[v,i]);
                                   v := f[v,i];
                               END;
                        END;
                      kq1 := min(mi1,lmin[v,0]);
                      kq2 := max(ma1,lmax[v,0]);
                      exit;
                 END;
              if check(v,u) then
                 BEGIN
                      For i := vmax downto 0 do
                        BEGIN
                             if check(f[u,i],v) = false then
                               BEGIN
                                    mi1 := min(mi1,lmin[u,i]);
                                    ma1 := max(ma1,lmax[u,i]);
                                    u := f[u,i];
                               END;
                        END;
                      kq1 := min(mi1,lmin[u,0]);
                      kq2 := max(ma1,lmax[u,0]);
                      exit;
                 END;
              u1 := u ;
              For i := vmax downto 0 do
                BEGIN
                     if check(f[u,i],v) = false then
                       BEGIN
                            mi1 := min(mi1,lmin[u,i]);
                            ma1 := max(ma1,lmax[u,i]);
                            u := f[u,i];
                       END;
                END;
              mi1 := min(mi1,lmin[u,0]);
              ma1 := max(ma1,lmax[u,0]);
             For i := vmax downto 0 do
                BEGIN
                      if check(f[v,i],u1) = false then
                       BEGIN
                           mi2 := min(mi2,lmin[v,i]);
                           ma2 := max(ma2,lmax[v,i]);
                           v := f[v,i];
                       END;
                END;
             mi2 := min(mi2,lmin[v,0]);
             ma2 := max(ma2,lmax[v,0]);
             kq1 := min(mi1,mi2);
             kq2 := max(ma1,ma2);
        END;

Procedure init;
Var i,j : longint;
        BEGIN
             vmax := round(ln(n)/ln(2));
             fillchar(free,sizeof(free),true);
             f[1,0] := 1; p[1] := 1;
             For i := 1 to n do
               For j := 1 to 20 do
                 BEGIN
                      lmin[i,j] := maxlongint;
                      lmax[i,j] := -maxlongint;
                 END;
             dem1 := 0; dem2 := 0;

        END;


Procedure main;
Var st,a,b : longint;
        BEGIN
              init;
              DFS(1);
              readln(fi,k);
              For st := 1 to k do
                BEGIN
                     readln(fi,a,b);
                     LCA(a,b);
                     writeln(fo,kq1,' ',kq2);
                END;
              close(fi); close(fo);
        END;

BEGIN
      input;
      main;
END.
