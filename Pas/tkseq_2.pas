Uses math;
Const   maxn = 501;
Var     n,i,k,t,j   :       longint;
        f,g       :       array [0..maxn,0..maxn] of int64;
        a       :       array [1..maxn] of int64;
        res     :       int64;

begin
      assign(input,'TKSEQ.INP'); reset(input);
      assign(output,'TKSEQ.OUT'); rewrite(output);
      readln(n,k);
      for i := 0 to n do
       for j := 0 to n do
         begin
           g[i,j] := - 1 shl 50;
           f[i,j] := - 1 shl 50;
         end;
      for i := 1 to n do read(a[i]);
      for i := 1 to n do
       begin
         f[1,i] := a[i];
         g[1,i] := max(g[1,i-1],a[i]);
       end;
      for i := 2 to 3*k do
        begin
             for j := i to n do
              begin
                if i mod 3 = 2 then
                 f[i,j] := g[i-1,j-1] - a[j]
                  else f[i,j] := g[i-1,j-1]+a[j];
                g[i,j] := max(g[i,j-1],f[i,j]);
              end;
        end;
      res := -1 shl 50;
      for i := 3*k to n do
       if f[3*k,i] > res then res := f[3*k,i];
      write(res);
end.
