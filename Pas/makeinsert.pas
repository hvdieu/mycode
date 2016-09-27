Const	out = 'INSERT.INP';
Var	fo	:	text;
	n,m	:	longint;
        i	:	longint;

begin
     assign(fo,out); rewrite(fo);
     write('n,m = '); read(n,m);
     writeln(fo,n);
     for i := 1 to n do writeln(fo,random(1000000));
     for i := 1 to m do writeln(fo,random(1000000));
     close(fo);
end.