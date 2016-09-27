Uses math;
Const
    out = 'VPLISCV.INP';
    maxn = 5001;

Var
    i,n,ntest : longint;

begin
    randomize;
    assign(output,out); rewrite(output);
    writeln(20);
    for ntest := 1 to 20 do
    begin
    writeln(1000);
    for i := 1 to 5000 do write(random(1000000000),' ');
    writeln;
    end;
end.
