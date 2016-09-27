Uses math;
Const 
	inp = 'JOBSHOP.INP';
	out = 'JOBSHOP.OUT';
	maxn = 101;

Var
	m,n,k,u,v : longint;
	head,d1,d2,id : array [1..maxn] of longint;
	ke,next : array [1..maxn*maxn] of longint;
	free : array [1..maxn] of longint;
	ok : boolean;

procedure dfs(u : longint);
	var j,v : longint;
begin
	free[u] := false; j := head[u];
	while j <> 0 do 
	  begin
	  	v := ke[j];
	  	if free[v] then dfs(v)
	  	 else ok := false;
	  	j := next[j];
	  end;
end;

function check : boolean;
	var i,j : longint;
begin
	fillchar(free,sizeof(free),true);
	ok := true;
	for i := 1 to n do if free[i] then dfs(i);
	exit(ok);
end;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint);
	var i,j,k,k1,k2 : longint;
begin
	if l >= h then exit;
	i := l; j := h; k := l+random(h-l+1);
	k1 := d1[k]; k2 := d2[k];
	repeat
		while (d1[i]<k1) or ((d1[i]=k1) and (d2[i]>k2)) do inc(i);
		while (d1[j]>k1) or ((d1[j]=k1) and (d2[j]<k2)) do dec(j);
		if i <= j then 
		  begin
		  	 swap(d1[i],d1[j]); swap(d2[i],d2[j]); swap(id[i],id[j]);
		  	 inc(i); dec(k);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure main;
	var i,j,d : longint;
begin
	for i := 1 to n do id[i] := i;
	sort(1,n); d := 1;
	repeat
		for i := d to min(n,d+m-1) do 
		  begin
		  	if d1[i]<>0 then 
		  	  begin
		  	  	d := i;
		  	  	break;
		  	  end
		  	else begin
		  		d := i+1;
		  	end;
		  end;
	until false;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m);
	i := 0;
	for u := 1 to n do 
	  begin
	  	read(k); d1[u] := k;
	  	for j := 1 to k do 
	  	  begin
	  	  	read(v); inc(i);
	  	  	ke[i] := u; next[i] := head[v]; head[v] := i;
	  	  	inc(d2[v]);
	  	  end;
	  end;
	if check=false then writeln(-1)
	 else main;
end.