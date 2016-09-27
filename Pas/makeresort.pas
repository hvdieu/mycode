Var n,i,t : longint;
begin
     assign(output,'resort.inp'); rewrite(output);
     read(n);
     writeln(n);
     for i := 1 to n do
      begin
          t := random(2);
          write(t,' ');
      end;
     writeln;
     for i := 1 to n do write(random(n),' ');
end.