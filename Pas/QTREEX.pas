Uses math;
Const
	inp = 'QTREE.INP';
	out = 'QTREEX.OUT';
	maxn = 10001;

Var
	ntest,n,dem1,dem2,vmax,m : longint;
	head,num,thoat,cha,dd,ts,p,pos,vt,con,a,start : array [0..maxn] of longint;
	f : array [0..maxn,0..15] of longint;
	t : array [1..2,1..4*maxn] of longint;
	tt : array [1..4*maxn] of longint;
	ke,next,w : array [-maxn..maxn] of longint;

procedure nhap;
	var i,j,u,v,l : longint;
begin
	readln(n);
	fillchar(head,sizeof(head),0);
	for i := 1 to n-1 do
	  begin
	  	 readln(u,v,l);
	  	 ke[i] := v; next[i] := head[u]; w[i] := l; head[u] := i;
	  	 ke[-i] := u; next[-i] := head[v]; w[-i] := l; head[v] := -i;
	  end;
end;

procedure dfs(u : longint);
	var j,v : longint;
begin
	inc(dem1); num[u] := dem1; con[u] := 1;
	for j := 1 to vmax do f[u,j] := f[f[u,j-1],j-1];
	j := head[u];
	while j <> 0 do
	  begin
	  	v := ke[j];
	  	if cha[v]=0 then
	  	  begin
	  	  	cha[v] := u; f[v,0] := u;
	  	  	ts[v] := w[j]; p[v] := abs(j);
	  	  	dfs(v);
	  	  	con[u] := con[u]+con[v];
	  	  	if (dd[u]=0) or (con[dd[u]]<con[v]) then dd[u] := v;
	  	  end;
	  	j := next[j];
	  end;
	inc(dem2); thoat[u] := dem2;
end;

procedure khoitao;
	var i,j,u : longint;
begin
	dem1 := 0; dem2 := 0; vmax := round(ln(n)/ln(2));
    m := 0;
	fillchar(dd,sizeof(dd),0);
	fillchar(cha,sizeof(cha),0);
    fillchar(tt,sizeof(tt),0);
	f[1,0] := 1; cha[1] := 1;
	dfs(1);
	for i := 1 to n do
	 if (dd[cha[i]]<>i) then
	   begin
	   	  u := i;
	   	  inc(m); a[m] := ts[u]; pos[p[u]] := m; vt[u] := m; start[u] := u;
	   	  while dd[u]<>0 do
	   	    begin
	   	    	u := dd[u];
	   	    	inc(m); a[m] := ts[u]; pos[p[u]] := m; vt[u] := m; start[u] := i;
	   	    end;
	   end;
end;

procedure init(i,lo,hi : longint);
	var mid : longint;
begin
	if (lo=hi) then
	  begin
	  	t[1,i] := a[lo]; t[2,i] := a[lo];
	  	exit;
	  end;
	mid := (lo+hi) shr 1;
	init(i*2,lo,mid);
	init(i*2+1,mid+1,hi);
	t[1,i] := min(t[1,i*2],t[1,i*2+1]);
	t[2,i] := max(t[2,i*2],t[2,i*2+1]);
end;

function check(u,v : longint) : boolean;
begin
	if (num[u]<=num[v]) and (thoat[u]>=thoat[v]) then exit(true)
	 else exit(false);
end;

function lca(u,v : longint) : longint;
	var j : longint;
begin
	for j := vmax downto 0 do
	 if check(f[u,j],v)=false then u := f[u,j];
	exit(u);
end;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure down(i : longint);
    var c1,c2 : longint;
begin
	swap(t[1,i],t[2,i]);
    c1 := i*2; c2 := i*2+1;
	t[1,i] := -t[1,i]; t[2,i] := -t[2,i];
	tt[i] := 0;
	if (c1<=4*maxn) and (c2<=4*maxn) then
	begin
	   tt[c1] := 1-tt[c1]; tt[c2] := 1-tt[c2];
	end;
end;

procedure update1(i,lo,hi,u,v : longint);
	var mid,c1,c2 : longint;
