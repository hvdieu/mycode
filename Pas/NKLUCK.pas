Uses math;
Const
	inp = 'NKLUCK.INP';
	out = 'NKLUCK.OUT';
	maxn = 500001;

Var
	n,x : longint;
	a,id,b,t : array [0..1,0..maxn] of longint;
	m : array [0..1] of longint;
	res : int64;

procedure nhap();
	var i,j,num : longint;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,x);
	for i := 1 to n do
	  begin
	  	read(num);
	  	if num >= x then a[0,i] := a[0,i-1]+1
	  	  else a[0,i] := a[0,i-1]-1;
	  	if num > x then a[1,i] := a[1,i-1]+1
	  	  else a[1,i] := a[1,i-1]-1;
	  	id[0,i] := i; id[1,i] := i;
	  end;
end;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h,t : longint);
	var i,j,k : longint;
begin
	if l >= h then exit;
	i := l; j := h; k := a[t,l+random(h-l+1)];
	repeat
		while a[t,i] < k do inc(i);
		while a[t,j] > k do dec(j);
		if i <= j then
			begin
				swap(a[t,i],a[t,j]);
				swap(id[t,i],id[t,j]);
				inc(i); dec(j);
			end;
	until i > j;
	sort(l,j,t); sort(i,h,t);
end;

procedure roirac(t : longint);
	var i,j : longint;
begin
	sort(0,n,t);
	m[t] := 1; b[t,id[t,0]] := 1;
	for i := 1 to n do
	 begin
	 	if a[t,i] <> a[t,i-1] then inc(m[t]);
	 	b[t,id[t,i]] := m[t];
	 end;
end;

procedure update(k,i,val : longint);
	begin
		while i <= m[k] do
			begin
				inc(t[k,i],val);
				inc(i,i and (-i));
			end;
	end;

function get(k,i : longint): longint;
	var s : longint;
begin
	s := 0;
	while i > 0 do
		begin
			s := s+t[k,i];
			dec(i,i and (-i));
		end;
	exit(s);
end;

procedure main();
	var i,j : longint;
begin
	roirac(0); roirac(1);
	update(0,b[0,0],1); update(1,b[1,0],1);
	for i := 1 to n do
	  begin
	  	  res := res + get(0,b[0,i])-get(1,b[1,i]);
	  	  update(0,b[0,i],1);
          update(1,b[1,i],1);
	  end;
	writeln(res/((int64(n+1)*n) div 2):0:10)
end;

begin
	nhap;
	main;
end.
