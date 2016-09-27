Const
	out = 'asd.inp';

var
	n,i : longint;

begin
    assign(output,out); rewrite(output);
    n := 400000;
    for i := 1 to n do writeln(1);
end.