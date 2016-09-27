Uses math;
Const
	inp = '';
	out = '';
	maxn = 100001;

Var
	m,n,i,j,res,ntest : longint;
	a,s : array [1..maxn] of longint;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	while ntest > 0 do
	  begin
	  	 dec(ntest);
	  	 readln(n);
	  	 for i := 1 to n do read(s[i]);
	  	 for i := 1 to n do read(a[i]);
	  	 res := s[1] mod (a[1]+1);
	  	 for i := 2 to n do res := res xor (s[i] mod (a[i]+1));
	  	 if res = 0 then writeln('Tom')
	  	   else writeln('Jerry');
	  end;
end.

