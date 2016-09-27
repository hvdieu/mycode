Uses math;
Const
	inp = 'asd.inp';
	out = 'asd.out';
	maxn = 10001;

Var
	n,r,i,ntest : longint;
	x,y : array [1..maxn] of longint;
	p,p1 : extended;

function dis(x1,y1,x2,y2 : longint) : extended;
begin
	dis := sqrt(sqr(int64(x1)-x2)+sqr(int64(y1)-y2));
end;

procedure main;
	var i,j : longint;
begin
	p := 0;
	for i := 2 to n do p := p+dis(x[i],y[i],x[i-1],y[i-1]);
	p := p+dis(x[1],y[1],x[n],y[n]);
	p1 := p-2*pi*r;
	if p1 < 0 then writeln('Not possible')
	 else writeln(p1/p:0:6);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	while ntest > 0 do
	  begin
	  	dec(ntest);
	  	readln(r,n);
	  	for i := 1 to n do read(x[i],y[i]);
	  	main;
	  end;
end.
