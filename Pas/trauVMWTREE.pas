Uses math;
Const
	inp = 'VMWTREE.INP';
	out = 'vmwtree1.out';
	maxn = 100001;

Var
	n,q,i,u,v,dem1,dem2,vmax,top : longint;
	a,head,num,thoat,cha,d,st : array [1..maxn] of longint;
	ke,next : array [-maxn..maxn] of longint;
	p,g,f : array [1..maxn,0..20] of longint;

procedure update(u : longint);
    var j : longint;
begin
	f[u,0] := a[cha[u]]; g[u,0] := a[cha[u]];
	for j := 1 to vmax do
	  begin
	  	p[u,j] := p[p[u,j-1],j-1];
	  	f[u,j] := max(f[u,j-1],f[p[u,j-1],j-1]);
	  	g[u,j] := min(g[u,j-1],g[p[u,j-1],j-1]);
	  end;
end;

procedure dfs(u : longint);
	var j,v : longint;
begin
	inc(dem1); num[u] := dem1;
	update(u);
	j := head[u];
	while j <> 0 do
	  begin
	  	v := ke[j];
	  	if cha[u]<>v then
	  	 begin
	  	 	cha[v] := u; p[v,0] := u;
	  	 	d[v] := d[u]+1;
	  	 	dfs(v);
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

procedure get(k,u,v : longint);
	var j,pp,i,lmax1,lmax2,lmin1,lmin2 : longint;
begin
	lmin1 := a[u]; lmin2 := a[v];
	lmax1 := a[u]; lmax2 := a[v];
    if u=v then
      begin
          writeln(a[u]);
          exit;
      end;
	if check(v,u) then
	   begin
	   	 for j := vmax downto 0 do
	   	   if check(p[u,j],v)=false then
	   	     begin
	   	     	lmin1 := min(lmin1,g[u,j]);
	   	     	lmax1 := max(lmax1,f[u,j]);
	   	     	u := p[u,j];
	   	     end;
	   	  lmin1 := min(lmin1,g[u,0]);
	   	  lmax1 := max(lmax1,f[u,0]);
	   end else
	if check(u,v) then
	   begin
	   	  for j := vmax downto 0 do
	   	    if check(p[v,j],u)=false then
	   	      begin
	   	      	lmin2 := min(lmin2,g[v,j]);
	   	      	lmax2 := max(lmax2,f[v,j]);
	   	      	v := p[v,j];
	   	      end;
	   	   lmin2 := min(lmin2,g[v,0]);
	   	   lmax2 := max(lmax2,f[v,0]);
	   end else
       begin
           for j := vmax downto 0 do
	   	   if check(p[u,j],v)=false then
	   	     begin
	   	     	lmin1 := min(lmin1,g[u,j]);
	   	     	lmax1 := max(lmax1,f[u,j]);
	   	     	u := p[u,j];
	   	     end;
	   	  lmin1 := min(lmin1,g[u,0]);
	   	  lmax1 := max(lmax1,f[u,0]);
           for j := vmax downto 0 do
	   	    if check(p[v,j],u)=false then
	   	      begin
	   	      	lmin2 := min(lmin2,g[v,j]);
	   	      	lmax2 := max(lmax2,f[v,j]);
	   	      	v := p[v,j];
	   	      end;
	   	   lmin2 := min(lmin2,g[v,0]);
	   	   lmax2 := max(lmax2,f[v,0]);
       end;
	if k=1 then writeln(min(lmin1,lmin2))
	 else writeln(max(lmax1,lmax2));
end;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure Query(u,v : longint);
	var i,j,temp,pp,right : longint;
begin
	if u=v then exit;
	if check(u,v) then swap(u,v);
	top := 0;
	if check(v,u) then
	  begin
	    while u<>v do
	      begin
	  	     inc(top); st[top] := u;
	  	     u := cha[u];
	  	  end;
	  	  inc(top); st[top] := v;
	  end
	else begin
		i := u;
		while check(i,v)=false do
		  begin
		  	inc(top); st[top] := i;
		  	i := cha[i];
		  end;
		pp := i; inc(top); st[top] := pp;
		right := d[v]+d[u]-2*d[pp]+2;
		i := v;
		while check(i,u)=false do
		  begin
		  	dec(right); st[right] := i;
		  	i := cha[i];
		  end;
		top := d[v]+d[u]-2*d[pp]+1;
	end;
	for i := 1 to top div 2 do swap(a[st[i]],a[st[top-i+1]]);
	dem1 := 0; dem2 := 0;
	dfs(1);
end;

procedure main;
	var i,j,u,v,k : longint;
begin
	vmax := trunc(ln(n)/ln(2));
	for i := 1 to n do
	 for j := 0 to vmax do
	   begin
	   	 f[i,j] := -maxlongint;
	   	 g[i,j] := maxlongint;
	   end;
	cha[1] := 1; p[1,0] := 1; f[1,0] := a[1]; g[1,0] := a[1];
	d[1] := 0;
	dfs(1);
	while q > 0 do
	  begin
	  	dec(q);
	  	readln(k,u,v);
	  	if k <= 2 then get(k,u,v)
	  	 else Query(u,v);
	  end;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,q);
	for i := 1 to n do read(a[i]);
	for i := 1 to n-1 do
	  begin
	  	readln(u,v);
	  	ke[i] := v; next[i] := head[u]; head[u] := i;
	  	ke[-i] := u; next[-i] := head[v]; head[v] := -i;
	  end;
	main;
end.
