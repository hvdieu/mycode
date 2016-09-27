Uses math;
Const
	out = 'VQUERY.INP';
    x = 100;

Var
	n,r,q,i : longint;

begin
	randomize;
    assign(output,out); rewrite(output);
	n := 10;
    writeln(n);
    for i := 1 to n do write(random(x)+1,' ');
    r := 1; q := 10;
    writeln(r,' ',q);
    for i := 1 to q do
      writeln(random(3)+1,' ',random(x)+1,' ',random(x)+1,' ',random(x)+1,' ',random(x)+1);
end.
