Const   inp = '';
        out = '';
        maxn = 17;
Var     fi,fo   :       text;
        a       :       array [1..maxn] of longint;
        f       :       array [0..65536,0..maxn] of int64;
        n,k     :       longint;
        res     :       int64;

Procedure nhap;
Var i : longint;
        BEGIN
                Assign(fi,inp); reset(fi);
                readln(fi,n,k);
                For i := 1 to n do readln(fi,a[i]);
                close(fi);
        END;

Procedure main;
Var x,i,j,t    :   longint;
        BEGIN
              fillchar(f,sizeof(f),0);
              for i := 1 to n do
                f[1 shl (i-1),i] := 1;
              For i := 1 to 1 shl n - 1 do
                  For j := 1 to n do
                     if f[i,j] > 0 then
                        BEGIN
                              For t := 1 to n do
                                 if (t <> j) and ( (i shr (t-1) ) and 1 = 0) then
                                    if abs(a[t] - a[j]) > k then
                                        BEGIN
                                              x := i or (1 shl (t-1) );
                                              f[x,t] := f[x,t] + f[i,j];
                                        END;
                        END;
                     res := 0;
               for i := 1 to n do
                 res := res + f[1 shl n - 1,i];
               Assign(fo,out); rewrite(fo);
               writeln(fo,res);
               close(fo);
        END;

BEGIN
       nhap;
       main;
END.