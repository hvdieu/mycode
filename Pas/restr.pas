Uses math;
Const
	inp = 'restr.inp';
	out = 'restr.out';
	maxn = 200010;

Var
	x,y,a,id : array [0..maxn] of longint;
	free,indfs : array [1..maxn] of boolean;
	head,d,cha,deg : array [1..maxn] of longint;
	ke,next : array [-maxn..maxn] of longint;
	n,m,ntest,dem,nn,i,u,v : longint;
	ok : boolean;

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
		  	swap(id[i],id[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure roirac;
    var i,j,sl,u,v : longint;
begin
    sort(1,dem);
	sl := 0;
	for i := 1 to dem do
	  begin
	  	if a[i]<>a[i-1] then inc(sl);
	  	if id[i]>m then y[id[i]-m] := sl
	  	 else x[id[i]] := sl;
	  end;
	nn := n; n := sl;
end;

procedure init;
	var i,j,sl,u,v : longint;
begin
	for i := 1 to n do
	  begin
	    head[i] := 0; cha[i] := 0; deg[i] := 0;
	    free[i] := true; indfs[i] := false;
	  end;
	for i := 1 to m do
	  begin
	  	u := x[i]; v := y[i];
        if u<>v then
        begin
	  	ke[i] := v; next[i] := head[u]; head[u] := i;
	  	ke[-i] := u; next[-i] := head[v]; head[v] := -i;
        end;
	  end;
	ok := true;
end;

procedure dfs(u : longint);
	var j,v,x : longint;
begin
	if ok = false then exit;
	free[u] := false; indfs[u] := true;
	j := head[u];
	while j<>0 do
	  begin
	  	v := ke[j];
	  	if free[v] then
	  	  begin
	  	  	cha[v] := u; d[v] := d[u]+1;
	  	  	inc(deg[u]); inc(deg[v]);
	  	  	dfs(v);
	  	  end
	  	else if (cha[u]<>v) and (cha[v]<>u) then
	  	  begin
	  	  	if indfs[v] then x := d[u]-d[v]+1
	  	  	 else x := d[u]+d[v]-1;
	  	  	if x<>nn then ok := false;
	  	  end;
	  	j := next[j];
	  end;
	if deg[u]>=3 then ok := false;
	indfs[u] := false;
end;

procedure main;
	var i,j : longint;
begin
    if n >= 100000 then roirac
     else nn := n;
	init;
	for i := 1 to n do
	 if free[i] then
	   begin
	    	d[i] := 1;
	    	dfs(i);
	   end;
	if ok then writeln('Y') else writeln('N');
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	while ntest > 0 do
	  begin
	  	dec(ntest);
	  	readln(n,m); dem := 0;
	  	for i := 1 to m do
	  	  begin
	  	  	read(x[i],y[i]);
	  	  	inc(dem); a[dem] := x[i]; id[dem] := i;
	  	  	inc(dem); a[dem] := y[i]; id[dem] := i+m;
	  	  end;
	  	main;
	  end;
end.
