Const   inp = '';
        out = '';
        maxn = round(1e6);
        m = round(1e9) + 7;
Var     fi,fo : text;
        n,k,i,j     :       longint;
        tg      :   int64;
        a       :       array [1..maxn] of int64;
BEGIN
        Assign(fi,inp);reset(fi);
        readln(fi,n,k);
        for i := 1 to k do
           read(fi,a[i]);
        For i := k+1 to n do
                BEGIN
                    tg := 1;
                    for j := i - k to i-1 do
                     tg := tg * a[j];
                     if tg > m then tg := tg mod m;
                    a[i] := tg;
                END;
        Assign(fo,out);rewrite(fo);
        write(fo,a[n]);
        close(fo);
END.