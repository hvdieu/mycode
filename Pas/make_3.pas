Var	fo : text;
	n,m,i : longint;

begin
      randomize;
      write('n,m = '); readln(n,m);
      assign(fo,'lemon.inp'); rewrite(fo);
      writeln(fo,n,' ',m);
      for i := 1 to n do write(fo,random(1000)+1,' ');
      close(fo);
end.