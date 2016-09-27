uses math;
const
    out = '51.out';

Var
    i,n : longint;

begin
     assign(output,out); rewrite(output);
     n := 100000;
     for i := 1 to n do writeln(n);
end.