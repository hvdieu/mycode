Const   inp = '';
        out = '';
        h       :       array [1..4] of integer = (-2,-2,2,2);
        c       :       array [1..4] of integer = (-1,1,1,-1);
        maxn = 9;
Var     fi,fo   :       text;
        a       :       array [0..maxn,0..maxn] of longint;
        free    :       array [0..maxn,0..maxn] of boolean;
        d,d1,d2,d3,d4       :       array [0..maxn,0..maxn] of boolean;
        k       :       integer;
        res,sum,g1,g2,g3,g4,s     :       qword;

Procedure input;
Var i,j,u,v,c : longint;
        BEGIN
              assign(fi,inp); reset(fi);
              readln(fi,k);
              For i := 1 to 8 do
                For j := 1 to 8 do free[i,j] := true;
              For i := 1 to k do
                BEGIN
                    readln(fi,u,v,c);
                    a[u,v] := c;
                    s := s + c;
                    free[u,v] := false;
                END;
              close(fi);
        END;

Procedure updatexe(i1,j1 : integer); {$INLINE+}
Var t : integer;
        BEGIN
            For t := 1 to 8 do
            BEGIN
             if d[i1,t] then
              BEGIN
                sum := sum + a[i1,t];
                d[i1,t] := false;
              END;
             if d[t,j1] then
              BEGIN
                sum := sum + a[t,j1];
                d[t,j1] := false;
              END;
             END;
        END;

Procedure updatema(i2,j2 : integer); {$INLINE+}
Var t : integer;
        BEGIN
            For t := 1 to 4 do
            if (i2+h[t] <= 8) and (i2+h[t] >=1)
             and (j2+c[t] <=8) and (j2+c[t] >=1)
              then if d[i2+h[t],j2+c[t]] then
            BEGIN
                sum := sum + a[i2+h[t],j2+c[t]];
                d[i2+h[t],j2+c[t]] := false;
            END;
        END;

Procedure updatetuong(i3,j3 : integer); {$INLINE+}
Var t : integer;
BEGIN
     For t := 1 to 7 do
       BEGIN
            if (i3+t<=8) and (j3+t<=8) then
             if d[i3+t,j3+t] then
            BEGIN
                sum := sum + a[i3+t,j3+t];
                d[i3+t,j3+t] := false;
            END;
            if (i3+t<=8) and (j3-t>=1) then
             if d[i3+t,j3-t] then
            BEGIN
                sum := sum + a[i3+t,j3-t];
                d[i3+t,j3-t] := false;
            END;
            if (i3-t>=1) and (j3-t>=1) then
             if d[i3-t,j3-t] then
            BEGIN
                sum := sum + a[i3-t,j3-t];
                d[i3-t,j3-t] := false;
            END;
            if (i3-t>=1) and (j3+t<=8) then
              if d[i3-t,j3+t] then
            BEGIN
                sum := sum + a[i3-t,j3+t];
                d[i3-t,j3+t] := false;
            END;
       END;
END;

Procedure main; {$INLINE+}
Var i1,j1,i2,j2,i3,j3,i4,j4,t : integer;
        BEGIN
             fillchar(d,sizeof(d),true);
             sum := 0;
             For i1 := 1 to 8 do
               For j1 := 1 to 8 do
                 BEGIN
                     if free[i1,j1] then
                       BEGIN
                            free[i1,j1] := false;
                            g1 := sum;
                            d1 := d;
                            updatexe(i1,j1);
                            For i2 := 1 to 8 do
                              For j2 := 1 to 8 do
                               if free[i2,j2] then
                               BEGIN
                                   free[i2,j2] := false;
                                   g2 := sum;
                                   d2 := d;
                                   updatema(i2,j2);
                                   For i3 := 1 to 8 do
                                     For j3 := 1 to 8 do
                                       if free[i3,j3] then
                                        BEGIN
                                          free[i3,j3] := false;
                                          g3 := sum;
                                          d3 := d;
                                          updatetuong(i3,j3);
                                          For i4 := 1 to 8 do
                                            For j4 := 1 to 8 do
                                             if free[i4,j4] then
                                              BEGIN
                                                 free[i4,j4] := false;
                                                 d4 := d;
                                                 g4 := sum;
                                                 updatexe(i4,j4);
                                                 updatetuong(i4,j4);
                                                 if sum > res then res := sum;
                                                 if res = s then exit;
                                                 free[i4,j4] := true;
                                                 d := d4;
                                                 sum := g4;
                                              END;
                                          sum := g3;
                                          d := d3;
                                          free[i3,j3] := true;
                                        END;
                                   free[i2,j2] := true;
                                   sum := g2;
                                   d := d2;
                               END;
                            free[i1,j1] := true;
                            sum := g1;
                            d := d1;
                       END;
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
     main;
     output;
END.


