Uses math;
Const
	inp = 'otoci.in.10';
	out = 'otoci.out';
	maxn = 30001;

Var
	n,dem1,dem2,vmax,q,m,mm : longint;
	lab,num,thoat,start,pos,a,cha,dd,head,con : array [0..maxn] of longint;
    ke,next : array [-maxn..maxn] of longint;
	t : array [1..4*maxn] of longint;
	kind : array [1..maxn*10] of char;
	x,y : array [1..maxn*10] of longint;
	f : array [1..maxn,0..15] of longint;

function getroot(u : longint) : longint;
begin
	while lab[u]>0 do u := lab[u];
	getroot := u;
end;

procedure union(r1,r2 : longint);
	var x : longint;
begin
	x := lab[r1]+lab[r2];
	if lab[r1]>lab[r2] then
	  begin
	  	lab[r1] := r2;
	  	lab[r2] := x;
	  end
	else begin
		lab[r2] := r1;
		lab[r1] := x;
	end;
end;

procedure nhap;
	var i,j,u,v,r1,r2 : longint;
		ch : char;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do
	  begin
	    read(a[i]); lab[i] := -1;
	  end;
    mm := 0;
	readln(q);
	for i := 1 to q do
	  begin
	  	read(ch);
	  	kind[i] := ch;
	  	while ch<>' ' do read(ch);
	  	readln(x[i],y[i]);
	  	if kind[i]='b' then
	  	   begin
	  	   	  u := x[i]; v := y[i];
	  	   	  r1 := getroot(u); r2 := getroot(v);
	  	   	  if r1<>r2 then
	  	   	    begin
	  	   	    	union(r1,r2);
                    inc(mm);
	  	   	    	ke[mm] := v; next[mm] := head[u]; head[u] := mm;
	  	   	    	ke[-mm] := u; next[-mm]:= head[v]; head[v] := -mm;
	  	   	    end;
	  	   end;
	  end;
end;

procedure dfs(u : longint);
	var j,v : longint;
begin
	inc(dem1); num[u] := dem1; con[u] := 1;
	for j := 1 to vmax do
       f[u,j] := f[f[u,j-1],j-1];
	j := head[u];
	while j<>0 do
	  begin
	  	v := ke[j];
	  	if cha[v]=0 then
	  	  begin
	  	  	cha[v] := u; f[v,0] := u;
	  	  	dfs(v);
	  	  	con[u] := con[u]+con[v];
	  	  	if (dd[u]=0) or (con[dd[u]]<con[v]) then dd[u] := v;
	  	  end;
	  	j := next[j];
	  end;
	inc(dem2); thoat[u] := dem2;
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
	exit(cha[u]);
end;

function update(i,lo,hi,u,x : longint) : longint;
	var mid,c1,c2 : longint;
begin
	if lo=hi then
	  begin
	  	t[i] := x; exit;
	  end;
	mid := (lo+hi) shr 1; c1 := i*2; c2 := c1+1;
	if u <= mid then update(c1,lo,mid,u,x);
	if u > mid then update(c2,mid+1,hi,u,x);
	t[i] := t[c1]+t[c2];
end;

procedure init;
	var i,j,u,v : longint;
begin
	for i := 1 to n do lab[i] := -1;
	vmax := round(ln(n)/ln(2));
	for i := 1 to n do
	  if cha[i]=0 then
	    begin
	    	cha[i] := i; f[i,0] := i;
	    	dfs(i);
	    end;
	for i := 1 to n do
	 if dd[cha[i]]<>i then
	   begin
	   	  u := i;
	   	  inc(m); start[u] := u; pos[u] := m;
	   	  while dd[u]<>0 do
	   	    begin
	   	    	u := dd[u];
	   	    	inc(m); start[u] := i; pos[u] := m;
	   	    end;
	   end;
	for i := 1 to n do update(1,1,n,pos[i],a[i]);
end;

function get(i,lo,hi,u,v : longint) : longint;
	var mid,c1,c2 : longint;
begin
	if (u<=lo) and (hi<=v) then exit(t[i]);
	if (u>hi) or (v<lo) then exit(0);
	mid := (lo+hi) shr 1; c1 := i*2; c2 := c1+1;
	get := get(c1,lo,mid,u,v) + get(c2,mid+1,hi,u,v)
end;

function Query(u,v : longint) : longint;
	var res : longint;
begin
	res := 0;
	repeat
		if check(start[u],v) then
		  begin
		  	res := res + get(1,1,n,pos[v],pos[u]);
		  	exit(res);
		  end;
		res := res + get(1,1,n,pos[start[u]],pos[u]);
		u := cha[start[u]];
	until false;
end;

procedure main;
	var i,j,ii,r1,r2,u,v,pp,res : longint;
begin
	for i := 1 to q do
	  begin
	  	if kind[i]='b' then
	  	  begin
	  	  	 r1 := getroot(x[i]); r2 := getroot(y[i]);
	  	  	 if r1<>r2 then
	  	  	 begin
	  	  	   union(r1,r2);
	  	  	   writeln('yes');
	  	  	 end else writeln('no');
	  	  end
	  	else if kind[i]='p' then
	  	 begin
	  	   update(1,1,n,pos[x[i]],y[i]);
	  	   a[x[i]] := y[i];
	  	 end
	  	else begin
	  		r1 := getroot(x[i]); r2 := getroot(y[i]);
	  		if r1<>r2 then writeln('impossible')
	  		 else begin
	  		 	res := 0; u := x[i]; v := y[i];
                if check(u,v) then writeln(Query(v,u))
                 else if check(v,u) then writeln(Query(u,v))
                  else
                   begin
                       pp := lca(u,v);
                       writeln(Query(u,pp)+Query(v,pp)-a[pp]);
                   end;
	  		 end;
	  	end;
	  end;
end;

begin
	nhap;
	init;
	main;
end.
