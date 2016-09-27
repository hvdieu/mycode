Const   inp = '';
        out = '';
        maxn = 1001;
        max = 1e6-1;
Var     fi,fo   :       text;
        a       :       array [1..maxn,1..maxn] of extended;
        x,y     :       array [1..maxn] of double;
        d       :       array [0..maxn] of extended;
        free    :       array [1..maxn] of boolean;
        n,w       :       longint;
        m,res,min       :       extended;

Procedure nhap;
Var i,j,xx,yy : longint;
        BEGIN
              Assign(fi, inp); reset(fi);
              readln(fi,n,w);
              readln(fi,m);
              For i := 1 to n do readln(fi, x[i], y[i]);
              for i := 1 to n do
                for j := 1 to n do
                  if i=j then a[i,j] := 0
                    else
                      BEGIN
                       a[i,j] := sqrt( sqr(x[i] - x[j]) + sqr(y[i] - y[j]));
                       if a[i,j] > m then a[i,j] := max;
                       a[j,i] := a[i,j];

                      END;
              for i := 1 to w do
                BEGIN
                     readln(fi,xx,yy);
                     a[xx,yy] := 0;
                     a[yy,xx] := 0;
                END;
              close(fi);
        END;



Procedure Dijkstra;
Var i,j,u,v  :  longint;
        BEGIN
              fillchar(free, sizeof(free), true);
              res := 0;
              for i := 1 to n do d[i] := max;
              d[1] := 0;
              repeat
                     BEGIN
                          u := 0; min := max;
                          for i := 1 to n do
                              if free[i] and (d[i] < min) then
                                BEGIN
                                      min := d[i];
                                      u := i;
                                END;
                              if (u=0) then break;
                              free[u] := false;
                              for v := 1 to n do
                                 if free[v] and (d[v] > d[u] + a[u,v]) then d[v] := d[u] + a[u,v];
                     END;
                       until false;

        END;

BEGIN
     nhap;
     Assign(fo,out) ; rewrite(fo);
     dijkstra;
     if free[n] then write(fo,-1)
       else write(fo,trunc(d[n]*1000));
     close(fo);
END.

