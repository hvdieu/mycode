Const   inp = '';
        out = '';
        maxn = 1094785;
Var     fi,fo   :       text;
        a       :       array [1..maxn] of longint;
        s       :       array [0..maxn] of int64;
        smin     :       array [0..maxn] of int64;
        smax    :       array [0..maxn] of int64;
        n,res,min,max,t,amax,amin     :       int64;
        i       :       longint;

Procedure Main;
BEGIN
        s[0] := 0;
        For i := 1 to n do s[i] := s[i - 1] + a[i];

        smax[1] := s[1];
        smin[1] := s[1];
        smax[0] := 0;
        smin[0] := 0;
        if amax < 0 then
                BEGIN
                    write(fo,amax);
                    exit;
                END;
        if amin > 0 then
                BEGIN
                    write(fo,s[n] - amin);
                    exit;
                END;

        For i := 2 to n do
                BEGIN
                    if s[i] > smax[i - 1] then smax[i] := s[i]
                        else smax[i] := smax[i - 1];
                    if s[i] < smin[i - 1] then smin[i] := s[i]
                        else smin[i] := smin[i - 1];

                END;
        min := maxlongint;
        max := -maxlongint;
        For i := 1 to n - 1do
                BEGIN
                        t := s[i] - smin[i-1];
                        if t < s[i] then t := s[i];
                        if t > max then max := t;
                        t := s[i] - smax[i-1];
                        if t > s[i] then t := s[i];
                        if t < min then min := t;
                END;
        t := s[n] - smin[n-1];
        if t > max then max := t;
        t := s[n] - smax[n-1];
        if t < min then min := t;
        if max > s[n] - min then res := max
                else res := s[n] - min;
        write(fo,res);
END;


BEGIN
        Assign(fi,inp); reset(fi);
        readln(fi,n);
        amax := -maxlongint;
        amin := maxlongint;
        For i := 1 to n do
            BEGIN
                read(fi, a[i] );
                if a[i] > amax then amax := a[i];
                if a[i] < amin then amin := a[i];
            END;
        close(fi);
        Assign(fo,out);rewrite(fo);
        main;
        close(fo);

END.