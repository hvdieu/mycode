Uses math;
Const 	
	inp = '';
	out = '';
	maxn = 5001;

Var
	n,ntest,dem,i : longint;
	a : array [1..maxn] of longint;
	res : int64;

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
	sort(l,j); sort(i,h);
end;

procedure main;
	var i,j,u,v,x,y,t : longint;
begin
	sort(1,n);
    res := 0;
	for i := 1 to n-2 do
	  begin
	  	t := i+2;
	   	for j := i+1 to n-1 do
	   	  begin
	   	  	 while (t<=n) and (a[t]<a[i]+a[j]) do inc(t);
             dec(t);
	   	  	 if t >= j+1 then res := res+t-(j+1)+1;
	   	  end;
	  end;
	writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
   //readln(ntest);
    ntest := 1;
	for dem := 1 to ntest do
	  begin
	   //write('Case ',dem,': ');
	  	readln(n);
	  	for i := 1 to n do read(a[i]);
	  	main;
	  end;
end.
