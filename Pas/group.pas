Uses math;
Const
	inp = '';
	out = '';
	maxn = 300001;
 
Var
	n,i,top,m : longint;
	a,b,next,x,y : array [0..maxn] of longint;
	f,db,da : array [0..maxn] of int64;
	dx,dy : array [0..maxn] of double;
 
procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;
 
procedure sort(l,h : longint);
	var i,j,k,k1,k2 : longint;
begin
	if l >= h then exit;
	i := l; j := h; k := l+random(h-l+1);
	k1 := a[k]; k2 := b[k];
	repeat
		while (a[i]<k1) or ((a[i]=k1) and (b[i]<k2)) do inc(i);
		while (a[j]>k1) or ((a[j]=k1) and (b[j]>k2)) do dec(j);
		if i <= j then
		  begin
		  	swap(a[i],a[j]);
		  	swap(b[i],b[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;
 
procedure main;
	var i,j,tg,u : longint;
		a2,b2,a1,b1 : int64;
        xx,yy : double;
begin
	sort(1,n);
	m := 1;
	x[m] := a[n]; y[m] := b[n]; tg := b[n];
	for i := n-1 downto 1 do
	 if b[i]>tg then
	  begin
	  	tg := b[i];
	  	inc(m); x[m] := a[i]; y[m] := b[i];
	  end;
	top := 0; j := 0; db[0] := 0; da[0] := y[m]; dy[0] := 0;
	for i := m downto 1 do
	  begin
	  	while (j<top) and (x[i]>dx[j+1]) do inc(j);
	  	f[i] := db[j]+da[j]*x[i];
	  	if i<>1 then
	  	  begin
	  	  	a1 := y[i-1]; b1 := f[i];
	  	  	while (top>0) do
	  	  	  begin
	  	  	  	  begin
	  	  	  	  	 a2 := da[top-1]; b2 := db[top-1];
	  	  	  	  	 xx := (b2-b1)/(a1-a2);
	  	  	  	  	 yy := a1*xx+b1;
	  	  	  	  end;
	  	  	  	if yy <= dy[top] then dec(top) else break;
	  	  	  end;
	  	  	a2 := da[top]; b2 := db[top];
	  	  	xx := (b2-b1)/(a1-a2);
	  	  	yy := a1*xx+b1;
	  	  	inc(top); da[top] := a1; db[top] := b1; dx[top] := xx; dy[top] := yy;
	  	  end;
	  end;
	writeln(f[1]);
end;
 
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do read(a[i],b[i]);
	main;
end.