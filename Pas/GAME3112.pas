Const   inp = '';
        out = '';
        maxn = 12;
Var     fi,fo   :       text;
        a       :       array [1..maxn] of integer;
        m,d,i,j     :       integer;

BEGIN
      assign(fi,inp); reset(fi);
      readln(fi,d,m); close(fi);
      assign(fo,out); rewrite(fo);
      For i := 1 to 9 do a[i] := i+19;
      a[10] := 31; a[11] := 29; a[12] := 30;
      if d = a[m] then write(fo,'LOSS')
        else
          BEGIN
                if d > a[m] then
                 BEGIN
                   For j := m+1 to 12 do
                     if a[j] = d then write(fo,a[j],' ',j);
                 END
                  else write(fo,a[m],' ',m);
          END;
      close(fo);

END.