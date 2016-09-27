{$COperators ON}
Uses math;
Const
	inp = 'UCF.in';
	out = 'UCF.out';
	maxn = 501;
	maxm = 2500;
	oo = 1000000007;

Var
	n,m,i,u,v,nn,ntest,res,sl,r1,cp,sum : longint;
	a,head,deg,head1,con,cha : array [0..maxn] of longint;
	ke,next,ke1,next1 : array [-maxm..maxm] of longint;
	free,select : array [0..maxn] of boolean;
	f : array [0..maxn] of int64;
    c : array [0..500,0..500] of longint;

procedure dfs(u : longint);
	var j,v,x : longint;
begin
	f[u] := 1;
    if deg[u]=1 then con[u] := 0
     else con[u] := 1;
	j := head[u];
	while j <> 0 do
	  begin
	  	v := ke[j];
        if cha[v]=0 then
          begin
            cha[v] := u;
	  	    dfs(v);
	  	    con[u] := con[u]+con[v];
          end;
	  	j := next[j];
	  end;
	j := head[u]; x := con[u]-1;
	while j <> 0 do
	  begin
	  	v := ke[j];
        if cha[v]=u then
          begin
	  	    f[u] := (((f[u]*c[con[v],x]) mod oo)*f[v]) mod oo;
	  	    dec(x,con[v]);
          end;
	  	j := next[j];
	  end;
end;

procedure loang(u : longint);
    var j,v,x : longint;
begin
    f[u] := 1; con[u] := 1;
    j := head[u];
    while j <> 0 do
      begin
          v := ke[j];
          if (cha[v]=-1) and (select[v]) then
           if ((u=0) and (free[v])) or ((u<>0) and (free[v]=false)) then
            begin
                cha[v] := u;
                loang(v);
                con[u] += con[v];
            end;
          j := next[j];
      end;
    j := head[u]; x := con[u]-1;
    while j <> 0 do
      begin
          v := ke[j];
          if cha[v]=u then
            begin
             f[u] := (((f[u]*c[con[v],x]) mod oo)*f[v]) mod oo;
	  	     dec(x,con[v]);
            end;
          j := next[j];
      end;
end;

procedure build;
	var i,j : longint;
begin
	i := 0;
	fillchar(head1,sizeof(head1),0);
	for u := 1 to n do
	 if select[u] and free[u] then
	   begin
	   	 inc(m); ke[m] := u; next[m] := head[0]; head[0] := m;
	   end;
end;

procedure sub1;
    var i,j : longint;
begin
    cp := 0; r1 := maxlongint;
    for i := 1 to n do if deg[i]=1 then dec(sum,a[i]);
    for i := 1 to n do
      begin
         if deg[i]=1 then
         begin
          if sum+a[i] <= r1 then
            begin
               fillchar(cha,sizeof(cha),0);
               cha[i] := i;
               dfs(i);
               if sum+a[i]=r1 then res := (res+f[i]) mod oo
                else begin
                    res := f[i];
                    r1 := sum+a[i];
                end;
            end
          end
          else
           if sum<=r1 then
            begin
               fillchar(cha,sizeof(cha),0);
               cha[i] := i;
               dfs(i);
               if sum=r1 then res := (res+f[i]) mod oo
                else begin
                    res := f[i];
                    r1 := sum;
                end;
            end;
      end;
    writeln(1,' ',r1,' ',res);
end;

procedure sub2;
	var i,j,u,v : longint;
     stop : boolean;
begin
	fillchar(free,sizeof(free),true);
	fillchar(select,sizeof(select),false);
	res := 0; sl := n;
	repeat
        stop := true;
		for u := 1 to n do
		 if free[u] and (deg[u]=1) then
		   begin
		   	free[u] := false;
            stop := false;
		   	dec(sl);
		   	j := head[u];
		   	while j <> 0 do
		   	  begin
		   	  	v := ke[j];
		   	  	if free[v] then
		   	  	  begin
		   	  	  	dec(deg[v]);
		   	  	  	select[v] := true;
		   	  	  end;
                j := next[j];
		   	  end;
		   end;
	until stop;
	for i := 1 to n do
	 if select[i] then inc(res,a[i]);
	build;
    for i := 1 to n do cha[i] := -1;
	loang(0);
	writeln(sl,' ',res,' ',f[0]);
end;

procedure init;
	var i,j : longint;
begin
	for i := 0 to 500 do c[0,i] := 1;
	for i := 1 to 500 do
	 for j := 1 to i do c[j,i] := (c[j-1,i-1]+c[j,i-1]) mod oo;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	init;
	for nn := 1 to ntest do
	  begin
	  	write('Case #',nn,': ');
	  	readln(n,m);
        sum := 0;
	  	for i := 1 to n do
          begin
             read(a[i]);
             sum+=a[i];
          end;
	  	fillchar(deg,sizeof(deg),0);
	  	fillchar(head,sizeof(head),0);
	  	for i := 1 to m do
	  	  begin
	  	  	readln(u,v);
	  	  	ke[i] := v; next[i] := head[u]; head[u] := i;
	  	  	ke[-i] := u; next[-i] := head[v]; head[v] := -i;
	  	  	inc(deg[u]); inc(deg[v]);
	  	  end;
	  	if n=2 then 
	  	 begin
	  	 	write(1,' ',min(a[1],a[2]),' ');
	  	 	if a[1]=a[2] then writeln(2)
	  	 	 else writeln(1);
	  	 end
	  	else if n=1 then writeln(1,' ',0,' ',1)
	  	else
	  	if m=n-1 then sub1
         else sub2;
	  end;
end.
