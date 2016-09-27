Const   inp = '';
        out = '';
        maxn = 500000;
Var     fi,fo   :       text;
        n,m,k,s,st,i,j,dau     :       longint;
        a,f       :       array [1..maxn] of longint;

BEGIN
      assign(fi,inp); reset(fi);
      readln(fi,n,m);
      For i := 1 to n do read(fi,a[i]);
      assign(fo,out); rewrite(fo);
      close(fi);
      s := 0;
      For i := 1 to n do s := s + a[i];
      k := s div m;
      j := 0;
      For i := 1 to n do
        BEGIN
             While a[i] > 0 do
               BEGIN
                    inc(j);
                    f[j] := i;
                    dec(a[i]);
               END;
        END;
      dau := 0;
      For i := 1 to k do
          BEGIN
               inc(dau);
               st := dau;
               For j := 1 to m do
                 BEGIN
                      write(fo,f[st],' ');
                      st := st + k;
                 END;
               writeln(fo);
          END;
      close(fo);

END.
