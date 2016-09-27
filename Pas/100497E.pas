uses math;
const
	inp = '';
	out = '';
	maxn = 100010;

Var
	n,i,k,top : longint;
	left,right,p : array [0..maxn] of longint;
	a,b : array [0..maxn] of int64;
	res : int64;

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
	i := l; j := h; k := b[l+random(h-l+1)];
	repeat
		while b[i] > k do inc(i);
		while b[j] < k do dec(j);
		if i <= j then
		  begin
		  	swap(b[i],b[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure main;
	var i,j : longint;
		x,y,sl,sl2 : int64;
begin
	a[0] := maxn; a[n+1] := maxn;
	top := 1; p[1] := 1;
	p[0] := 0;
	left[1] := 1;
	for i := 2 to n do
	  begin
	  	if a[i] > a[i-1] then
	  	  begin
	  	  	left[i] := i;
	  	  	inc(top); p[top] := i;
	  	  end
	  	else begin
	  		while (top>0) and (a[i] < a[p[top]]) do dec(top);
	  		left[i] := p[top]+1;
	  		inc(top); p[top] := i;
	  	end;
	  end;
	right[n] := n; top := 1; p[1] := n;
	p[0] := n+1;
	for i := n-1 downto 1 do
	  begin
	  	 if a[i] > a[i+1] then
	  	   begin
	  	   	right[i] := i;
	  	   	inc(top); p[top] := i;
	  	   end
	  	 else begin
	  	 	while (top>0) and (a[i] < a[p[top]]) do dec(top);
	  	 	right[i] := p[top]-1;
	  	 	inc(top); p[top] := i;
	  	 end;
	  end;
	for i := 1 to n do
	begin
     sl := i-left[i]+1;
     sl2 := right[i]-i;
     x := (sl*(sl+1)) div 2;
	 b[i] := x+x*sl2+sl*(sl2*(sl2+1) div 2);
	 res := res + a[i]*b[i];
	end;
	sort(1,n);
	for i := 1 to k do res := res + b[i];
	writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,k);
	for i := 1 to n do read(a[i]);
	main;
end.
