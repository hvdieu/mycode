{$inline on}
Uses math;
Const
	inp = 'krtica.in.10';
	out = 'krtica.out';
	maxn = 300001;

Var
	n,r1,r2,res,dem1,dem2,kq1,kq2,uu : longint;
	head,a,c,cha,d,h,f1,h2 : array [1..maxn] of longint;
	g : array [1..3,1..maxn] of longint;
	f,g1 : array [1..2,1..maxn] of longint;
	ke,next : array [-maxn..maxn] of longint;

procedure nhap; inline;
	var i,j,u,v : longint;
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
end;

procedure dfs(u : longint);
	var j,v,x : longint;
begin
	j := head[u];
	while j <> 0 do
	  begin
	  	v := ke[j];
	  	if cha[v]=0 then
	  	  begin
	  	  	cha[v] := u;
	  	  	dfs(v); x := a[v]+1;
	  	  	if x > a[u] then a[u] := x;
	  	  	if x > g[1,u] then
	  	  	  begin
	  	  	  	g[3,u] := g[2,u]; g[2,u] := g[1,u]; g[1,u] := x;
	  	  	  end
	  	  	else if x > g[2,u] then
	  	  	  begin
	  	  	  	g[3,u] := g[2,u]; g[2,u] := x;
	  	  	  end
	  	  	else if x > g[3,u] then g[3,u] := x;
	  	  	d[u] := max(d[v],d[u]);
	  	  	if d[v] > f[1,u] then
             begin
               f[2,u] := f[1,u];
               f[1,u] := d[v];
             end
	  	  	 else if d[v] > f[2,u] then f[2,u] := d[v];
	  	  end;
        j := next[j];
	  end;
	j := head[u];
	while j <> 0 do
	  begin
	  	 v := ke[j];
	  	 if cha[v]=u then
	  	   begin
	  	   	 if d[v]=f[1,u] then f1[v] := f[2,u]
	  	   	  else f1[v] := f[1,u];
	  	   	 if a[v]+1=g[1,u] then
	  	   	   begin
	  	   	   	g1[1,v] := g[2,u];
	  	   	   	g1[2,v] := g[3,u];
	  	   	   end
	  	   	 else if a[v]+1=g[2,u] then
	  	   	   begin
	  	   	   	g1[1,v] := g[1,u];
	  	   	   	g1[2,v] := g[3,u];
	  	   	   end
	  	   	 else begin
	  	   	 	g1[1,v] := g[1,u];
	  	   	 	g1[2,v] := g[2,u];
	  	   	 end;
	  	   end;
	  	j := next[j];
	  end;
	d[u] := max(d[u],g[1,u]+g[2,u]);
end;

procedure visit(u : longint);
	var j,v,da,db,x : longint;
begin
    x := 0;
	if u <> 1 then
	  begin
	  	 h[u] := max(h[cha[u]],f1[u]);
	  	 h[u] := max(h[u],g1[1,u]+g1[2,u]);
	  	 h2[u] := max(g1[1,u],h2[cha[u]]+1);
	  	 h[u] := max(h[u],h2[cha[u]]+1+g1[1,u]);
	  	 da := h[u]; db := d[u];
	  	 x := max(da,db);
	  	 x := max(x,(da+1) div 2+1+(db+1) div 2);
	  	 if x < res then
	  	   begin
	  	   	res := x; r1 := u; r2 := cha[u];
            kq1 := db; kq2 := da;
	  	   end;
	  end;
    if x <= res then
    begin
	j := head[u];
	while j <> 0 do
	  begin
	  	v := ke[j];
	  	if cha[v]=u then visit(v);
	  	j := next[j];
	  end;
    end;
end;

procedure loang(u,r2,x : longint);
    var j,v : longint;
begin
    if uu<>0 then exit;
    j := head[u]; a[u] := 0; f[1,u] := 0; f[2,u] := 0;
    while j <> 0 do
      begin
          if uu<>0 then exit;
          v := ke[j];
          if (cha[v]=0) and (v<>r2) then
            begin
                cha[v] := u;
                loang(v,r2,x);
                a[u] := max(a[u],a[v]+1);
                if a[v]+1 > f[1,u] then
                  begin
                    f[2,u] := f[1,u]; f[1,u] := a[v]+1;
                    c[u] := v;
                  end
                else if a[v]+1 > f[2,u] then f[2,u] := a[v]+1;
            end;
          j := next[j];
      end;
    if f[1,u]+f[2,u]=x then uu := u;
end;

function find(r1,r2,x : longint) : longint; inline;
    var j,v : longint;
begin
    fillchar(cha,sizeof(cha),0);
    cha[r1] := r1; dem1 := 0; dem2 := 0;
    uu := 0;
    loang(r1,r2,x);
    x := (f[1,uu]-(x+1) div 2);
    while x <> 0 do
     begin
       uu := c[uu];
       dec(x);
     end;
    exit(uu);
end;

procedure main; inline;
	var i,j : longint;
begin
	cha[1] := 1;h2[1] := -1;
	dfs(1);
	res := n;
	visit(1);
	writeln(res);
	writeln(r1,' ',r2);
    write(find(r1,r2,kq1),' ',find(r2,r1,kq2));
end;

begin
	nhap;
	main;
end.