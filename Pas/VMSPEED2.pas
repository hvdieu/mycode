Uses math;
Const
	inp = 'input.txt';
	out = 'asd.out';
	maxn = 501;
	maxm = 10001;
	oo = 1000000000000;
	eps = 0.0000001;

Var
	m,n,l1,l2,u,v,i : longint;
	head : array [1..maxn] of longint;
	ke,next : array [1..maxm] of longint;
	s,t : array [1..maxm] of double;
	free : array [1..maxn] of boolean;
	d : array [1..maxn] of double;
	res,dau,c,mid,bb : double;
    ok : boolean;

procedure dfs(u : longint);
	var j,v : longint;
begin
	free[u] := false;
	j := head[u];
	while j <> 0 do
	  begin
	  	v := ke[j];
	  	if free[v] then dfs(v);
	  	j := next[j];
	  end;
end;

function check(x : double) : boolean;
	var i,j,k,countloop : longint;
		stop : boolean;
begin
	for i := 1 to n do d[i] := oo;
	d[1] := 0;
	for countloop := 1 to n+1 do
	  begin
        if countloop=n+1 then exit(true);
	  	stop := true;
	  	for u := 1 to n do
	  	  begin
	  	  	 j := head[u];
	  	  	 while j <> 0 do
	  	  	   begin
	  	  	   	v := ke[j];
	  	  	   	if d[v] > d[u]+s[j]-x*t[j]+eps then
	  	  	   	  begin
	  	  	   	  	d[v] := d[u]+s[j]-x*t[j];
	  	  	   	  	stop := false;
	  	  	   	  end;
	  	  	   	j := next[j];
	  	  	   end;
	  	  end;
	  	if stop then break;
	  end;
	if d[n] <=0 then exit(true)
	 else exit(false);
end;

procedure main;
	var i,j : longint;
begin
	dau := 0; c := bb;
	res := oo;
	fillchar(free,sizeof(free),true);
    dfs(1);
	if free[n] then
	  begin
	  	writeln(-1); exit;
	  end;
	while dau <= c-eps do
	  begin
	  	mid := (dau+c)/2;
	  	if check(mid) then
	  	  begin
	  	  	c := mid-eps;
	  	  	res := mid;
	  	  end
	  	else dau := mid+eps;
	  end;
	if res=oo then writeln(-1)
	 else writeln(res:0:6);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m);
	for i := 1 to m do
	  begin
	  	 readln(u,v,l1,l2);
	  	 ke[i] := v; next[i] := head[u]; head[u] := i; s[i] := l1; t[i] := l2;
         bb := bb+l1;
	  end;
	main;
end.
