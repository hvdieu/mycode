Uses math;
Const
	inp = 'asd.inp';
	out = 'as.out';

Var
	n,m,i : longint;
	res : longint;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m);
	if n < m then writeln(n)
	 else
	   begin
	      res := m;
          n := n-m;
	      i := m+1;
	   	  repeat
	   	  	  if i mod m=1 then inc(n);
	   	  	  if n = 0 then break;
	   	  	  inc(Res);
              inc(i);
	   	  	  dec(n);
	   	  until false;
	   	 writeln(res);
	   end;
end.
