{$Q-}
Const   inp = '';
        out = '';
        maxn = 100010;

Var     fi,fo   :       text;
        vala,valb,pw : array [0..maxn] of int64;
        a,b     : ansistring;
        i,p,base,max,min,n,m,res       : longint;
BEGIN
       Assign(fi,inp); reset(fi);
       readln(fi,a); readln(fi,b);
       close(fi);
       n := length(a); m := length(b);
       if m < n then
          BEGIN
              min := m;
              max := n;
          END
             else
               BEGIN
                    min := n;
                    max := m;
               END;
       base := 73471;
       pw[0] := 1;
       For i := 1 to max do pw[i] := pw[i-1] * base;
       vala[0] := 0;
       valb[0] := 0;
       for i := 1 to n do vala[i] := vala[i-1] * base + ord(a[i]);
       FOr i := 1 to m do valb[i] := valb[i-1] * base + ord(b[i]);
       res := 0;

       for p := min downto 0 do
          BEGIN
                if valb[p] = vala[n] - vala[n-p] * pw[p] then
                   BEGIN
                      res := p;
                      break;
                   END;
          END;
       assign(fo,out); rewrite(fo);
       For i := 1 to n do write(fo,a[i]);
       for i := 1+res to m do write(fo,b[i]);
       close(fo);
END.
