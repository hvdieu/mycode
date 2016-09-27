Const   maxn = 300001;

Type    canh = record
        l,r,x   :       longint;
        end;

Var     n,m,i     :       longint;
        e       :       array [1..maxn] of canh;
        res     :       array [1..maxn] of longint;


begin
      assign(input,'asd.inp'); reset(input);
      assign(output,'asd.out'); rewrite(output);
      readln(n,m);
      for i := 1 to m do with e[i] do read(l,r,x);
      for i := 1 to n do res[i] := -1;
      e[m+1].x := 0;
      for i := m downto 1 do
       res[e[i].x] := e[i+1].x;
      for i := 1 to m do

end.