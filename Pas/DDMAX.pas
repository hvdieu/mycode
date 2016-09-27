Uses math;
Const
	inp = 'DDMAX.INP';
	out = 'DDMAX.OUT';
	maxn = 100010;

Var
	n,i,x,res : longint;
	a,id : array [0..maxn] of int64;

procedure swap(var xx,yy : int64);
	var temp : int64;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint);
	var i,j : longint;
		k : int64;
begin
	if l >= h then exit;
	i := l; j := h; k := a[l+random(h-l+1)];
	repeat
		while a[i] < k do inc(i);
		while a[j] > k do dec(j);
		if i <= j then
		  begin
		  	swap(a[i],a[j]);
		  	swap(id[i],id[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure main;
	var i,j,m,k : longint;
begin
	sort(0,n);
	i := 0; m := maxlongint;
	while i <= n do
	  begin
	  	j := i;
	  	while (j<n) and (a[j+1]=a[i]) do inc(j);
	  	for k := i to j do
	  	  if m < id[k] then res := max(res,id[k]-m);
	  	for k := i to j do m := min(m,id[k]);
	  	i := j+1;
	  end;
	writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do
	  begin
	  	read(x);
	  	a[i] := a[i-1]+x; id[i] := i;
	  end;
	main;
end.
