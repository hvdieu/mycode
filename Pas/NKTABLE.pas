Const   inp = '';
        out = '';
        maxn = 501;
        h       :       array [1..4] of integer = (-1,0,1,0);
        c       :       array [1..4] of integer = (0,-1,0,1);
Var     fi,fo   :       text;
        a       :       array [1..maxn,1..maxn] of integer;
        cx,free,tt      :       array [0..maxn,0..maxn] of boolean;
        m,n     :       integer;
        dem     :       longint;
        kq      :     array [1..1500] of integer;
        qx,qy,kc   :     array [1..250000] of integer;

Procedure input;
Var i,j : longint;
        BEGIN
              assign(fi,inp); reset(fi);
              readln(fi,m,n);
              For i := 1 to m do
                For j := 1 to n do read(fi,a[i,j]);
              close(fi);
        END;


Procedure DFS(i,j : integer);
Var k : integer;
        BEGIN
              free[i,j] := false;
              tt[i,j] := true;
              For k := 1 to 2 do
                if free[i+h[k],j+c[k]] then
                  BEGIN
                        tt[i+h[k],j+c[k]] := true;
                        free[i+h[k],j+c[k]] := false;
                        DFS(i+h[k],j+c[k]);
                  END;
        END;

Procedure main;
Var i,j,left,right,k,min,vt,u,v,t : longint;
        BEGIN
              fillchar(cx,sizeof(cx),false);
              fillchar(free,sizeof(free),false);
              For i := 1 to m do
                For j := 1 to n do
                  if a[i,j] <> 2 then
                    BEGIN
                      cx[i,j] := true;
                      free[i,j] := true;
                    END;

              fillchar(tt,sizeof(tt),false);
              DFS(m,n);
              dem := 1;
              left := 0; right := 1;
              qx[1] := 1; qy[1] := 1;
              kc[1] := 1;
              While left < right do
                BEGIN
                     inc(left);
                     min := -1;
                     vt := left;
                     while kc[vt] = kc[vt+1] do inc(vt);
                     For t := left to vt do
                       if a[qx[t],qy[t]] > min then min := a[qx[t],qy[t]];
                     kq[kc[left]] := min;
                     for t := left to vt do
                      if a[qx[t],qy[t]] = min then
                       BEGIN
                            u := qx[t];
                            v := qy[t];
                            For k := 3 to 4 do
                              if tt[u+h[k],v+c[k]] and cx[u+h[k],v+c[k]] then
                                BEGIN
                                      inc(right);
                                      qx[right] := u+h[k];
                                      qy[right] := v+c[k];
                                      kc[right] := kc[t] + 1;
                                      cx[u+h[k],v+c[k]] := false;
                                      if (u+h[k]=m) and (v+c[k]=n) then dem := kc[t] + 1;
                                END;
                       END;
                    left := vt;
                END;
        END;

Procedure output;
Var i : longint;
        BEGIN
              assign(fo,out); rewrite(fo);
              For i := 1 to dem do write(fo,kq[i]);
              close(fo);
        END;

BEGIN
      input;
      main;
      output;
END.
