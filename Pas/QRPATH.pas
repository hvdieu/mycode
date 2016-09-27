uses math;
Const   inp = 'QRPATH.INP';
        out = 'QRPATH.OUT';
        maxn = 100001;
Var     fi,fo   :       text;
        head,num,thoat,p        :       array [1..maxn] of longint;
        adj,cost     :       array [1..2*maxn] of longint;
        f,l       :       array [1..maxn,0..20] of longint;
        free    :       array [1..maxn] of boolean;
        q,n,r,dem1,dem2,vmax   :       longint;

Procedure DFS(u : longint);
Var v,i,j : longint;
        BEGIN
             free[u] := false;
             inc(dem1); num[u] := dem1;
             For j := 1 to vmax do
              BEGIN
                  f[u,j] := f[f[u,j-1],j-1];
                  l[u,j] := min(l[u,j-1],l[f[u,j-1],j-1]);
              END;
             For i := head[u] + 1 to head[u+1] do
                BEGIN
                      v := adj[i];
                      if free[v] then
                         BEGIN
                               p[v] := u; f[v,0] := u;
                               l[v,0] := cost[i];
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

Function LCA1(u,v : longint) : longint;
   //tim LCA O(n)
        BEGIN
              if check(u,v) then exit(u);
              if check(v,u) then exit(v);
              While check(u,v) = false do
                 u := p[u];
              exit(u);
        END;

Function LCA(u,v : longint) : longint;
   //tim LCA O(log n)
Var i,min1,min2 : longint;
        BEGIN
              min1 := maxlongint; min2 := min1;
              For i := vmax downto 0 do
                 if check(f[u,i],v) = false then
                     BEGIN
                       min1 := min(min1,l[u,i]);
                       u := f[u,i];
                     END;
                 min1 := min(min1,l[u,0]);
              For i := vmax downto 0 do
                if check(f[v,i],u) = false then
                     BEGIN
                         min1 := min(min1,l[v,i]);
                         v := f[v,i];
                     END;
                min1 := min(min1,l[v,0]);
              exit(min1);
        END;


Procedure main;
Var i,j,x,y,z : longint;
        BEGIN
              Assign(fi,inp); reset(fi);
              Assign(fo,out); rewrite(fo);
              fillchar(head,sizeof(head),0);
              readln(fi,n,q);
              For i := 1 to n-1 do
                BEGIN
                     readln(fi,x,y,z);
                     inc(head[x]); inc(head[y]);
                END;
              close(fi);
              For i := 2 to n do head[i] := head[i-1] + head[i];
              head[n+1] := 2*(n-1);
              assign(fi,inp); reset(fi);
              readln(fi,n,q);
              For i := 1 to n-1 do
                BEGIN
                      readln(fi,x,y,z);
                      adj[head[x]] := y; cost[head[x]] := z; dec(head[x]);
                      adj[head[y]] := x; cost[head[y]] := z; dec(head[y]);
                END;
              fillchar(free,sizeof(free),true);
              fillchar(f,sizeof(f),0);
              f[1,0] := 1; vmax := round(ln(n) / ln(2))+1;
              dem1 := 0; dem2 := 0;
              For i := 1 to n do
                For j := vmax downto 0 do l[i,j] := maxlongint;
              DFS(1);
              For i := 1 to q do
                BEGIN
                      readln(fi,x,y);
                      writeln(fo,LCA(x,y));
                END;
              close(fi); close(fo);
        END;

BEGIN

     main;
END.
