{$Coperators ON}
Uses math;
Const
	inp = 'mroads.inp';
	out = 'mroads.out';
	maxn = 100001;

Var
	n,k,i,dem,c,mm : longint;
	head,con,num,d,id,cha,d1 : array [1..maxn] of longint;
	ke,next,a,b : array [-maxn..maxn] of longint;
	ok : boolean;

procedure nhap;
	var i,j,u,v,l1,l2 : longint;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,k);
	for i := 1 to n-1 do
	  begin
	  	  readln(u,v,l1,l2);
	  	  ke[i] := v; next[i] := head[u]; a[i] := l1; b[i] := l2; head[u] := i;
	  	  ke[-i] := u; next[-i] := head[v]; a[-i] := l1; b[-i] := l2; head[v] := -i;
	  end;
end;

procedure dfs(u : longint);
	var j,v : longint;
begin
	inc(dem); num[u] := dem; con[u] := 1;
	c := max(c,d[u]); id[dem] := u;
	j := head[u]; d1[u] := d[u];
	while j <> 0 do
	  begin
	  	v := ke[j];
	  	if num[v]=0 then
	  	  begin
	  	  	cha[v] := u;
	  	    d[v] := d[u]+a[j];
	  	  	dfs(v);
	  	  	con[u] += con[v];
	  	  	d1[u] := max(d1[u],d1[v]);
	  	  end;
	  	j := next[j];
	  end;
end;

procedure loang(u,bound,m : longint);
	var j,v,x,y,z : longint;
begin
	if (con[u]=1) then
	  begin
	  	ok := false;
	  	exit;
	  end;
	j := head[u];
	while j <> 0 do
	  begin
	  	v := ke[j];
	  	if cha[v]=u then
	  	  begin
	  	  	x := d1[v]+m;
	  	  	if x > bound then
	  	  	  begin
	  	  	  	 y := x-bound;
	  	  	  	 z := a[j]-b[j];
	  	  	  	 if y <= z then dec(mm,y)
	  	  	  	  else begin
	  	  	  	  	dec(mm,z);
 					loang(v,bound,m-z);
	  	  	  	  end;
	  	  	  end;
	  	  end;
	  	j := next[j];
	  end;
end;

function check(mid : longint) : boolean;
	var i,j : longint;
begin
	mm := k;
    ok := true;
	loang(1,mid,0);
	if mm < 0 then exit(false);
	if ok=false then exit(false);
    exit(True);
end;

procedure main;
	var i,j,mid,res,d  : longint;
begin
	cha[1] := 1;
	dfs(1);
	d := 0;
    check(4);
	while d <= c do
	  begin
	  	 mid := (d+c) shr 1;
	  	 if check(mid) then
	  	   begin
	  	   	 res := mid; c := mid-1;
	  	   end
	  	 else d := mid+1;
	  end;
	writeln(res);
end;

begin
	nhap;
	main;
end.
