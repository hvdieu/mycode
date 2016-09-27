Const   inp = 'DEMSO.INP';
        out = '';
        maxn = 17;
Var     fi,fo   :       text;
        a,b,kq     :       int64;
        d,k,m,n     :       longint;
        fa,fb       :       array [0..maxn,0..1,0..1,0..9,0..maxn] of int64;
        s1,s2   :       string;

Procedure input;
        BEGIN
              assign(fi,inp); reset(fi);
              read(fi,a,b,d,k);
              close(fi);
        END;

Procedure init;
Var i1,i2,i3,i4,i5 : integer;
        BEGIN
              str(a-1,s1); m := length(s1);
              str(b,s2); n := length(s2);
              For i1 := 1 to n do
                For i2 := 0 to 1 do
                  For i3 := 0 to 1 do
                    For i4 := 0 to 9 do
                      For i5 := 0 to n do
                       BEGIN
                           fa[i1,i2,i3,i4,i5] := -1;
                           fb[i1,i2,i3,i4,i5] := -1;
                       END;


        END;

Function tinha(i,ok,kt,cs,dem : integer) : int64;
Var j,x : integer;
    res : int64;
        BEGIN
              if dem > k then exit(0);
              if i = m+1 then exit(1);
              if fa[i,ok,kt,cs,dem] <> -1 then exit(fa[i,ok,kt,cs,dem]);
              res := 0;
              if ok=0 then
                BEGIN
                  if kt = 1 then
                   BEGIN
                     For j := 0 to 9 do
                       if abs(j-cs) <= d then
                        res := res + tinha(i+1,0,1,j,dem+1)
                         else res := res + tinha(i+1,0,1,j,dem);
                   END
                     else if kt = 0 then
                   BEGIN
                     For j := 1 to 9 do res := res + tinha(i+1,0,1,j,dem);
                     res := res + tinha(i+1,0,0,0,dem);
                   END;
                END
                  else if ok = 1 then
                BEGIN
                     val(s1[i],x);
                     if kt = 1 then
                        BEGIN
                            For j := 0 to x do
                            BEGIN
                             if j < x then
                              BEGIN
                              if abs(j-cs) <= d then
                                res := res + tinha(i+1,0,1,j,dem+1)
                                 else res := res + tinha(i+1,0,1,j,dem);
                              END
                              else if j = x then
                                if abs(x-cs) <= d then res := res + tinha(i+1,1,1,x,dem+1)
                                   else res := res + tinha(i+1,1,1,x,dem);
                            END;
                        END
                          else if kt = 0 then
                        BEGIN
                            For j := 0 to x do
                             BEGIN
                                if (j > 0) and (j<x) then
                                   res := res + tinha(i+1,0,1,j,dem)
                                else if j = 0 then
                                   res := res + tinha(i+1,0,0,0,dem)
                                else if j = x then
                                   res := res + tinha(i+1,1,1,x,dem);
                             END;
                        END;
                END;
              fa[i,ok,kt,cs,dem] := res;
              tinha := res;
        END;

Function tinhb(i,ok,kt,cs,dem : integer) : int64;
Var j,x : integer;
    res : int64;
        BEGIN
              if dem > k then exit(0);
              if i = n+1 then exit(1);
              if fb[i,ok,kt,cs,dem] <> -1 then exit(fb[i,ok,kt,cs,dem]);
              res := 0;
              val(s2[i],x);
              if ok=0 then
                BEGIN
                  if kt = 1 then
                   BEGIN
                        For j := 0 to 9 do
                       if abs(j-cs) <= d then
                        res := res + tinhb(i+1,0,1,j,dem+1)
                         else res := res + tinhb(i+1,0,1,j,dem);
                   END
                     else if kt = 0 then
                   BEGIN
                     For j := 1 to 9 do res := res + tinhb(i+1,0,1,j,dem);
                     res := res + tinhb(i+1,0,0,0,dem);
                   END;
                END
                  else if ok = 1 then
                BEGIN

                     if kt = 1 then
                        BEGIN
                            For j := 0 to x do
                            BEGIN
                             if j < x then
                              BEGIN
                              if abs(j-cs) <= d then
                                res := res + tinhb(i+1,0,1,j,dem+1)
                                 else res := res + tinhb(i+1,0,1,j,dem);
                              END
                              else if j = x then
                                if abs(x-cs) <= d then res := res + tinhb(i+1,1,1,x,dem+1)
                                   else res := res + tinhb(i+1,1,1,x,dem);
                            END;
                        END
                          else if kt = 0 then
                        BEGIN
                            For j := 0 to x do
                             BEGIN
                                if (j > 0) and (j<x) then
                                   res := res + tinhb(i+1,0,1,j,dem)
                                else if j = 0 then
                                   res := res + tinhb(i+1,0,0,0,dem)
                                else if j = x then
                                   res := res + tinhb(i+1,1,1,x,dem);
                             END;
                        END;
                END;
            fb[i,ok,kt,cs,dem] := res;
            tinhb := res;
        END;

Procedure main;
        BEGIN
             init;
             a := a - 1;
             kq := tinhb(1,1,0,0,0);
             kq := kq - tinha(1,1,0,0,0);
             assign(fo,out); rewrite(fo);
             write(fo,kq);
             close(fo);
        END;

BEGIN
      input;
      main;
END.
