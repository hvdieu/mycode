uses math;
const
	out = 'petrolm.inp';
var i,m,n : longint;

begin
    randomize;
    assign(output,out); rewrite(output);
    m := 100; n := 10;
    writeln(m);
    for i := 1 to m do write(random(1000000000),' ');
    writeln;
    writeln(n);
    for i := 1 to n do write(random(1000000000),' ');
end.
