Const	out = 'c11post.inp';
var 	m,n,i,j : longint;

begin
     randomize;
     assign(output,out); rewrite(output);
     writeln(100,' ',100); m := 100; n := 100;
     write('P'); for j := 2 to 100 do write('K');
     writeln;
     for i := 2 to m do
      begin
          for j := 1 to n do write('K');
          writeln;
      end;
     for i := 1 to m do
      begin
          for j := 1 to n do write(random(1000000000),' ');
          writeln;
      end;
end.