Uses math;
Const
	inp = 'tribe.inp';
	out = 'tribe.out';
	maxn = 100001;

Var
	n,res : longint;
	head,f,g,cha,h,s,id : array [0..maxn] of longint;
	ke,next : array [-maxn..maxn] of longint;

procedure nhap;
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

procedure swap(Var xx,yy : longint);
    var temp : longint;
begin
    temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint);
    var i,j,k : longint;
begin
    if l >= h then exit;
    i := l; j := h; k := s[l+random(h-l+1)];
    repeat
       while s[i] < k do inc(i);
       while s[j] > k do dec(j);
       if i <= j then
         begin
             swap(s[i],s[j]);
             swap(id[i],id[j]);
             inc(i); dec(j);
         end;
    until i > j;
    sort(l,j); sort(i,h);
end;

procedure dfs(u : longint);
	var j,v,dem,top : longint;
begin
	j := head[u]; f[u] := 1;
	while j <> 0 do
	  begin
	  	v := ke[j];
	  	if cha[v]=0 then
	  	  begin
	  	  	cha[v] := u;
	  	  	dfs(v);
	  	  end;
	  	j := next[j];
	  end;
	j := head[u]; dem := 0; top := 0;
    while j <> 0 do
      begin
          v := ke[j];
          if cha[v]=u then
            begin
                inc(top);
                s[top] := f[v];
            end;
          j := next[j];
      end;
    sort(1,top); dem := 0;
    for j := 1 to top do
     if s[j]>=dem+1 then inc(dem);
    f[u] := dem+1;
    res := max(res,dem+1);
end;

procedure visit(u : longint);
	var j,v,dem,top,i : longint;
begin
	j := head[u]; top := 0;
	while j <> 0 do
	  begin
	  	v := ke[j];
	  	if cha[v]=u then
          begin
              inc(top); s[top] := f[v];
              id[top] := v;
          end;
	  	j := next[j];
	  end;
    dem := 1;
    if (h[u]<>0) then
      begin
         inc(top); s[top] := h[u];
      end;
    sort(1,top); dem := 0;
    for j := 1 to top do
     if s[j]>=dem+1 then inc(dem);
    res := max(res,dem+1);
    for j := 1 to top do
      begin
          dem := 0;
          for i := 1 to top do
           if (j<>i) and (s[i]>=dem+1) then inc(dem);
          h[id[j]] := dem+1;
      end;
    j := head[u];
    while j <> 0 do
      begin
          v := ke[j];
          if cha[v]=u then visit(v);
          j := next[j];
      end;
end;

begin
	nhap;
	cha[1] := 1;
	dfs(1);
	visit(1);
	writeln(res);
end.
