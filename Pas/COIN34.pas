Const   inp = '';
        out = '';
        maxn = 367980;
Var     fi,fo   :       text;
        a       :       array [1..34] of longint;
        f       :       array [0..maxn] of integer;
        b       :       array [0..21] of longint;
        x,res,sum,t       :       longint;
        s       :       int64;

Procedure Try(i,k : integer);
Var j : integer;
        BEGIN
             For j := b[i-1] + 1 to 20-k+i do
                 BEGIN
                       b[i] := j;
                       s := s + a[b[i]];
                       if i = k then f[s] := k
                         else try(i+1,k);
                       s := s - a[b[i]];
                 END;
        END;

Procedure ql(i,k : integer);
Var j,kq : integer;
        BEGIN
              For j := b[i-1] + 1 to 34-k+i do
                 BEGIN
                        b[i] := j;
                        s := s + a[b[i]];
                        if i = k then
                          BEGIN
                               if (s <= x) and ( x - s <= sum ) then
                                  BEGIN
                                        if f[x-s] > 0 then
                                        BEGIN
                                        kq := k + f[x-s];
                                        if kq > res then res := kq;
                                        END;
                                  END;
                          END
                             else ql(i+1,k);
                        s := s - a[b[i]];
                 END;
        END;

Procedure init;
Var i,k : longint;
        BEGIN
              a[1] := 2;
              a[2] := 3;
              a[3] := 5;
              s := 0;
              b[0] := 0;
              sum := a[1] + a[2] + a[3];
              fillchar(f,sizeof(f),0);
              For i := 4 to 20 do
               BEGIN
                   a[i] := a[i-1] + a[i-2] + a[i-3];
                   sum := sum + a[i];
               END;
              for i := 21 to 34 do a[i] := a[i-1] + a[i-2] + a[i-3];
              For k := 1 to 20 do try(1,k);
        END;

Procedure input;
Var st,k : longint;
        BEGIN
               Assign(fi,inp); reset(fi);
               Assign(fo,out); rewrite(fo);
               init;
               readln(fi,t);
               For st := 1 to t do
                  BEGIN
                        readln(fi,x);
                        res := -1;
                        if (x <= a[20]) then
                           if f[x] > 0 then res := f[x];
                        s := 0;
                        b[0] := 20;
                        for k := 1 to 14 do ql(1,k);
                        writeln(fo,'Case #',st,': ',res);
                  END;
               close(fi); close(fo);
        END;

BEGIN
      input;
END.