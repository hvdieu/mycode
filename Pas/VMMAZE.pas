Uses math;
Const
	inp = 'vmaze.inp';
	out = 'asd.out';
	maxn = 2001;
	nmax = 51;
	h : array [1..4] of integer = (-1,0,1,0);
	c : array [1..4] of integer = (0,1,0,-1);

Var
	m,n,i,j,left,right,res : longint;
	a : array [1..maxn,1..maxn] of char;
	free : array [0..nmax,0..nmax,0..nmax*nmax,0..1] of boolean;
	qi,qj,qk,qt : array [1..nmax*nmax*nmax*nmax*2] of longint;

procedure push(i,j,k,t : longint);
begin
	if free[i,j,k,t] then
	   begin
	   		inc(right);
			qi[right] := i; qj[right] := j; qk[right] := k; qt[right] := t;
	   		free[i,j,k,t] := false;
	   end;
end;

procedure pop(var i,j,k,t : longint);
begin
	inc(left); i := qi[left]; j := qj[left]; k := qk[left];
	t := qt[left];
end;

function check(c1,c2 : char; tt : longint) : boolean;
begin
	if (c1='.') or (c2='.') then exit(false);
	if (c1='+') and (c2='+') then exit(true);
	if tt=1 then
	  begin
	  	if (c1='+') and (c2='|') then exit(true);
	  	if (c1='|') and (c2='+') then exit(true);
	  	if (c1='|') and (c2='|') then exit(true);
	  	exit(false);
	  end else
	  begin
	  	if (c1='+') and (c2='-') then exit(true);
	  	if (c1='-') and (c2='+') then exit(true);
	  	if (c1='-') and (c2='-') then exit(true);
	  	exit(false);
	  end;
end;

procedure sub1;
	var i,j,u,v,k,t,kk : longint;
begin
	for i := 1 to m do
	 for j := 1 to n do
	  for k := 0 to m*n do
	   for t := 0 to 1 do free[i,j,k,t] := true;
	push(m,1,1,1); push(m,1,0,0);
	while left < right do
	  begin
	  	pop(i,j,k,t);
	  	if t=0 then push(i,j,k+1,1);
	  	for kk := 1 to 4 do
	  	  begin
	  	  	u := i+h[kk]; v := j+c[kk];
	  	  	if (u>0) and (v>0) and (u<=m) and (v<=n) then
	  	  	if t=0 then
	  	  	  begin
	  	  	  	if check(a[i,j],a[u,v],kk mod 2) then push(u,v,k,0);
	  	  	  	if check(a[i,j],'+',kk mod 2) then push(u,v,k+1,1);
	  	  	  end
	  	  	else begin
	  	  		if check('+',a[u,v],kk mod 2) then push(u,v,k,0);
	  	  		push(u,v,k+1,1);
	  	  	end;
	  	  end;
	  end;
	res := m*n;
	for k := 0 to m*n do
	 if (free[1,n,k,0]=false) or (free[1,n,k,1]=false) then res := min(res,k);
	writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(m,n);
	for i := 1 to m do
	   begin
	   	 for j := 1 to n do read(a[i,j]);
	   	 readln;
	   end;
	if (m<=50) and (n<=50) then sub1;
end.
