Const   inp = '';
        out = '';
        maxn = 100001;
Var     fi,fo   :       text;
        f       :       array [0..maxn] of longint;
        n,k,i   :       longint;

BEGIN
      assign(fi,inp); reset(fi);
      assign(fo,out); rewrite(fo);
      readln(fi,n,k);
      f[0] := 1;
      For i := 1 to n do
       BEGIN
        if i-k-1 <= 0 then f[i] := f[i-1] + 1
          else f[i] := f[i-1] + f[i-k-1];
        f[i] := f[i] mod 2111992;
       END;
      write(fo,f[n]);
      close(fi);
      close(fo);

END.