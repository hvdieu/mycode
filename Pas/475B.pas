Uses math;
Const
	inp = '';
	out = '';
	maxn = 21;

Var
	a,b : array [1..maxn] of char;
	free : array [1..maxn,1..maxn,1..maxn,1..maxn] of boolean;
    i,j,u,v,m,n : longint;

procedure dfs(i1,j1,i,j : longint);
	var u,v : longint;
begin
	free[i1,j1,i,j] := false;
	if (a[i] = '<') then
	  begin
	  	u := i; v := j-1;
	  end
	else begin u := i; v := j+1; end;
	if (u>0) and (v>0) and (u<=m) and (v<=n) and (free[i1,j1,u,v])then dfs(i1,j1,u,v);
	if b[j]='^' then
	  begin
	  	u := i-1; v := j;
	  end
	else begin u := i+1; v := j; end;
	if (u>0) and (v>0) and (u<=m) and (v<=n) and (free[i1,j1,u,v]) then dfs(i1,j1,u,v);
end;

begin
	assign(input,inp) ;reset(input);
	assign(output,out); rewrite(output);
	readln(m,n);
	for i := 1 to m do read(a[i]);
	readln;
	for i := 1 to n do read(b[i]);
	fillchar(free,sizeof(free),true);
	for i := 1 to m do
	 for j := 1 to n do
	  dfs(i,j,i,j);
	for i := 1 to m do
	 for j := 1 to n do
	  for u := 1 to m do
	   for v := 1 to n do
	    if free[i][j][u][v] then
	      begin
	      	write('NO');
	      	halt;
	      end;
	write('YES');
end.
