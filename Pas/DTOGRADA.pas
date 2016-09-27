Uses math;
Const
	inp = 'ograda.in.10';
	out = 'DTOGRADA.OUT';
	maxn = 1000001;

Var
	n,k,top,i,bot,count : longint;
	a,b,p : array [0..maxn] of longint;
	sum,res : int64;

procedure main;
	var i,j,last : longint;
begin
	top := 0; bot := 1;
	for i := 1 to k-1 do
	  begin
	  	while (top>=bot) and (a[p[top]]>=a[i]) do dec(top);
	  	inc(top); p[top] := i;
	  end;
	for i := 1 to n-k+1 do
	  begin
	  	while (top>=bot) and (a[p[top]]>=a[i+k-1]) do dec(top);
	  	inc(top); p[top] := i+k-1;
	  	b[i] := a[p[bot]];
	  	while (top>=bot) and (p[bot]<=i) do inc(bot);
	  end;
	top := 0; bot := 1; last := 0;
	for i := 1 to n do
	  begin
  	    while (top>=bot) and (b[p[top]]<=b[i]) do dec(top);
	  	inc(top); p[top] := i;
	  	res := res+b[p[bot]];
	  	if (b[p[bot]]<>b[last]) or (last+k-1<i) then
	  	  begin
	  	  	inc(count); last := p[bot];
	  	  end;
	  	while (top>=bot) and (p[bot]<=i-k+1) do inc(bot);
	  end;
	writeln(sum-res);
	writeln(count);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,k);
	for i := 1 to n do
	  begin
	    read(a[i]);
	    sum := sum+a[i];
	  end;
	main;
end.
