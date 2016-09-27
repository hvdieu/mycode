Const   inp = '1.in';
        out = 'clear.out';
        maxn = 17;
Var     fi,fo   :       text;
        n,m,d,c,mid,g1,g2,kq     :       qword;
        t       :       integer;
        sn      :       array [0..maxn*9*9] of boolean;
        fa,fb      :       array [0..maxn,0..1,0..maxn*9*9] of int64;
        l1,l2,st,i,j,k      :       integer;
        s1,s2      :       string;


Procedure init;
Var i,s,sum,j,k : longint;
    stop : boolean;
        BEGIN
              stop := false;
              sn[1] := true;
              For i := 1 to 17 do
               For j := 0 to 1 do
                For k := 0 to 17*9*9 do
                   BEGIN
                     fa[i,j,k] := -1;
                     fb[i,j,k] := -1;
                   END;
              Repeat
                 BEGIN
                     stop := true;
                     For i := 2 to 17*9*9 do
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
        END;

Function tinha(i,ok,s : integer) : int64;
Var j,x : integer;
    res : qword;
        BEGIN
              if i=l1+1 then
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

Function check(s : qword) : boolean;
Var sum : longint;
        BEGIN
        sum := 0;
        While s > 0 do
          BEGIN
                sum := sum + sqr(s mod 10);
                s := s div 10;
          END;
           if sn[sum] then exit(true)
            else exit(false);
        END;

Function tinhb(i,ok,s : integer) : qword;
Var j,x : integer;
    res : qword;
        BEGIN
              if i=l2+1 then
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

Procedure khoitao;
Var i,j,t : longint;
        BEGIN
            str(mid,s2); l2 := length(s2);
        END;

Procedure find;
        BEGIN
             d := n+m;
             c := 10000000;
             While d <= c do
               BEGIN
                   mid := (d+c) div 2;
                   khoitao;
                   g2 := tinhb(1,1,0);
                   if g2 - g1 > m then c := mid -  1
                     else if g2 - g1 < m then d := mid + 1
                      else if g2 - g1 = m then
                        BEGIN
                            if check(mid) then
                              BEGIN
                                  kq := mid;
                                  exit;
                              END
                               else c := mid - 1;
                        END;
               END;
        END;

BEGIN
      assign(fi,inp); reset(fi);
      assign(fo,out); rewrite(fo);
      readln(fi,t);
      init;
      For st := 1 to t do
        BEGIN
             readln(fi,n,m);
             str(n,s1); l1 := length(s1);
             g1 := tinha(1,1,0);
             Find;
             writeln(fo,kq);
        END;
      close(fi); close(fo);
END.
