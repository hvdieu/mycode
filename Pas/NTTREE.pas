Uses math;
Const
	inp = 'NTTREE.INP';
	out = 'NTTREE.OUT';
	maxn = 10001;

Var
	n : longint;
	head,con : array [1..maxn] of longint;
	a : array [1..maxn] of qword;
	ke,next,w : array [-maxn..maxn] of longint;
	free : array [1..maxn] of boolean;
	res : qword;
procedure nhap();
	var i,j,u,v,l : longint;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n-1 do
		begin
			readln(u,v,l); inc(u); inc(v);
			ke[i] := v; next[i] := head[u]; w[i] := l; head[u] := i;
			ke[-i] := u; next[-i] := head[v]; w[-i] := l; head[v] := -i;
		end;
	fillchar(free,sizeof(free),true);
end;

procedure dfs(u : longint);
	var j,v : longint;
		x : qword;
begin
	free[u] := false; j := head[u];
	while j<>0 do
		begin
			v := ke[j];
			if free[v] then
				begin
					dfs(v);
					x := w[j]*con[v]+a[v];
					res := res + x*con[u]+a[u]*con[v];
					con[u] := con[u]+con[v];
					a[u] := a[u]+x;
				end;
			j := next[j];
		end;
	res := res+a[u]; inc(con[u]);
end;

begin
	nhap;
	dfs(1);
	writeln(res);
end.
