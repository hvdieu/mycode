Const   inp = '';
        out = '';
        maxn = 6;
Var     fi,fo   :       text;
        f       :       array [0..64,0..30] of int64;
        bit1,bit2       :      array [1..maxn] of integer;
        m,n,t     :       integer;
        res     :   int64;

Procedure main;
Var i,j,tt,k,s    :    longint;
    ok  :       boolean;
        BEGIN
              fillchar(f,sizeof(f),0);
              For i := 0 to 1 shl m - 1 do f[i,1] := 1;


                 For j := 2 to n do
                    For i := 0 to 1 shl m - 1 do
                        BEGIN
                            For k := 1 to m do bit1[k] := (i shr (k-1) ) and 1;
                            For tt := 0 to 1 shl m - 1 do
                               BEGIN
                                     ok := true;
                                     for k := 1 to m do bit2[k] := (tt shr (k-1)) and 1;
                                     for k := 1 to m - 1 do
                                         BEGIN
                                              s := bit1[k] + bit1[k+1] + bit2[k] + bit2[k+1];
                                              if (s=4) or (s=0) then
                                                 BEGIN
                                                       ok := false;
                                                       break;
                                                 END;
                                         END;
                                     if ok then f[i,j] := f[i,j] + f[tt,j-1];
                               END;
                        END;
                 res := 0;
                 For i := 0 to 1 shl m - 1 do res := res + f[i,n];
                 writeln(fo,res);
        END;

Procedure nhap;
Var t,st,temp   :   integer;
        BEGIN
              Assign(fi,inp); reset(fi);
              Assign(fo,out); rewrite(fo);
              readln(fi,t);
              for st := 1 to t do
                  BEGIN
                      readln(fi,m,n);
                      if m > n then
                         BEGIN
                              temp := m;
                              m := n;
                              n := temp;
                         END;
                       main;
                  END;
              close(fi);
              close(fo);
        END;

BEGIN
      nhap;
END.