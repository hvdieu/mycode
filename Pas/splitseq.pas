Uses math;
Const
	inp = 'splitseq.inp';
	out = 'splitseq.out';
	maxn = 100001;
	oo = 1000000009;
Var
	n,i,x,m,res : longint;
	a,t : array [0..maxn] of longint;
	s,id : array [0..maxn] of int64;

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
	i := l; j := h; k := s[l+random(h-l+1)];
	repeat
		while s[i] < k do inc(i);
		while s[j] > k do dec(j);
		if i <= j then
		  begin
		  	swap(s[i],s[j]);
		  	swap(id[i],id[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure update(i,val : longint);
begin
	while i <= m do
	  begin
	  	t[i] := (t[i]+val) mod oo;
	  	inc(i,i and (-i));
	  end;
end;

function get(i : longint) : longint;
	var s : longint;
begin
	s := 0;
	while i > 0 do
	  begin
	  	s := (s+t[i]) mod oo;
	  	dec(i,i and (-i));
	  end;
	exit(s);
end;

procedure main;
	var i,j,dem,x : longint;
begin
	sort(0,n);
	m := 1; a[id[0]] := 1;
	for i := 1 to n do
	  begin
	  	if s[i] <> s[i-1] then inc(m);
	  	a[id[i]] := m;
 	  end;
    update(a[0],1);
    for i := 1 to n do
       begin
       	  res := get(a[i]);
       	  update(a[i],res);
       end;
    writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do
	  begin
	  	read(x); s[i] := s[i-1]+x;
	  	id[i] := i;
	  end;
	main;
end.
