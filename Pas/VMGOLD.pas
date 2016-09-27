Uses math;
Const
	inp = '';
	out = '';
	maxn = 3001;
	oo = 10000001;
	nngto = 10001;
    maxt = 1000000;

Var
	n,k,i,m,dem,sl : longint;
	a : array [1..maxn] of int64;
	res : int64;
	dd : array [1..oo] of integer;
	t : array [1..maxt] of int64;
	b : array [1..nngto] of longint;
	p : array [1..100000] of integer;
	c : array [1..50] of int64;
    d : array [1..50] of longint;

procedure sangngto;
	var i,j : longint;
begin
	for i := 2 to trunc(sqrt(100000)) do
	 if p[i]=0 then
	  begin
	  	 j := i*i;
	  	 while j <= 100000 do
	  	   begin
	  	   	  p[j] := 1;
	  	   	  j := j+i;
	  	   end;
	  end;
	for i := 2 to 100000 do
	 if p[i]=0 then
	  begin
	  	inc(m); b[m] := i;
	  end;
end;

procedure ql(i : longint; x : int64);
	var j : longint;
		num : int64;
begin
	if i > dem then
	  begin
	  	if x <= 10000000 then
	  	   begin
	  	   	 inc(dd[x]);
	  	   	 if dd[x] >= k then res := max(res,x);
	  	   end
	  	else begin
	  		inc(sl); t[sl] := x;
	  	end;
	  	exit;
	  end;
	num := 1;
    ql(i+1,x);
	for j := 1 to d[i] do
	  begin
         num := num*c[i];
	  	 ql(i+1,x*num);
	  end;
end;

procedure sinh(x : int64);
	var i : longint;
begin
	dem := 0;
	for i := 1 to m do
	 if x mod b[i]=0 then
	  begin
	  	inc(dem); c[dem] := b[i];
        d[dem] := 0;
	  	while x mod b[i] = 0 do
	  	  begin
	  	  	inc(d[dem]); x := x div b[i];
	  	  end;
	  end;
	if x > 1 then
	  begin
	  	inc(dem); c[dem] := x; d[dem] := 1;
	  end;
	ql(1,1);
end;

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
	i := l; j := h; k := t[l+random(h-l+1)];
	repeat
		while t[i]<k do inc(i);
		while t[j]>k do dec(j);
		if i <= j then
		  begin
		  	swap(t[i],t[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure main;
	var i,j : longint;
begin
	sangngto;
	for i := 1 to n do
      sinh(a[i]);
	sort(1,sl);
	i := 1;
	while i <= sl do
	  begin
	  	j := i;
	  	while (j<sl) and (t[j+1]=t[i]) do inc(j);
	  	if j-i+1>=k then res := max(res,t[i]);
	  	i := j+1;
	  end;
	writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,k);
	for i := 1 to n do read(a[i]);
	main;
end.

