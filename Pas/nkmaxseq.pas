Const   inp = 'asd.inp';
        out = '';
        maxn = 50001;
Var     fi,fo   :       text;
        a       :       array [1..maxn] of longint;
        f       :       array [0..maxn] of longint;
        d       :       array [0..maxn] of boolean;
        n,p,i,j,pos,min,maxlength     :       longint;

BEGIN
        Assign(fi,inp); reset(fi);
        readln(fi,n,p);
        for i := 1 to n do readln(fi,a[i]);
        close(fi);

        f[0] := 0;
        for i := 1 to n do f[i] := f[i-1] + a[i];

        d[0] := true;
        min := 0;
        for i := 1 to n do
           if f[i] < min then
                BEGIN
                     min := f[i];
                     d[i] := true;
                END;

        pos := n;
        maxlength := -1;
        for i := n downto 0 do
           if d[i] then
            BEGIN
              for j := pos downto i+1 do
                 if f[j] - f[i] >=p then
                    BEGIN
                          if j-i > maxlength then maxlength := j-i;
                          break;
                    END;
              pos := j;
            END;
        Assign(fo,out); rewrite(fo);
        writeln(fo,maxlength);
        close(fo);


END.
