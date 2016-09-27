Const   inp = '2.IN';
        out = 'VMCOUNT.OUT';
        maxn = 25;
        m    = 1000000000 + 7;
Var     fi,fo   :       text;
        n       :       integer;
        f       :       array [0..8388610,0..25] of longint;
        a       :       array [1..maxn,1..maxn] of char;
        i,j,k,x,res     :       longint;

BEGIN
        Assign(fi,inp); reset(fi);
        readln(fi, n);
        For i := 1 to n do
        BEGIN
                For j := 1 to n do read(fi,a[i,j]);
                readln(fi);
        END;
        close(fi);
        fillchar(f,sizeof(f),0);
        For i := 1 to n do
                f[1 shl (i-1),i] := 1;
        For i := 1 to 1 shl n - 1 do
                BEGIN
                    for j := 1 to n do
                        if f[i,j] > 0 then
                                for k := 1 to n do
                                   if (a[j,k] = '1') and ((i shr (k-1) and 1) =0 )then
                                        BEGIN
                                             x := i or (1 shl (k-1) );
                                                f[x,k] := f[i,j] + f[x,k];
                                             if f[x,k] > m then f[x,k] := f[x,k] mod m;
                                        END;
                END;
                res :=0;
        for j := 1 to n do
        BEGIN
         res := res + f[1 shl n -1,j];
         if res > m then res := res mod m;
        END;
        Assign(fo,out);rewrite(fo);
        write(fo,res);
        close(fo);

END.
