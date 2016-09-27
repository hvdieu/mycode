Uses math;
Const
    inp = '';
    out = '';
    maxn = 200001;

Var
	n,k,dem,uu,res,kq,top,left,right : longint;
	check : array [1..maxn] of boolean;
	head,con,free,f,st,d,sl,d1,cha,mid : array [1..maxn] of longint;
	a : array [0..1000000] of longint;
	ke,next,w : array [-maxn..maxn] of longint;

procedure nhap;
	var i,j,u,v,c : longint;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,k);
	for i := 1 to n-1 do
	  begin
	  	 readln(u,v,c);
         inc(u); inc(v);
	  	 ke[i] := v; next[i] := head[u]; w[i] := c; head[u] := i;
	  	 ke[-i] := u; next[-i] := head[v]; w[-i] := c; head[v] := -i;
	  end;
end;

procedure visit(u,n : longint);
	var j,v,x : longint;
begin
	free[u] := dem; con[u] := 1; f[u] := 0;
	j := head[u];
	while j <> 0 do
	  begin
	  	v := ke[j];
	  	if (free[v]<>dem) and (check[v]=false) then
	  	  begin
	  	  	d[v] := d[u]+w[j]; d1[v] := d1[u]+1;
	  	  	if d[v] <= k then
	  	  	  begin
	  	  	  	inc(right); st[right] := d[v]; sl[right] := d1[v];
	  	  	  end;
	  	  	cha[v] := u;
	  	  	visit(v,n);
	  	  	con[u] := con[u]+con[v];
	  	  	f[u] := max(f[u],con[v]);
	  	  end;
	  	j := next[j];
	  end;
	x := max(f[u],n-con[u]);
	if x < kq then
	  begin
	  	kq := x; uu := u;
	  end;
end;

function find(x,n : longint) : longint;
	var i,j : longint;
begin
	inc(dem); kq := maxlongint; uu := 0;
	visit(x,n);
	exit(uu);
end;

procedure get(x,n : longint);
	var u,j,i,v : longint;
begin
	if n=1 then exit;
	u := mid[x];
	j := head[u];  check[u] := true;
    for i := 1 to right do a[st[i]] := 0;
    left := 0; right := 0;
	while j <> 0 do
	  begin
	  	v := ke[j];
	  	if (check[v]=false) then
	  	  begin
	  	  	 d[v] := w[j]; d1[v] := 1;
             if w[j] <= k then
               begin
                   inc(right); st[right] := w[j]; sl[right] := 1;
               end;
	  	  	 if cha[v]=u then mid[v] := find(v,con[v])
	  	  	  else mid[v] := find(v,n-con[v]);
	  	  	 for i := left+1 to right do
                begin
                  	if st[i]=k then res := min(res,sl[i]+1)
                  	  else if a[k-st[i]]<>0 then res := min(res,sl[i]+1+a[k-st[i]]);
                end;
             for i := left+1 to right do
                begin
                	if st[i]<>0 then
                      if a[st[i]]=0 then a[st[i]] := sl[i] else a[st[i]] := min(a[st[i]],sl[i]);
                end;
	  	  end;
	  	j := next[j]; left := right;
	  end;
	j := head[u];
	while j <> 0 do
	  begin
	  	 v := ke[j];
	  	 if check[v]=false then get(v,con[v]);
	  	 j := next[j];
	  end;
end;

procedure main;
	var i,j,v,u : longint;
begin
	res := maxlongint;
	u := find(1,n);
	mid[1] := u;
	cha[1] := 0;
	get(1,n);
    if res = maxlongint then write(-1)
     else write(res-1);
end;

begin
	nhap;
	main;
end.

