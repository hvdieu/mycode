Const   maxn = 100001;
Var     i,n,x,c,j     :       longint;
        a       :   array [1..maxn] of longint;

begin
      assign(input,'pairing.inp'); reset(input);
      assign(output,'pairing.out'); rewrite(output);
      readln(n,c);
      for i := 1 to c do
        begin
            readln(x);
            while x > 0 do
              begin
                  inc(j); a[j] := i; dec(x);
              end;
        end;
      for i := 1 to n div 2 do
       writeln(a[i],' ',a[i+n div 2]);
end.

