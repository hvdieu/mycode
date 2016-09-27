{$H+}
Uses math;
Const
	inp = 'sd.inp';
	out = 'asd.out';
	maxn = 1000001;
	oo = 1000000007;

Var
	a,b : array [0..maxn] of int64;	
	s : string;
	n,i,x : longint;
	res,hold : int64;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(s);
	n := length(s);
	hold := 0;
	for i := 1 to n do
	  begin
	  	x := ord(s[i])-ord('0');
	  	hold := (hold*10+i*x) mod oo;
	  	res := (res +hold) mod oo;
	  end;
	writeln(res);
end.
