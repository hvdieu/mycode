Uses math;
Const
	inp = 'VMST.INP';
	out = 'VMST.OUT';
	maxn = 1001;
	maxm = 1501;

Var
	n,m,i,u,v,u1,u2,u3,v1,v2,v3 : longint;
	head : array [1..maxn] of longint;
	ke,next : array [-maxm..maxm] of longint;
	free,indfs : array [1..maxn] of boolean;
    kq : array [1..maxn,1..maxn] of boolean;
	cha : array [1..maxn] of longint;

procedure dfs(u : longint);
	var j,v : longint;
begin
	free[u] := false; indfs[u] := true;
	j := head[u];
	while j <> 0 do
	begin
	 v := ke[j];
	 if free[v] then
	   begin
	   	  cha[v] := u;
	   	  kq[u,v] := true;
	   	  dfs(v);
	   end
	 else if (u1=0) and (cha[u]<>v) and (cha[v]<>u) then begin
	  	 if indfs[v] then
	  	 	begin
	  	 		u1 := u; v1 := v;
	  	 		u2 := u; v2 := cha[u];
	  	 		u3 := cha[u]; v3 := cha[cha[u]];
	  	 		kq[u1,v1] := false; kq[u2,v2] := false; kq[u3,v3] := false;
                kq[v1,u1] := false; kq[v2,u2] := false; kq[v3,u3] := false;
	  	 	end
	  	 else begin
	  	 	u1 := u; v1 := v;
	  	 	u2 := u; v2 := cha[u];
	  	 	u3 := v; v3 := cha[v];
	  	 	kq[u1,v1] := false; kq[u2,v2] := false; kq[u3,v3] := false;
            kq[v1,u1] := false; kq[v2,u2] := false; kq[v3,u3] := false;
	  	 end;
	 end;
	 j := next[j];
	end;
	indfs[u] := false;
end;

procedure inkq;
	var i,j : longint;
begin
	writeln(3);
	for i := 1 to n do
	 for j := 1 to n do
	  if kq[i,j] then writeln(i,' ',j);
	writeln(u1,' ',v1); writeln(u2,' ',v2);
	for i := 1 to n do
	 for j := 1 to n do
	  if kq[i,j] then writeln(i,' ',j);
	writeln(u1,' ',v1); writeln(u3,' ',v3);
	for i := 1 to n do
	 for j := 1 to n do
	  if kq[i,j] then writeln(i,' ',j);
	writeln(u2,' ',v2); writeln(u3,' ',v3);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m);
	for i := 1 to m do
	  begin
	  	readln(u,v);
	  	ke[i] := v; next[i] := head[u]; head[u] := i;
	  	ke[-i] := u; next[-i] := head[v]; head[v] := -i;
	  end;
	fillchar(free,sizeof(free),true);
	dfs(1);
	inkq;
end.
