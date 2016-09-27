Uses math;
Const
	inp = 'asd.inp';
	out = 'asd.out';
	maxn = 300001;

Type
	arr = array [1..maxn] of longint;

Var
	a,b,c,d : array [1..maxn] of longint;
	t : array [1..4*maxn] of longint;
	n,k,i : longint;
	res : int64;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint;var a,b : arr);
	var i,j,k,k1,k2 : longint;
begin
	if l >= h then exit;
	i := l; j := h; k := l+random(h-l+1);
	k1 := a[k]; k2 := b[k];
	repeat
		while (a[i]<k1) or ((a[i]=k1) and (b[i]>k2)) do inc(i);
		while (a[j]>k1) or ((a[j]=k1) and (b[j]<k2)) do dec(j);
		if i <= j then
		  begin
		  	swap(a[i],a[j]);
		  	swap(b[i],b[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j,a,b); sort(i,h,a,b);
end;

procedure update(i,lo,hi,u,x : longint);
	var mid : longint;
begin
	if (lo > u) or (hi<u) then exit;
	if (lo=hi) then
	  begin
	  	 t[i] := x;
	  	 exit;
	  end;
	mid := (lo+hi) shr 1;
	update(i*2,lo,mid,u,x); update(i*2+1,mid+1,hi,u,x);
	t[i] := max(t[i*2],t[i*2+1]);
end;

function find(i,lo,hi,x : longint) : longint;
	var mid : longint;
begin
	if lo=hi then exit(lo);
	if (t[i*2] < x) and (t[i*2+1]<x) then exit(0);
	mid := (lo+hi) shr 1;
	if t[i*2] >= x then find := find(i*2,lo,mid,x)
	 else find := find(i*2+1,mid+1,hi,x);
end;

procedure main;
	var i,j : longint;
begin
	sort(1,n,b,a); sort(1,k,c,d);
	for i := 1 to k do update(1,1,k,i,c[i]);
	for i := n downto 1 do
	  begin
	  	 j := find(1,1,k,a[i]);
	  	 if j <> 0 then
	  	   begin
	  	   	res := res + b[i];
	  	   	update(1,1,k,j,-1);
	  	   end;
	  end;
	writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,k);
	for i := 1 to n do read(a[i],b[i]);
	for i := 1 to k do read(c[i]);
	main;
end.
