Const	out = 'ballgame.inp';
	
Var	i,n	:	longint;
        a	:	array [0..1] of integer;

begin
     randomize;
     a[1] := 1; a[0] := -1;
     n := 1000;
     assign(output,out); rewrite(output);
     writeln(n);
     for i := 1 to 2*n do writeln(random(100000),' ',random(10000));	
end.
