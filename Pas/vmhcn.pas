Uses math;
Const
	inp = 'vmhcn.inp';
	out = 'vm.out';
	maxn = 2001;
	h : array [1..4] of integer = (-1,0,1,0);
	c : array [1..4] of integer = (0,1,0,-1);

Var
	m,n,ntest,top,uu,vv,res,i,j : longint;
	sti,stj,stu,stv : array [1..maxn*maxn] of longint;
	t : array [1..maxn,1..maxn] of longint;
	a : array [0..maxn,0..maxn] of char;
	free : array [0..maxn,0..maxn] of boolean;

procedure dfs(i,j : longint);
	var k : longint;
begin
	free[i,j] := false;
	uu := max(uu,i); vv := max(vv,j);
	for k := 1 to 4 do
	  if (a[i+h[k],j+c[k]]='o') and free[i+h[k],j+c[k]] then
	    dfs(i+h[k],j+c[k]);
end;

procedure update(i,j,val : longint);
	var jj : longint;
begin
	while i <= m do
	  begin
	  	jj := j;
	  	while jj <= n do
	  	  begin
	  	     inc(t[i,jj],val);
	  	     inc(jj,jj and (-jj));
	  	  end;
	  	inc(i,i and (-i));
	  end;
end;

function get(i,j : longint) : longint;
	var s,jj : longint;
begin
	s := 0;
	while i > 0 do
	  begin
	  	jj := j;
	  	while jj > 0 do
	  	  begin
	  	  	s := max(s,t[i,jj]);
	  	  	dec(jj,jj and (-jj));
	  	  end;
	  	dec(i,i and (-i));
	  end;
	exit(s);
end;

function sum(i,j,u,v : longint) : longint;
begin
	sum := get(u,v)-get(u,j-1)-get(i-1,v)+get(i-1,j-1);
end;

procedure main;
	var i,j : longint;
begin
	fillchar(t,sizeof(t),0);
	fillchar(free,sizeof(free),true);
	res := 0; top := 0;
	for i := 1 to m do
	  for j := 1 to n do
	   if free[i,j] and (a[i,j]='o') then
	     begin
	     	update(i,j,1);
	     	uu := 0; vv := 0;
	     	dfs(i,j);
	     	inc(top); sti[top] := i; stj[top] := j; stu[top] := uu;
	     	stv[top] := vv;
	     end;
	for i := 1 to top do res := max(res,sum(sti[i],stj[i],stu[i],stv[i]));
	writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	while ntest > 0 do
	  begin
	  	dec(ntest);
	  	readln(m,n);
	  	for i := 0 to m+1 do
	  	  for j := 0 to n+1 do a[i,j] := '.';
	  	for i := 1 to m do
	  	   begin
	  	   	 for j := 1 to n do read(a[i,j]);
	  	   	 readln;
	  	   end;
	  	main;
	  end;
end.
