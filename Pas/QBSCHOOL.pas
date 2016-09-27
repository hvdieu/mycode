Const   inp = '';
        out = '';
        maxn = 5010;
        maxC = 32767;
        maxm = 20001;
Var     fi,fo   :       text;
        adj,c       :       array [1..2*maxm] of longint;
        k,a,b,l     :       array [1..maxm] of integer;
        d,head       :       array [1..maxn] of longint;
        f       :       array [1..maxn] of int64;
        free      :       array [1..maxn] of boolean;
        n,m       :       longint;

Procedure input;
Var i,j,u,v : longint;
        BEGIN
              Assign(fi,inp); reset(fi);
              readln(fi,n,m);
              fillchar(head,sizeof(head),0);
              For i := 1 to m do
                BEGIN
                     readln(fi,k[i],a[i],b[i],l[i]);
                     inc(head[a[i]]);
                     if k[i] = 2 then inc(head[b[i]]);
                END;
              For i := 2 to n+1 do head[i] := head[i-1] + head[i];
              For i := 1 to m do
                BEGIN
                     adj[ head[a[i]] ] := b[i];
                     c[ head[a[i]] ] := l[i];
                     dec(head[a[i]]);
                     if k[i] = 2 then
                        BEGIN
                              adj[ head[b[i]] ] := a[i];
                              c[ head[b[i]] ] := l[i];
                              dec(head[b[i]]);
                        END;
                END;
        END;

Procedure Dijkstra;
Var u,v,i,min : longint;
        BEGIN
               fillchar(f,sizeof(f),0);
               For i := 1 to n do d[i] := 999999;
               d[1] := 0; f[1] := 1;
               fillchar(free,sizeof(free),true);
               Repeat
                  min := maxlongint;
                  u := 0;
                  For i := 1 to n do
                    if free[i] and (d[i] < min) then
                      BEGIN
                            u := i;
                            min := d[i];
                      END;
                    if (u=0) or (u=n) then break;
                  free[u] := false;
                  For i := head[u] + 1 to head[u+1] do
                   BEGIN
                     v := adj[i];
                     if free[v] then
                        if d[v] > d[u] + c[i] then
                          BEGIN
                                d[v] := d[u] + c[i];
                                f[v] := f[u];
                          END
                            else if d[v] = d[u] + c[i] then
                               f[v] := f[v] + f[u];
                   END;
               until false;

        END;

Procedure Output;
        BEGIN
                Assign(fo,out); rewrite(fo);
                write(fo,d[n],' ',f[n]);
                close(fo);
        END;

BEGIN
      input;
      Dijkstra;
      output;
END.