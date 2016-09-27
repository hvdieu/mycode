Const	out = 'BCHESS.INP';
var i,j,m,n : longint;
	
begin
     randomize;
     assign(output,out); rewrite(output);
    n := 2;
     writeln(n);
     for i := 1 to n do
      begin
          for j := 1 to n do
           if (i mod 2)=(j mod 2) then write(0)
            else write(1);
          writeln;
      end;
end.
