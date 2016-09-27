Uses math;
Const
	out = 'test.inp';
    maxn = 1001;

var i : longint;

begin
    assign(output,out); rewrite(output);
    writeln(1);
    writeln(20);
    for i := 1 to 20 do write(i,' ');
end.
