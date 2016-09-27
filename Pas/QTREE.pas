{$Q+, $R+, $S+}
Uses math;
const
	inp = 'QTREE.INP';
	out = 'QTREE.OUT';
	maxn = 10001;

Var
	ntest,n,dem1,dem2,m,vmax : longint;
	head,cha,num,thoat,po,con,dd,a,p,q,start,vt,ts : array [0..maxn] of longint;
	free : array [0..maxn] of boolean;
	f : array [0..maxn,0..16] of longint;
	t : array [0..4*maxn] of longint;
	ke,next,w,id : array [-maxn..maxn] of longint;

procedure nhap;
	var i,j,u,v,l : longint;
begin
	fillchar(head,sizeof(head),0);
	readln(n);
	for i := 1 to n-1 do
	  begin
	  	readln(u,v,l);
	  	ke[i] := v; next[i] := head[u]; w[i] := l; head[u] := i;
	  	id[i] := i;
	  	ke[-i] := u; next[-i] := head[v]; w[-i] := l; head[v] := -i;
	  	id[-i] := i;
	  end;
end;


procedure dfs(u : longint);
	var j,v : longint;
begin
	con[u] := 1; inc(dem1); num[u] := dem1;
	for j := 1 to vmax do
	  f[u,j] := f[f[u,j-1],j-1];
	j := head[u];
	while j<>0 do
	  begin
	   	v := ke[j];
	   	if cha[v]=0 then
	   	  begin
	   	  	cha[v] := u; f[v,0] := u; p[v] := id[j]; ts[v] := w[j];
	   	  	dfs(v);
	   	  	con[u] := con[u]+con[v];
	   	  	if (dd[u]=0) or (con[v]>con[dd[u]]) then dd[u] := v;
	   	  end;
        j := next[j];
	   end;
	inc(dem2); thoat[u] := dem2;
end;

procedure khoitao;
	var i,j,u : longint;
begin
	dem1 := 0; dem2 := 0; m := 0;
	fillchar(cha,sizeof(cha),0);
	fillchar(dd,sizeof(dd),0);
        f[1,0] := 1;
	cha[1] := 1; vmax := round(ln(n)/ln(2)); ts[1] := -maxlongint;
	dfs(1);
	fillchar(free,sizeof(free),true);
	for i := 1 to n do
	 if (free[i]) and (dd[cha[i]]<>i) then
	   begin
	   	  u := i;
	   	  inc(m); q[m] := u; po[p[u]] := m; start[u] := u;
	   	  vt[u] := m; a[m] := ts[u];
          free[u] := false;
	   	  while dd[u]<>0 do
	   	    begin
	   	    	u := dd[u];
	   	    	inc(m); q[m] := u; po[p[u]] := m; start[u] := start[q[m-1]];
	   	    	vt[u] := m;
	   	    	a[m] := ts[u];
                free[u] := false;
	   	    end;
	   end;
end;

procedure init(i,lo,hi : longint);
	var mid : longint;
begin
	if lo=hi then
	  begin
	  	t[i] := a[lo]; exit;
	  end;
	mid := (lo+hi) shr 1;
	init(i*2,lo,mid); init(i*2+1,mid+1,hi);
	t[i] := max(t[i*2],t[i*2+1]);
end;

procedure update(i,lo,hi,u,x : longint);
	var mid : longint;
begin
	if (u<lo) or (u>hi) then exit;
    if lo=hi then
	  begin
	  	t[i] := x; exit;
	  end;
	mid := (lo+hi) shr 1;
	update(i*2,lo,mid,u,x);
	update(i*2+1,mid+1,hi,u,x);
	t[i] := max(t[i*2],t[i*2+1]);
end;

function check(u,v : longint) : boolean;
	begin
		if (num[u]<=num[v]) and (thoat[u]>=thoat[v]) then exit(true)
		 else exit(False);
	end;

function lca(u,v : longint) : longint;
	var j : longint;
begin
	for j := vmax downto 0 do
	 if check(f[u,j],v)=false then u := f[u,j];
	exit(u);
end;

function get(i,lo,hi,u,v : longint) : longint;
	var mid,res : longint;
begin
	if (lo>v) or (hi<u) then exit(-maxlongint);
    if (u<=lo) and (hi<=v) then exit(t[i]);
	mid := (lo+hi) shr 1;
	res := max(get(i*2,lo,mid,u,v),get(i*2+1,mid+1,hi,u,v));
    exit(Res);
end;

function Query(u,v : longint) : longint;
	var i,j,res : longint;
begin
	res := -maxlongint;
	repeat
		if check(start[u],v) then
		  begin
		  	res := max(res,get(1,1,n,vt[v],vt[u]));
		  	exit(res);
		  end;
		res := max(res,get(1,1,n,vt[start[u]],vt[u]));
		u := cha[start[u]];
	until false;
end;

procedure main;
	var i,j,u,x,pp,v,res : longint;
		ch : char;
begin
	init(1,1,n);
	repeat
		read(ch);
		if ch='D' then
        begin
          readln;
          break;
        end;
		if ch='C' then
		  begin
            for i := 1 to 5 do read(ch);
		  	readln(u,x);
            a[po[u]] := x;
		  	update(1,1,n,po[u],x);
		  end
		else begin
            for i := 1 to 4 do read(ch);
			readln(u,v);
            if u=v then writeln(-maxlongint)
            else begin
			if check(u,v) then writeln(Query(v,lca(v,u)))
			 else if check(v,u) then writeln(Query(u,lca(u,v)))
			  else
			   begin
			   	 pp := lca(u,v);
			   	 res := Query(u,pp);
                 pp := lca(v,u);
			   	 res := max(res,Query(v,pp));
			   	 writeln(res);
			   end;
            end;
		end;
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

