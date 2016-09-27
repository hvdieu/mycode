Uses math;
Const
	inp = 'CAKES.INP';
	out = 'CAKES.OUT';
	maxn = 100001;
	maxm = 250001;
Var
	n,m,i,u,v : longint;
	res : int64;
	head : array [1..maxn] of longint;
	ke,next : array [-maxm..maxm] of longint;
	free : array [1..maxn] of boolean;

procedure main;
	var i,j,k,jj,v,u : longint;
begin
	fillchar(free,sizeof(free),true);
	for i := 1 to n do  
	 if free[i] then dfs(i);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m);
	for i := 1 to n do read(a[i]);
	for i := 1 to m do
	  begin
	  	readln(u,v);
	  	ke[i] := v; next[i] := head[u]; head[u] := i;
	  	ke[-i] := u; next[-i] := head[v]; head[v] := -i;
	  end;
	main;
end.
