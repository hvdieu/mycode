uses math;
Const   maxn = 201;
Var     a,b     :       string;
        m,n,i,j,t :       longint;
        f       :       array [0..maxn] of longint;

begin
      assign(input,'STR.INP'); reset(input);
      assign(output,'STR.OUT'); rewrite(output);
      readln(t);
      while t > 0 do
        begin
            dec(t);
            readln(a);
            readln(b);
            n := length(a);
            for i := 1 to n do f[i] := 999999999;
            f[0] := 0;
            for i := 1 to n do
             if a[i] = b[i] then f[i] := f[i-1]
              else
               begin
                   f[i] := f[i-1]+1;
                   for j := i-1 downto 1 do
                    if a[j] <> b[j] then f[i] := min(f[i],f[j-1]+1)
                     else break;
               end;
            writeln(f[n]);
        end;
end.