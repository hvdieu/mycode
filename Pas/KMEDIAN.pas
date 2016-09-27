Uses math;
Const
	inp = '';
	out = '';
	maxn = 100001;

Type
	arr1 = array [0..maxn] of longint;

Var	
	n,x,m : longint;
	a,id,t,b : arr1;
	res : qword;

procedure nhap;
	var i,j,num : longint;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,x);
	for i := 1 to n do
	  begin
	  	read(num);
	  	if num >= x then a[i] := a[i-1]+1
	  	 else a[i] := a[i-1]-1;
	  	id[i] := i;
	  end;
end;

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
		while a[i] < k do inc(i);
		while a[j] > k do dec(j);
		if i <= j then
			begin
				swap(a[i],a[j]);
				swap(id[i],id[j]);
				inc(i); dec(j);
			end;
	until i > j;
	sort(l,j); sort(i,h);
end;

procedure update(i,val : longint);
	begin
		while i <= m do
			begin
				inc(t[i],val);
				inc(i,i and (-i));
			end;
	end;

function get(i : longint): longint;
	var s : longint;
begin
	s := 0;
	while i > 0 do
		begin
			s := s+t[i];
			dec(i,i and (-i));
		end;
	exit(s);
end;

procedure main;
	var i,j : longint;
begin
	sort(0,n);
	m := 1; b[id[0]] := 1;
	for i := 1 to n do
	 begin
	 	if a[i] <> a[i-1] then inc(m);
	 	b[id[i]] := m;
	 end;
	update(b[0],1);
	for i := 1 to n do
	  begin
	  	res := res + get(b[i]);
	  	update(b[i],1);
	  end;
	writeln(res);
end;

begin
	nhap;
	main;
end.
