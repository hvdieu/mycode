Const   inp = 'NUM6.INP';
        out = 'NUM6.OUT';
        maxn = 1000001;
Var     fi,fo   :       text;
        a       :       array [1..maxn] of int64;
        free    :       array [1..maxn] of boolean;
        d       :       array [1..12] of boolean;
        so      :       array [1..12] of int64;
        n       :       longint;
        sum,res : int64;

Procedure input;
Var i : longint;
        BEGIN
              assign(fi,inp); reset(fi);
              readln(fi,n);
              For i := 1 to n do read(fi,a[i]);
              close(fi);
        END;

Procedure xuly(n : integer);
Var i1,i2,i3,i4,i5,i6 : longint;
        BEGIN
         For i1 := 1 to n do
                       if d[i1] then
                         BEGIN
                            d[i1] := false;
                            For i2 := 1 to n do
                              if d[i2] then
                                BEGIN
                                     d[i2] := false;
                                     For i3 := 1 to n do
                                      if d[i3] then
                                        BEGIN
                                             d[i3] := false;
                                             For i4 := 1 to n do
                                                if d[i4] then
                                                   BEGIN
                                                        d[i4] := false;
                                                        For i5 := 1 to n do
                                                         if d[i5] then
                                                          BEGIN
                                                               d[i5] := false;
                                                               For i6 := 1 to n do
                                                                 if d[i6] then
                                                                   BEGIN
                                                                       d[i6] := false;
                                                                       sum := 0;
                                                                       sum := a[i1] * a[i2] * a[i3] + a[i4] * a[i5] * a[i6];
                                                                       if sum > res then res := sum;
                                                                       d[i6] := true;
                                                                   END;

                                                               d[i5] := true;
                                                          END;
                                                        d[i4] := true;
                                                   END;
                                             d[i3] := true;
                                        END;
                                     d[i2] := true;
                                END;
                            d[i1] := true;
                         END;
        END;

Procedure main;
Var i,j,i1,i2,i3,i4,i5,i6,min,max,vt : longint;
        BEGIN
             For i := 1 to n do free[i] := true;
             res := 1;
             For i := 1 to 18 do res := res * 10;
             res := -2*res;
             fillchar(d,sizeof(d),true);
             if n < 12 then
                BEGIN
                       xuly(n);
                END
                  else
                    BEGIN
                         For j := 1 to 6 do
                           BEGIN
                                min := maxlongint;
                                For i := 1 to n do
                                  if (a[i] <= min) and (free[i]) then
                                    BEGIN
                                          vt := i;
                                          min := a[i];
                                    END;
                                free[vt] := false;
                                so[j] := min;
                           END;
                         For j := 7 to 12 do
                           BEGIN
                                max := -maxlongint;
                                For i := 1 to n do
                                  if (a[i] >= max) and (free[i]) then
                                   BEGIN
                                        vt := i;
                                        max := a[i];
                                   END;
                                free[vt] := false;
                                so[j] := max;
                           END;

                         For i := 1 to 12 do a[i] := so[i];
                         xuly(12);
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
