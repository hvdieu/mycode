Const
	out = 'input.txt';
    maxn = 2501;

Var
	n,i : longint;

begin
    randomize;
    assign(output,out); rewrite(output);
    n := 20;
    writeln(n,' ',random(10)+1,' ',random(50)+1);
    for i := 1 to n do write(random(50),' ');
end.