Const   maxn = 60010;
Var     f       :       array [1..maxn] of int64;
        n,i,j       :       longint;

begin
      assign(input,'nspecial.in'); reset(input);
      assign(output,'nspecial.out'); rewrite(output);
      readln(n);
      f[1] := 1;
      for i := 1 to n+1 do
        begin
             for j := 2 to n+1 do
               if i*j <= n+1 then f[j*i] := f[i] + f[j*i]
                else break;
        end;
      writeln(f[n+1]);
end.