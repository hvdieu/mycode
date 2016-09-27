Uses math;
Const
	inp = '51.in';
    out = '51.out';

Var
	m,n,k,q,i : longint;

begin
     assign(output,inp); rewrite(output);
	 n := 100000; m := n; k := 1;
     writeln(n,' ',m,' ',k);
     for i := 1 to n-1 do writeln(1);
     for i := 1 to n do write(i,' ');
     writeln;
     q := 100000;
     writeln(q);
     for i := 1 to q do writeln(1);
end.
