uses math;
Const   inp = 'SNUM.INP';
        out = 'SNUM.OUT';
        maxn = 19;
Var     fi,fo   :       text;
        sn      :       array [0..maxn*9*9] of boolean;
        fa,fb   :       array [0..19,0..1,0..maxn*9*9] of int64;
        a,b     :       int64;
        s1,s2   :       string;
        m,n     :       integer;

procedure input;
        BEGIN
              assign(fi,inp); reset(fi);
              readln(fi,a);
              readln(fi,b);
              close(fi);
        END;

Procedure init;
Var i,s,sum,j,k : longint;
    stop : boolean;
        BEGIN
              sn[1] := true; stop := false;
              str(a-1,s1); str(b,s2);
              n := length(s1);
              m := length(s2);
              Repeat
                 BEGIN
                     stop := true;
                     For i := 2 to m*9*9 do
                      if sn[i] = false then
                       BEGIN
                           s := i;
                           sum := 0;
                           While s > 0 do
                             BEGIN
                                 sum := sum + sqr(s mod 10);
                                 s := s div 10;
                             END;
                           if sn[sum] then
                              BEGIN
                                  sn[i] := true;
                                  stop := false;
                              END;
                       END;
                 END;
              Until stop;
        For i := 1 to m do
          For j := 0 to 1 do
            For k := 0 to m*9*9 do
              BEGIN
                  fa[i,j,k] := -1;
                  fb[i,j,k] := -1;
              END;
        END;

Function tinha(i,ok,s : integer) : int64;
Var j,x : integer;
    res : int64;
        BEGIN
              if i=n+1 then
                BEGIN
                     if sn[s] then exit(1)
                       else exit(0);
                END;
              if fa[i,ok,s] <> -1 then exit(fa[i,ok,s]);
              res := 0;
              if ok = 0 then
                BEGIN
                      For j := 0 to 9 do
                            res := res + tinha(i+1,0,s+sqr(j));
                END
                 else
                BEGIN
                      val(s1[i],x);
                      For j := 0 to x-1 do
                        res := res + tinha(i+1,0,s+sqr(j));
                      res := res + tinha(i+1,1,s+sqr(x));
                END;
             fa[i,ok,s] := res;
             tinha := res;
        END;

Function tinhb(i,ok,s : integer) : int64;
Var j,x : integer;
    res : int64;
        BEGIN
              if i=m+1 then
                BEGIN
                     if sn[s] then exit(1)
                       else exit(0);
                END;
              if fb[i,ok,s] <> -1 then exit(fb[i,ok,s]);
              res := 0;
              if ok = 0 then
                BEGIN
                      For j := 0 to 9 do
                            res := res + tinhb(i+1,0,s+sqr(j));
                END
                 else
                BEGIN
                      val(s2[i],x);
                      For j := 0 to x-1 do
                        res := res + tinhb(i+1,0,s+sqr(j));
                      res := res + tinhb(i+1,1,s+sqr(x));
                END;
             fb[i,ok,s] := res;
             tinhb := res;
        END;


Procedure output;
Var i : longint;
    res : int64;
        BEGIN
              assign(fo,out); rewrite(fo);
              a := a-1;
              res := tinha(1,1,0);
              res := tinhb(1,1,0) - res;
              write(fo,res);
              close(fo);

        END;

BEGIN
     input;
     init;
     output;
END.
