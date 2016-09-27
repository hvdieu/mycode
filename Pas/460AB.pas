uses math;
Const
    inp = 'asd.inp';
    out = 'asd.out';

Var
    n,m,i  : longint;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
    readln(n,m);
    i := 1;
    while i <= n do
      begin
          if i mod m = 0 then inc(n);
          inc(i);
      end;
    writeln(n);
end.