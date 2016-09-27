const
	out = 'a.inp';

var
	i : longint;

begin
    assign(output,out); rewrite(output);
    for i := 1 to 2000 do write('a');
    writeln;
    write('a');
end.