Uses math;
Const
	inp = 'TREE.INP';
	out = 'TREE.OUT';
	maxn = 100001;

Var
	n,i,u,v,kq1,kq2 : longint;
	head,cha,m1,m2,deg,d1,d2,a,b : array [1..maxn] of longint;
	ke,next : array [-maxn..maxn] of longint;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure capnhat(uu,vv : longint);
begin
	if kq1=0 then
	  	   begin
	  	   	kq1 := uu; kq2 := vv;
	  	   end
	  	 else if kq1>=uu then
	  	   begin
	  	   	if kq1>uu then
	  	   	  begin
	  	   	  	kq1 := uu; kq2 := vv;
	  	   	  end
	  	   	else if (kq1=uu) and (kq2>vv) then kq2 := vv;
	  	   end;
end;

procedure dfs(u : longint);
	var j,v,x,uu,vv : longint;
begin
	j := head[u];
	while j <> 0 do
	   begin
	   	  v := ke[j];
	   	  if cha[v]=0 then
	   	    begin
	   	    	cha[v] := u;
	   	    	inc(deg[u]);
	   	    	dfs(v);
	   	    	if (m1[u]=m2[u]) and (d1[u]>d2[u]) then swap(d1[u],d2[u]);
	   	    	if (m1[v]>m1[u]) or ((m1[v]=m1[u]) and (d1[v]<d1[u])) then
	   	    	  begin
	   	    	  	 m2[u] := m1[u]; d2[u] := d1[u];
	   	    	  	 m1[u] := m1[v]; d1[u] := d1[v];
	   	    	  end
	   	    	else if (m1[v]>m2[u]) or ((m1[v]=m2[u]) and (d1[v]<d2[u])) then
	   	    	  begin
	   	    	  	m2[u] := m1[v]; d2[u] := d1[v];
	   	    	  end;
	   	    end;
	   	  j := next[j];
	   end;
	if (m1[u]=-1) and (m2[u]=-1) then
	  begin
	  	d1[u] := u; m1[u] := deg[u];
	  	exit;
	  end;
	m1[u] := m1[u]+deg[u];
	x := m1[u]+1; if cha[u]<>u then inc(x);
	if x=n then
	  begin
	  	 uu := u; vv := d1[u];
	  	 if uu > vv then swap(uu,vv);
	  	 capnhat(uu,vv);
	  end;
	if m2[u]<>-1 then
	  begin
	  	x := m2[u]+m1[u]+1;
	  	if cha[u]<>u then inc(x);
	  	if x=n then
	  	  begin
	  	  	uu := d1[u]; vv := d2[u];
	  	  	if uu > vv then swap(uu,vv);
	  	  	capnhat(uu,vv);
	  	  end;
	  end;
	if (m1[u]=deg[u]) and (u<d1[u]) then d1[u] := u;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n-1 do
	  begin
	  	 readln(u,v);
	  	 ke[i] := v; next[i] := head[u]; head[u] := i;
	  	 ke[-i] := u; next[-i] := head[v]; head[v] := -i;
	  end;
	cha[1] := 1;
	for i := 1 to n do
	  begin
	    m1[i] := -1;
	    m2[i] := -1;
	  end;
	dfs(1);
	if kq1=0 then writeln(-1)
      else writeln(kq1,' ',kq2)
end.
