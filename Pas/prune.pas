Uses math;
Const
	inp = 'prune.inp';
	out = 'prune.out';
	maxn = 301;
	oo = 999999;

Var
	n,i,m,sl,dem : longint;
	head,ke,next,a,con,num,b : array [1..maxn] of longint;
	f : array [0..maxn,-maxn..maxn] of longint;

procedure nhap;
	var i,j,u,v : longint;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m);
	for i := 1 to n do
	  begin
	  	read(u); inc(u); read(a[u],con[u]);
	  	if a[u]=0 then a[u] := -1;
	  	for j := 1 to con[u] do
	  	  begin
	  	  	read(v); inc(v);
	  	  	inc(sl); ke[sl] := v; next[sl] := head[u]; head[u] := sl;
	  	  end;
	  end;
end;

procedure dfs(u : longint);
	var j,v : longint;
begin
	inc(dem); num[u] := dem; b[dem] := u;
	j := head[u];
	while j <> 0 do
	  begin
	  	v := ke[j];
	  	if num[v]=0 then
	  	  begin
	  	    dfs(v);
	  	    a[u] := a[u]+a[v];
	  	  end;
	  	j := next[j];
	  end;
end;

procedure main;
	var i,j,jj : longint;
begin
	dfs(1);
	for i := 1 to n+1 do
	 for j := -n to n do f[i,j] := oo;
	f[n+1,0] := 0;
	for i := n downto 1 do
	  for j := -n to n do
       begin
         jj := j-a[b[i]];
	     f[i,j] := f[i+1,j];
         if (jj >=-n) and (jj<=n) then
          f[i,j] := min(f[i,j],f[i+con[b[i]],jj]+1);
       end;
	writeln(f[1,a[1]-m]);
end;

begin
	nhap;
	main;
end.
