Const   inp = '';
        out = '';
        maxn = 501;
Var     fi,fo   :       text;
        a       :       array [1..maxn,1..maxn] of longint;
        f       :       array [0..maxn,0..maxn] of longint;
        m,n,k,dt,x1,y1,x2,y2   :       longint;

Procedure input;
Var i,j  :  longint;
        BEGIN
              assign(fi, inp); reset(fi);
              readln(fi,m,n,k);
              for i := 1 to m do
                BEGIN
                  for j := 1 to n do read(fi,a[i,j]);
                  readln(fi);
                END;
              close(fi);
        END;

Procedure init;
Var i,j  :  longint;
        BEGIN

               for i := 1 to m do
                  for j := 1 to n do f[i,j] := f[i-1,j] + f[i,j-1] - f[i-1,j-1] + a[i,j];
               dt := n*m+1;
        END;

Procedure main;
Var l,r,i,u,v  :  longint;
        sum     :       longint;
        BEGIN
              if f[m,n] < k then exit;
              for l:=1 to m do
                for r:= l to m do
                        BEGIN
                            u := 1;
                            v := 1;
                            While (u <= v) and (v <= n) do
                                BEGIN
                                     sum := f[r,v] - f[r,u-1] - f[l-1,v] + f[l-1,u-1];
                                     if sum >= k then
                                         BEGIN
                                              if dt > (r-l+1)*(v-u+1) then
                                              BEGIN
                                                  dt := (r-l+1) * (v-u+1);
                                                  x1 := l;
                                                  x2 := r;
                                                  y1 := u;
                                                  y2 := v;
                                              END;
                                              inc(u);
                                         END
                                           else inc(v);
                                END;

                        END;
        END;

Procedure output;
BEGIN
     Assign(fo,out); rewrite(fo);
      if dt > m*n then write(fo,-1)
        else
          BEGIN
               writeln(fo,dt);
               write(fo,x1,' ',y1,' ',x2,' ',y2);
          END;
     close(fo);
END;

BEGIN
     input;
     init;
     main;
     output;
END.
