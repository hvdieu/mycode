Const   maxn = 1000001;
Var     s,t,trace       :       array [0..maxn] of longint;
        a       :       array [1..maxn] of longint;
        n,i,res,l,r,kq1,kq2     :       longint;

begin
      assign(input,'sausage.inp'); reset(input);
      assign(output,'sausage.out'); rewrite(output);
      readln(n);
      for i := 1 to n do
        begin
            read(a[i]);
            s[i] := s[i-1] + a[i];
        end;
      t[n+1] := s[n]; trace[n+1] := n;
      t[n] := s[n]; trace[n] := n;
      kq1 := 0; kq2 := n+1;
      for i := n-1 downto 1 do
       if s[i] <= t[i+1] then
         begin
             t[i] := s[i];
             trace[i] := i;
         end
       else
         begin
             t[i] := t[i+1];
             trace[i] := trace[i+1];
         end;
      for i := 0 to n do
        begin
            l := s[i];
            r := s[n] - t[i];
            if l+r >= res then
              begin
                  res := l+r;
                  kq1 := i;
                  kq2 := trace[i]+1;
              end;
        end;
      writeln(res);
      writeln(kq1,' ',kq2);
end.
