Uses math;
Const 
	inp = 'coprimes.inp';
	out = 'coprimes.out';

Var
	n,i,m : longint;
	x : extended;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n); m := n;
	x := 1;
	for i := 2 to trunc(sqrt(n)) do 
	  begin
	  	 if m mod i = 0 then
	  	   begin
	  	   	 x := x*(1-1/i);
	  	   	 while m mod i=0 do m := m div i;
	  	   end;
	  end;
	if m > 1 then x := x*(1-1/m);
	writeln(x*n:0:0)
end.