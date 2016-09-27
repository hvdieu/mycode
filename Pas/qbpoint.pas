Uses math;
Const
	inp = 'qbpoint.inp';
	out = 'qbpoint.out';
	maxn = 2001;

Type
	arr1 = array [1..maxn] of longint;
	arr2 = array [1..maxn] of double;

Var	
	n,i : longint;
	x,y : arr1;
	a : arr2;
	res : qword;

procedure swap(var xx,yy : double);
	var temp : double;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint);
	var i,j,k : longint;
    k1 : double;
begin
	if l >= h then exit;
	i := l; j := h; k := l+random(h-l+1); k1 := a[k];
	repeat
		while (a[i]<k1) do inc(i);
		while (a[j]>k1) do dec(j);
		if i <= j then
			begin
				if i < j then swap(a[i],a[j]);
				inc(i); dec(j);
			end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure main;
	var i,j,m,dem,t,xx,yy : longint;
begin
	for i := 1 to n-2 do
		begin
			m := 0;
			for j := i+1 to n do
			  begin
			  	inc(m);
			  	xx := x[i]-x[j]; yy := y[i]-y[j];
			  	if yy=0 then a[m] := 987654321 else a[m] := xx/yy;
			  end;
			sort(1,m);
			dem := 1;
			for j := 2 to m do
				if (a[j]=a[j-1]) then inc(dem)
				 else begin
				 	res := res + (dem*(dem-1) div 2);
				 	dem := 1;
				 end;
			res := res + (dem*(dem-1) div 2);
		end;
	writeln(Res);
end;	

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do read(x[i],y[i]);
	main;
end.
