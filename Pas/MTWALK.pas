Const   inp = '';
        out = '';
        maxn = 111;
        h       :       array [1..4] of integer = (-1,0,1,0);
        c       :       array [1..4] of integer = (0,1,0,-1);
Var     fi,fo   :       text;
        a       :       array [1..maxn,1..maxn] of integer;
        cx,free      :       array [0..maxn+1,0..maxn+1] of boolean;
        qx,qy   :    array [1..10010] of integer;
        n,high,res,min,max,l       :       integer;
        left,right      :       longint;
        ok,cd      :       boolean;

Procedure input;
Var i,j : integer;
        BEGIN
              fillchar(cx,sizeof(cx),false);
              Assign(fi,inp); reset(fi);
              readln(fi,n);
              For i := 1 to n do
               BEGIN
                   For j := 1 to n do
                      BEGIN
                            read(fi,a[i,j]);
                            free[i,j] := true;
                      END;
                   readln(fi);
               END;
        END;

Function BFS(min,max : integer) : boolean;
Var u,v,k,px,py : integer;
        BEGIN
               BFS := false;
               left := 0;
               right := 1;
               qx[1] := 1; qy[1] := 1;
               cx[1,1] := false;
               if (a[1,1] < min) or (a[1,1] > max) then exit(false);
               While left < right do
                  BEGIN
                         inc(left);
                         px := qx[left];
                         py := qy[left];
                         For k := 1 to 4 do
                           if cx[px+h[k],py+c[k]] and (a[px+h[k],py+c[k]] >=min) and (a[px+h[k],py+c[k]] <= max) then
                              BEGIN
                                     cx[px+h[k],py+c[k]] := false;
                                     if (px + h[k] =n) and (py + c[k] = n) then exit(true);
                                     inc(right);
                                     qx[right] := px+h[k];
                                     qy[right] := py + c[k];
                              END;
                  END;
        END;

Procedure Find;
Var d,cuoi,giua : integer;
        BEGIN
              d := 0; cuoi := 111;
              While d <= cuoi do
                 BEGIN
                       giua := (d+cuoi) div 2;
                       high := giua;
                       ok := false;
                       For min := 0 to 110 - high do
                          BEGIN
                                max := min + high;
                                l := max;
                                cx := free;
                                if BFS(min,max)=true then
                                      ok := true;

                          END;
                       if ok then
                         BEGIN
                            cuoi := giua - 1;
                            res := giua;
                         END
                         else d := giua + 1;
                 END;
        END;

Procedure output;
        BEGIN
              assign(fo,out); rewrite(fo);
              write(fo,res);
              close(fo);
        END;

BEGIN
      input;
      find;
      output;
END.
