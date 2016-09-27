Const   inp = '';
        out = '';
        maxn = 1010;
Var     fi,fo   :       text;
        f       :       array [0..1,0..maxn,0..maxn] of longint;
        a       :       array [1..maxn,1..maxn] of longint;
        m,n,q,st,i,j     :       longint;
        res     :       longint;

Function min(xx,yy : longint) : longint;
        BEGIN
              if xx < yy then min := xx
                else min := yy;
        END;

Procedure init; {$INLINE+}
Var i,j,t : longint;
        BEGIN
             For t := 0 to 1 do
               For i := 1 to m do
                 For j := 1 to n do
                   f[t,i,j] := 999999999;
             f[0,1,1] := a[1,1]; f[1,1,1] := a[1,1];
             For i := 1 to m do
               f[0,1,i] := a[1,i];
             For i := 1 to n do
               f[1,i,1] := a[i,1];
             For i := 1 to m do
                   For j := 1 to i-1 do f[0,i,1] := min(f[0,i,1],a[j,1] + a[j+1,1]);
             For i := 1 to n do
                   For j := 1 to i-1 do f[1,1,i] := min(f[1,1,i],a[1,j] + a[1,j+1]);

        END;

Procedure tinh; {$INLINE+}
Var i,j,t : longint;
        BEGIN
            For i := 2 to m do
              For j := 2 to n do
                For t := 0 to 1 do
                  BEGIN
                      if t = 0 then f[t,i,j] := min(f[0,i-1,j],f[1,i-1,j] + a[i,j])
                        else f[t,i,j] := min(f[1,i,j-1],f[0,i,j-1] + a[i,j]);
                  END;
        END;

BEGIN
     assign(fi,inp); reset(fi);
     assign(fo,out); rewrite(fo);
     readln(fi,q);
     For st := 1 to q do
      BEGIN
        readln(fi,m,n);
        For i := 1 to m do
         BEGIN
           For j := 1 to n do read(fi,a[i,j]);
           readln(fi);
         END;
         if (m = 0) or (n=0) then writeln(fo,0)
         else
         BEGIN
                init;
                tinh;
                res := min(f[0,m,n],f[1,m,n]);
                writeln(fo,res);
         END;
      END;
     close(fi); close(fo);

END.