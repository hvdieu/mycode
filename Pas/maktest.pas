Const   out = 'VOGCDSUM.INP';
Var     n,i       :       longint;

begin
     randomize;
     assign(output,out) ;rewrite(output);
     n := 100;
     writeln(n);
     for i := 1 to n do write(random(1000000000000)+1,' ');
end.