begin
	mid := (lo+hi) shr 1;
	c1 := i*2; c2 := c1+1;
	if (lo=u) and (hi=v) then
	   begin
          tt[i] := 1-tt[i];
          if tt[i]=1 then down(i);
          exit;
	   end;
    if tt[i]=1 then down(i);
    if tt[c1]=1 then down(c1);
    if tt[c2]=1 then down(c2);
	if u <= mid then update1(c1,lo,mid,u,min(mid,v));
	if v > mid then update1(c2,mid+1,hi,max(mid+1,u),v);
	t[1,i] := min(t[1,c1],t[1,c2]);
	t[2,i] := max(t[2,c1],t[2,c2]);
end;

procedure change(u,v : longint);
	var i,j : longint;
begin
	repeat
		if check(start[u],v) then
		  begin
		  	update1(1,2,n,vt[v],vt[u]);
		  	exit;
		  end;
		update1(1,2,n,vt[start[u]],vt[u]);
		u := cha[start[u]];
	until false;
end;

function get(i,lo,hi,u,v : longint) : longint;
	var mid,c1,c2,res : longint;
begin
	mid := (lo+hi) shr 1;
	c1 := i*2; c2 := i*2+1;
	if (lo=u) and (hi=v) then
	  begin
	  	if tt[i]=1 then down(i);
	  	exit(t[2,i]);
	  end;
	if tt[i]=1 then down(i);
    if tt[c1]=1 then down(c1);
    if tt[c2]=1 then down(c2);
	res := -maxlongint;
	if u <= mid then res := max(res,get(c1,lo,mid,u,min(mid,v)));
	if v > mid then res := max(res,get(c2,mid+1,hi,max(u,mid+1),v));
	exit(res);
end;

function Query(u,v : longint): longint;
	var res : longint;
begin
	res := -maxlongint;
	repeat
		if check(start[u],v) then
		  begin
		  	res := max(res,get(1,2,n,vt[v],vt[u]));
		  	exit(res);
		  end;
		res := max(res,get(1,2,n,vt[start[u]],vt[u]));
		u := cha[start[u]];
	until false;
end;

procedure update(i,lo,hi,u,x : longint);
	var mid,c1,c2 : longint;
begin
	mid := (lo+hi) shr 1;
	c1 := i*2; c2 := i*2+1;
	if (lo=u) and (hi=u) then
	  begin
	  	t[1,i] := x; t[2,i] := x;
	  	tt[i] := 0;
	  	exit;
	  end;
	if tt[i]=1 then down(i);
    if tt[c1]=1 then down(c1);
    if tt[c2]=1 then down(c2);
	if u <= mid then update(c1,lo,mid,u,x);
	if u > mid then update(c2,mid+1,hi,u,x);
	t[1,i] := min(t[1,c1],t[1,c2]);
	t[2,i] := max(t[2,c1],t[2,c2]);
end;

procedure main;
	var i,j,u,v,pp,x : longint;
		ch : char;
begin
	init(1,2,n);
	repeat
		read(ch);
		if ch='Q' then
		  begin
		  	while ch<>' ' do read(ch);
		  	readln(u,v);
		  	if u=v then writeln(0)
		  	 else begin
		  	 	if check(u,v) then writeln(Query(v,lca(v,u)))
		  	 	 else if check(v,u) then writeln(Query(u,lca(u,v)))
		  	 	  else writeln(max(Query(u,lca(u,v)),Query(v,lca(v,u))));
		  	 end;
		  end
		else if ch='C' then
		  begin
		  	while ch<>' ' do read(ch);
		  	readln(u,x);
		  	a[pos[u]] := x;
		  	update(1,2,n,pos[u],x);
		  end
		else if ch='N' then
		  begin
		  	while ch<>' ' do read(ch);
		  	readln(u,v);
		  	if u<>v then
		  	  begin
		  	  	if check(u,v) then change(v,lca(v,u))
		  	 	 else if check(v,u) then change(u,lca(u,v))
		  	 	  else begin
		  	 	  	change(u,lca(u,v));
		  	 	  	change(v,lca(v,u));
		  	 	  end;
		  	  end;
		  end
		else exit;
	until false;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	while ntest > 0 do
	  begin
	  	dec(ntest);
	  	readln;
	  	nhap;
	  	khoitao;
	  	main;
	  end;
end.
