Const   maxn = 50001;
Var     n,k     :       longint;
        head    :       array [1..maxn] of longint;
        adj     :       array [1..2*maxn] of longint;

begin
      assign(input,'journey.inp'); reset(input);
      assign(output,'journey.out'); rewrite(output);
      readln(n,k);
end.