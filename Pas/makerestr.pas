Uses math;
Const
	out = 'restr.inp';

Var
	n,i,m,ntest : longint;

begin
    assign(output,out); rewrite(output);
    ntest := 10;
    writeln(10);
    while ntest >0 do
    begin
    dec(ntest);
    n := 1000000000;
    m := 100000;
    writeln(n,' ',m);
    for i := 1 to m do writeln(random(n)+1,' ',random(n)+1);
    end;
end.
