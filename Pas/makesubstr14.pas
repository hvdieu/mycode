Uses math;
Const
	out = '1.in';

Var
	m,n,i,j : longint;


begin
    randomize;
    assign(output,out); rewrite(output);
    m := 1000; n := 1000;
    for i := 1 to m do write(chr(random(10)+ord('a')));
    writeln;
    for i := 1 to n do write(chr(random(10)+ord('a')));
end.
