Const	out = 'HOW.inp';
Var	fo : text;
        n,i,m : longint;

begin
      randomize;
      assign(fo,out); rewrite(fo);
      write('n,m = '); read(n,m);
      writeln(fo,n,' ',m);
      for i := 1 to m do writeln(fo,random(n-1)+1,' ',random(n-1)+1);
      close(fo);
end.
