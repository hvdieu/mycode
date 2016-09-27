Uses math;
Const
	inp = 'QTREEV.INP';
	out = 'QTREEV.OUT';
	maxn = 100001;

Var
	n,i,u,v : longint;
	m : qword;
	a : array [1..maxn] of qword;
	head,dd : array [1..maxn] of longint;
	ke,next : array [-maxn..maxn] of longint;
	p : array [1..maxn] of extended;
	free : array [1..maxn] of boolean;
	res : qword;

procedure dfs(u : longint);
	var j,v,v1 : longint;

begin
	free[u] := false;
	v1 := 0;
	j := head[u];
	while j <> 0 do
	  begin
	  	v := ke[j];
	  	if free[v] then
	  	  begin
	  	  	dfs(v);
	  	  	if (v1=0) or (p[v]>p[v1]) then v1 := v;
	  	  end;
	  	j := next[j];
	  end;
	dd[u] := v1;
	if v1=0 then
     begin
       if a[u]=0 then p[u] := 0
       else p[u] := ln(a[u])/ln(10);
     end
	 else
      begin
      if a[u] <> 0 then p[u] := ln(a[u])/ln(10)+p[v1]
       else p[u] := p[v1];
      end;
end;

function bigmod(a,b : qword) : qword;
	var temp : qword;
begin
	if m <= 1000000000 then exit((a*b) mod m);
	if b=0 then exit(0);
	if b=1 then exit(a mod m);
	temp := bigmod(a,b div 2);
	if b mod 2=0 then exit((temp+temp) mod m)
	 else exit((temp+temp+a) mod m);
end;

begin
   //assign(input,inp) ;reset(input);
   //assign(output,out); rewrite(output);
	readln(n,m);
    for i := 1 to n do read(a[i]);
	for i := 1 to n-1 do
	  begin
	  	readln(u,v);
	  	ke[i] := v; next[i] := head[u]; head[u] := i;
	  	ke[-i] := u; next[-i] := head[v]; head[v] := -i;
	  end;
	fillchar(free,sizeof(free),true);
	dfs(1);
	u := 1;
	res := 1;
	while u <> 0 do
	  begin
	  	res := bigmod(res mod m,a[u] mod m);
	  	u := dd[u];
	  end;
	writeln(res);
end.
