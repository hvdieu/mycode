uses math;
Const
	inp = '4c.inp';
	out = '466c.out';
	maxn = 501;

Var
	n,i,dem : longint;
	a : array [0..maxn] of int64;
	x,sum,t,res : int64;

begin
	assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do
	  begin
	  	read(x);
	  	a[i] := a[i-1]+x;
	  	sum := sum+x;
	  end;
	if abs(sum) mod 3 <> 0 then writeln(0)
	 else begin
	 	t := sum div 3;
	 	for i := 1 to n do
          begin
              if sum=2*t then res := res+dem;
              if sum=t then inc(dem);
          end;
	 	writeln(Res);
	 end;
end.
