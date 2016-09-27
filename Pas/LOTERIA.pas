{$H+}
Uses math;
Const   maxn = 500001;
Var     n,i,kq       :       longint;
        s       :       string;
        f       :       array [1..maxn] of longint;
{***************************************************************************}
begin
     assign(input,'LOTERIA.INP'); reset(input);
     assign(output,'LOTERIA.OUT'); rewrite(output);
     readln(n);
     readln(s);
     f[1] := 0;
     for i := 2 to n do
      if s[i] = s[i-1] then f[i] := f[i-2]+1
       else f[i] := f[i-1];
     writeln(f[n]);
end.