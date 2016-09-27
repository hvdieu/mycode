Uses math;
Const
	inp = 'HSEQ.INP';
	out = 'HSEQ.OUT';
	maxn = 201;
	oo = 999999999;

Var
	a,b : array [1..maxn] of longint;
	g,f : array [0..maxn,0..maxn] of longint;
	n,k,i,res,ntest : longint;

procedure swap(Var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint);
	var i,j,k : longint;
begin
	if l >= h then exit;
	i := l; j := h; k := b[l+random(h-l+1)];
	repeat
		while b[i]<k do inc(i);
		while b[j]>k do dec(j);
		if i <= j then
		   begin
		   	  swap(b[i],b[j]);
		   	  inc(i); dec(j);
		   end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure main;
	var i,j,l,jj,top,dem,res :  longint;
begin
	for i := 3 to n do
	  for j := 1 to i-2 do
	   if (i-j+1) mod 2=1 then
	     begin
	     	l := i-j+1; top := 0;
	     	for jj := j to i do
	     	  begin
	     	     inc(top); b[top] := a[jj]+abs(l div 2+1-top);
	     	  end;
	     	sort(1,top);
	     	dem := 1; res := 1;
	     	for jj := 2 to top do
	     	  begin
	     	  	 if b[jj]=b[jj-1] then inc(dem) else dem := 1;
	     	  	 if dem > res then res := dem;
	     	  end;
	     	g[j,i] := l-res;
	     end;
	for i := 0 to n do
	  for j := 0 to k do f[i,j] := oo;
	f[0,0] := 0;
	for i := 1 to n do
	  for j := 1 to min(i,k) do
        for jj := 1 to i-1 do
         if (i-jj+1) mod 2=1 then
          f[i,j] := min(f[i,j],f[jj-1,j-1]+g[jj,i]);
    res := oo;
    for j := 1 to k do res := min(res,f[n,j]);
    writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	while ntest > 0 do
	  begin
	  	dec(ntest);
	  	readln(n,k);
	  	for i := 1 to n do read(a[i]);
	  	main;
	  end;
end.
