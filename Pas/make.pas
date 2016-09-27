Var	fo	:	text;
	n,w,k,i,gt	:	longint;

begin
      randomize;
      assign(fo,'1017.inp'); rewrite(fo);
      writeln(fo,1);
      readln(n,w,k);
      writeln(fo,n,' ',w,' ',k);
      for i := 1 to n do writeln(fo,random(1000000000),' ',random(1000000000));
      close(fo);
end.