Uses math;
const
	inp = 'input.txt';
    x = 1000000;

Var
	n,i : longint;

begin
    randomize;
	assign(output,inp); rewrite(output);
    n := 10000;
    writeln(n);
    for i := 1 to n do writeln(random(x),' ', random(x),' ',random(10)+1);
end.
