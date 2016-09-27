const
	out = 'lis2vn.in1';

var i,n : longint;

begin
      assign(output,out); rewrite(output);
      n := 100000;
      writeln(n);
      for i := 1 to n do writeln(i,' ',i);
end.