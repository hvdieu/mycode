uses math;
Const
	inp = '';
	out = '';
	maxn = 80;

Var
	a : array [1..maxn,1..maxn] of integer;
	i,j,n,res,m,dem,top,count,id : longint;
	kq,t : array [1..7] of longint;
	gt,q : array [1..maxn] of longint;
	head,low,num,st,lab : array [1..maxn] of longint;
	ke,next,w : array [1..maxn*maxn] of longint;
	free : array [1..maxn] of boolean;

procedure check;
	var i,j,x,m : longint;
begin
	for i := 1 to n do
	 for j := 1 to n do
	  if i<>j then
	    begin
	    	x := a[i,j];
	    	if t[i]=t[j] then
	    	  begin
	    	  	if (x=1) or (x=-1) then exit;
	    	  end
	    	else if t[i] > t[j] then
	    	  begin
	    	  	if (x=0) or (x=1) or (x=2) then exit;
	    	  end
	    	else if (x=0) or (x=-1) or (x=-2) then exit;
	    end;
	m := 0;
	for i := 1 to n do m := max(m,t[i]);
	if m < res then
	  begin
	  	res := m;
	  	kq := t;
	  end;
end;

procedure ql(i : longint);
	var j : longint;
begin
	if i > n then
	  begin
	  	check;
	  	exit;
	  end;
	for j := 1 to n do
	  begin
	  	t[i] := j;
	  	ql(i+1);
	  end;
end;

procedure trau;
	var i,j : longint;
begin
	res := n+1;
	ql(1);
    writeln(res);
	for i := 1 to n do write(kq[i],' ');
end;

procedure noi(u,v,x : longint);
begin
	inc(m);
	ke[m] := v; w[m] := x; next[m] := head[u]; head[u] := m;
end;

procedure dfs(u : longint);
	var j,v : longint;
begin
	inc(Dem); num[u] := dem; low[u] := num[u];
	inc(top); st[top] := u;
	j := head[u];
	while j <> 0 do
	  begin
	  	v := ke[j];
	  	if free[v] then
	  	  begin
	  	   if num[v]=0 then
	  	    begin
	      	  	dfs(v);
	  	  	    low[u] := min(low[u],low[v]);
	  	  	end
	  	   else low[u] := min(low[u],num[v]);
	  	  end;
        j := next[j];
	  end;
	if low[u]=num[u] then
	  begin
	  	 inc(count); lab[u] := count;
	  	 repeat
	  	 	v := st[top];
	  	 	dec(top); lab[v] := count;
	  	 	free[v] := false;
	  	 until u=v;
	  end;
end;

procedure xaydothi;
	var u,j,i,v : longint;
begin
	fillchar(head,sizeof(head),0);
	m := 0;
	for i := 1 to n do
	 for j := 1 to n do
	   if (i<>j) and (lab[i]<>lab[j]) then
	     begin
	     	u := lab[i]; v := lab[j];
	     	case a[i,j] of
	   	    0 : begin noi(u,v,0); noi(v,u,0); end;
	   	    1 : begin noi(u,v,1); end;
	   	    2 : begin noi(u,v,0); end;
	   	    -1 : begin noi(v,u,1); end;
	   	    -2 : begin noi(v,u,0); end;
	   	  end;
	     end;
end;

procedure loang(u : longint);
var j,v : longint;
        begin
            free[u] := false;
            j := head[u];
            while j <> 0 do
              begin
                 v := ke[j];
                 if free[v] then loang(v);
                 j := next[j];
              end;
            num[u] := id; q[id] := u; dec(id);
        end;

procedure sorttopo;
	var i,j : longint;
begin
	fillchar(free,sizeof(free),true);
	id := count;
	for i := 1 to count do
	 if free[i] then loang(i);
end;

procedure qhd;
	var i,j,u,v : longint;
begin
	for u := 1 to count do gt[u] := 1;
	for i := 1 to count do
	  begin
        u := q[i];
	  	j := head[u];
	  	while j <> 0 do
	  	  begin
	  	  	v := ke[j];
	  	  	gt[v] := max(gt[v],gt[u]+w[j]);
            j := next[j];
	  	  end;
	  end;
	res := 0;
	for i := 1 to n do res := max(res,gt[i]);
end;

procedure sub2;
	var i,j : longint;
begin
	for i := 1 to n do
	 for j := 1 to n do
	  if i<>j then
	   begin
	   	  case a[i,j] of
	   	    0 : begin noi(i,j,0); noi(j,i,0); end;
	   	    1 : noi(i,j,1);
	   	    2 : noi(i,j,0);
	   	    -1 : noi(j,i,1);
	   	    -2 : noi(j,i,0);
	   	  end;
	   end;
    fillchar(free,sizeof(free),true);
	for i := 1 to n do
	  if num[i]=0 then
        dfs(i);
	xaydothi;
	sorttopo;
	qhd;
    writeln(res);
	for i := 1 to n do write(gt[lab[i]],' ');
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do
	 for j := 1 to n do read(a[i,j]);
	if n <= 7 then trau
	 else sub2;
end.

