
























































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































Const   maxn = 1001;
Var     deg     :       array [1..maxn] of longint;
        n,i       :       longint;

begin
    assign(input,'pie.inp'); reset(input);
    assign(output,'pie.out'); rewrite(output);
    readln(n);
    for i := 1 to n do
      begin
          read(x,y);
          inc(deg[x]); inc(deg[y]);
      end;
end.
























































































































































