const out = 'c11yard.inp';
var	m,n,i,j,k : longint;
begin
     assign(output,out); rewrite(output);
     m := 2000; n := 2000;
     k := 1;
     writeln(m,' ',n,' ',k);
     for i := 1 to m do
      begin
          for j := 1 to n do write('.');
          writeln;
      end;
end.
