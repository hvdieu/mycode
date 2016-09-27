Uses math;
Const   inp = '';
        out = '';
        maxn = 2001;

Var     n,i,j : longint;
        c,s : array [1..maxn] of longint;
        f : array [0..maxn,0..maxn] of longint;
        check : array [0..maxn,0..maxn] of boolean;

function call(i,j : longint) : longint;
var k,sum,res : longint;
  begin
      if i > n then exit(0);
      if j=0 then exit(0);
      if check[i,j] then exit(f[i,j]);
      sum := 0; res := 0;
      res := max(res,call(i,j-1));
      if i+2*j-1<=n then res := max(res,s[i]-call(i+2*j,2*j));
      if i+2*j-2<=n then res := max(res,s[i]-call(i+2*j-1,2*j-1));
      check[i,j] := true;
      f[i,j] := res;
      exit(res);
  end;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
    readln(n);
    for i := 1 to n do read(c[i]);
    for i := n downto 1 do s[i] := s[i+1]+c[i];
    writeln(call(1,1));
end.
