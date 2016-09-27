Uses math;
Const
	inp = 'PER.INP';
	out = 'PER.OUT';
	maxn = 200001;

Var
	n,i,m : longint;
	a,s : array [1..maxn] of longint;
	t,f : array [1..4*maxn] of longint;

procedure init(i,lo,hi : longint);
	var mid,c1,c2 : longint;
begin
	if lo=hi then
	  begin
	  	t[i] := lo-s[lo];
	  	exit;
	  end;
	mid := (lo+hi) shr 1;
	init(i*2,lo,mid);
	init(i*2+1,mid+1,hi);
	t[i] := min(t[i*2],t[i*2+1]);
end;

procedure down(i : longint);
	var c1,c2 : longint;
begin
	c1 := i*2; c2 := i*2+1;
	inc(t[c1],f[i]);
	inc(t[c2],f[i]);
	inc(f[c1],f[i]);
	inc(f[c2],f[i]);
	f[i] := 0;
end;

procedure update(i,lo,hi,u,v,x : longint);
	var mid : longint;
begin
	if (lo=u) and (hi=v) then
	  begin
	  	 inc(t[i],x);
	  	 inc(f[i],x);
	  	 exit;
	  end;
	mid := (lo+hi) shr 1;
	down(i);
	if u <= mid then update(i*2,lo,mid,u,min(mid,v),x);
	if v > mid then update(i*2+1,mid+1,hi,max(u,mid+1),v,x);
	t[i] := min(t[i*2],t[i*2+1]);
end;

procedure main;
	var i,j,u,x : longint;
begin
	for i := 2 to n do s[i] := s[i-1]+s[i];
	init(1,1,n);
	if t[1] < 0 then writeln('NO')
	 else writeln('YES');
	readln(m);
	for i := 1 to m do
	  begin
	  	readln(u,x);
	  	update(1,1,n,a[u],n,1);
        for j := a[u] to n do dec(s[j]);
	  	update(1,1,n,x,n,-1);
        for j := x to n do inc(s[j]);
	  	a[u] := x;
	  	if t[1] < 0 then writeln('NO')
	  	 else writeln('YES');
	  end;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do
	  begin
	    read(a[i]);
	    inc(s[a[i]]);
	  end;
	main;
end.
