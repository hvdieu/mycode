Uses math;
Const
	out = 'VMMARBLE.INP';

Var
	n,m,k,i,j,x,l,ll : longint;

begin
	randomize;
    assign(output,out); rewrite(output);
    n := 50; m := 3; k := 2;
    writeln(n,' ',m,' ',k);
    x := random(100000)+1;
    for i := 1 to n do
      begin
          for j := 1 to m do
            begin
               l := random(2); ll := random(2);
               if ll=0 then write(x+l,' ')
                else write(x-l,' ');
            end;
          writeln;
      end;
end.
