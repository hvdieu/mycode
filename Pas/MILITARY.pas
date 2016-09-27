Uses math;
Const 
	inp = 'MILITARY.INP';
	out = 'MILITARY.OUT';
	maxn = 4010;

Type
	point = record
		 x,y : double;
	end;

Var
	n,i,res : longint;
	a : array [1..maxn] of point;
	goc : array [1..maxn] of double;

function Cal(x,y : double) : double;
	var o : double;
begin
	if x=0 then
	  if y >= 0 then exit(0)
	   else exit(pi);
	if y=0 then 
	  if x>=0 then exit(pi/2)
	   else exit(pi*3/2);
	o := arctan(y/x);
	if (x>0) then
	 if y>0 then exit(o)
	  else exit(pi-o);
	if (x<0) then 
	 if y>0 then exit(2*pi-o)
	  else exit(pi+o);
end;

procedure swap(var x,y : double);
	var temp : double;
begin
	temp := x; x := y; y := temp;
end;

procedure sort(l,h : longint);
	var i,j : longint;
		k : double;
begin
	if l >= h then exit;
	i := l; j := h; k := goc[l+random(h-l+1)];
	repeat
		while goc[i] < k do inc(i);
		while goc[j] > k do dec(j);
		if i <= j then 
		  begin
		  	swap(goc[i],goc[j]);
		  	swap(a[i].x,a[j].x);
		  	swap(a[i].y,a[j].y);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure main;
	var i,j,u : longint;
		temp : double;
begin
	repeat
		if n<=2 then break;
		u := 0; temp := 10001;
		for i := 1 to n do 
		 if a[i].y < temp then 
		   begin
		   	 temp := a[i].y;
		   	 u := i;
		   end;
		for i := 1 to n do goc[i] := Cal(a[i].x-a[u].x,a[i].y-a[u].y);
		a[n+1] := a[1];
		sort(1,n);
		top := 2;
		st[1] := 1; st[2] := 2;
		for i := 3 to n+1 do 
		  begin
		  	while (top>=2) and (ccw(a[st[top-1]],a[st[top]],a[i]))
		  end;
	until false;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do read(a[i].x,a[i].y);
	main;
end.
