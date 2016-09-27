Uses math;
Const 
	inp = 'DELIVERY.INP';
	out = 'DELIVERY.OUT';
	maxn = 1001;

Var
	n,i,m,t,res,sum : longint;
	a,b : array [1..maxn] of longint;

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
		while a[i]<k do inc(i);
		while a[j]>k do dec(j);
		if i <= j then
		  begin
		  	swap(a[i],a[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,j);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(t);
	readln(n);
	for i := 1 to n do read(a[i]);
	readln(m);
	for i := 1 to m do 
	  begin
	  	inc(n); read(a[n]); b[n] := 1;
	  end;
	sort(1,n);
	sum := 0;
	for i := 1 to n do 
	  begin
	  	if sum+a[i]>t then break;
	  	if b[i]=0 then
	  	  begin
	  	  	sum := sum+a[i]; b[i] := -1; inc(Res);
	  	  end;
	  end;
	sum := 0;
	for i := 1 to n do 
	  begin
	  	if sum+a[i]>t then break;
	  	if b[i]<>-1 then
	  	  begin
	  	  	sum := sum+a[i]; b[i] := -1; inc(res); 		
	  	  end; 	
	  end; 
	writeln(res);
end.