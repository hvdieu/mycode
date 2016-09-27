Uses math;
Const out = 'VOBRACK.INP';
Var	m,n,i,j,l : longint;
   a : array [0..1] of char;

begin
    randomize;
    assign(output,out); rewrite(output);
    n := 10; m := 10;
    a[0] := '('; a[1] := ')';
    writeln(n);
    for i := n downto 1 do
      begin
          l := random(m)+1;;
          for j := 1 to l do write(a[random(2)]);
          writeln;
      end;
end.
