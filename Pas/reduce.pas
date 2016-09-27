{$COperators ON}
Uses math;
Const
	inp = 'reduce.inp';
	out = 'reduce.out';
	maxn = 200001;

Var
	n,i : longint;
	a : array [1..maxn] of longint;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint);
	var i,j,k : longint;
begin
	if l >= h then exit;
	i := l; j := h; k := a[l+random(h-l+1)];
	repeat
		while a[i] < k do inc(i);
		while a[j] > k do dec(j);
		if i <= j then
		  begin
		  	swap(a[i],a[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure main;
	var x,y : Extended;
        i : longint;
begin
	x := (a[1]+a[2])/2;
	for i := 3 to n do x := (x+a[i])/2;
	y := (a[n]+a[n-1])/2;
	for i := n-3 downto 1 do y := (x+a[i])/2;
	if x > y then write(x:0:6) else write(y:0:6);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do read(a[i]);
	if n=1 then write(a[1])
	 else main;
end.
