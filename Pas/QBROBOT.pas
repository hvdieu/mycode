Const   inp = '';
        out = '';
        maxn = 501;
Var     fi,fo   :       text;
        head     :       array [1..maxn] of longint;
        adj,c,t     :    array [1..2*30000] of longint;
        x,y,z,k :    array [1..30000] of longint;
        p,free       :       array [1..maxn] of boolean;
        d       :       array [1..maxn] of longint;
        n,m,w,s,mid,res     :       longint;
        ok      :   boolean;

Procedure nhap;
Var i,j,st : longint;
        BEGIN
               assign(fi,inp); reset(fi);
               readln(fi,n);
               fillchar(p, sizeof(p), false);
               For i := 1 to n do
                    BEGIN
                          read(fi,st);
                          if st = 1 then p[i] := true;
                    END;
               readln(fi,m);
               For i := 1 to m do
                 BEGIN
                      readln(fi,x[i],y[i],z[i],k[i]);
                      inc(head[ x[i] ]);
                      inc(head[ y[i] ]);
                 END;
               For i := 2 to n do
                 head[i] := head[i] + head[i-1];
                 head[n+1] := m*2;
               For i := 1 to m do
                 BEGIN
                      adj[ head[x[i]] ] := y[i];
                      t[ head[x[i]] ] := z[i];
                      c[ head[x[i]] ] := k[i];
                      dec(head[x[i]]);

                      adj[ head[y[i]] ] := x[i];
                      t[ head[y[i]] ] := z[i];
                      c[ head[y[i]] ] := k[i];
                      dec(head[y[i]]);
                 END;
               close(fi);
        END;
Procedure DFS(u : longint);
Var v,st,gt : longint;
        BEGIN
             For st := head[u] + 1 to head[u+1] do
                BEGIN
                      v := adj[st];
                      if (s + t[st] + d[v] = d[1]) and ((w >= c[st]) ) then
                         BEGIN
                              gt := w;
                              w := w - c[st];
                              if p[v] then w := mid;
                              s := s + t[st];
                              if s = d[1] then
                                    ok := true
                                else
                                 DFS(v);

                                 if p[v] then w := gt
                                else w := w + c[st];
                              s := s - t[st];

                         END;
                END;
        END;

Procedure find(dau,cuoi  :  longint);
        BEGIN
              While dau <= cuoi do
                BEGIN
                       mid := (dau+cuoi) div 2;
                       s := 0; w := mid; ok := false;
                       DFS(1);
                       if ok then
                         BEGIN
                              res := mid;
                              cuoi := mid - 1;
                         END
                             else dau := mid + 1;
                END;
        END;


Procedure main;
Var i,j,u,v,r,min  :  longint;
        BEGIN
               fillchar(d,sizeof(d),0);
               For i := 1 to n-1 do d[i] := maxlongint;
               d[n] := 0;
               fillchar(free, sizeof(free), true);
               repeat
                    u := 0; min := maxlongint;
                    For i := 1 to n do
                      if free[i] and (d[i] < min) then
                         BEGIN
                               u := i;
                               min := d[i];
                         END;
                      if (u = 1) or (u=0) then break;
                      free[u] := false;
                    For r := head[u] + 1 to head[u+1] do
                     BEGIN
                          v := adj[r];
                          if free[v] and (d[v] > d[u] + t[r]) then
                            d[v] := d[u] + t[r];
                     END;
               until false;

               find(1,300000000);

        END;

Procedure ghi;
BEGIN
      assign(fo,out); rewrite(fo);
      write(fo,res);
      close(fo);
END;

BEGIN
      nhap;
      main;
      ghi;
END.