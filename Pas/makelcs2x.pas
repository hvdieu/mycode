Const	out = 'lcs2x.inp';
Var	m,n,i,j,ntest	:	longint;

begin
    randomize;
    assign(output,out); rewrite(output);
    ntest := 100;
    writeln(ntest);
    while ntest > 0 do
     begin
         dec(ntest);
         m := 15; n := 15;
         writeln(m,' ',n);
         for i := 1 to m do write(random(10),' ');
         writeln;
         for i := 1 to n do write(random(10),' ');
         writeln;
     end;
end.
