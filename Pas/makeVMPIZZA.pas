Uses math;
Const
  out = 'input.txt';
  m = 100000;

Var
  n : longint;
  i, t, a, b : longint;

begin
    randomize;
    assign(output, out); rewrite(output);
    n := 1000;
    writeln(n);
    for i := 1 to n do
      writeln(random(m)+1,' ' ,random(m)+1, ' ',random(m)+1);
end.
