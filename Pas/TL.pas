uses math;
Const   maxn = 100;
Var     m,n,i,res,mina,minb,maxa,j     :       integer;

begin
    // assign(input,'tl.inp'); reset(input);
    // assign(output,'tl.out'); rewrite(output);
     readln(n,m);
     mina := maxint; minb := maxint;
     for i := 1 to n do
      begin
          read(j);
          mina := min(j,mina);
          maxa := max(j,maxa);
      end;
     for i := 1 to m do
      begin
          read(j);
          minb := min(j,minb);
      end;
     if (maxa >= minb) or (2*mina >= minb) then writeln(-1)
      else writeln(max(maxa,2*mina));
end.