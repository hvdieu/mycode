Const   maxn = 1000001;
Var     t,i,n       :       longint;
        sum       :       array [0..maxn] of double;

begin
      assign(input,'FACT.INP'); reset(input);
      assign(output,'FACT.OUT'); rewrite(output);
      readln(t);
      for i := 1 to 1000001 do sum[i] := sum[i-1] + ln(i)/ln(10);
      while t > 0 do
        begin
            dec(t);
            readln(n);
            writeln(trunc(sum[n])+1);
        end;
end.