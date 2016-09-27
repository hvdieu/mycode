uses math;
Const
	inp = 'NKFLOW.INP';
	out = 'NKFLOW.OUT';
	maxn = 1001;

Var
	n,m,s,t,i,u,v,l,left,right,res : longint;
	head : array [1..maxn] of longint;
	ke,next,c,f : array [-maxn*maxn..maxn*maxn] of longint;
	q,trace : array [1..maxn] of longint;
	free : array [1..maxn] of boolean;

procedure push(u : longint);
begin
	inc(right); q[right] := u; free[u] := false;
end;

function pop : longint;
begin
	inc(left); pop := q[left];
end;
	
function findpath : boolean;
	var i,j,u,v : longint;
begin
	fillchar(free,sizeof(free),true);
	left := 0; right := 0; push(s);
	while left < right do
	  begin
		 u := pop;
		 j := head[u];
		 while j <> 0 do
		   begin
				v := ke[j];
				if free[v] and (f[j]<c[j]) then
				  begin
				     push(v);
					 trace[v] := j;
				  end;
				j := next[j];
		   end;
	  end;
	if free[t] then exit(false)
	  else exit(true);
end;

procedure truyvet;
	var u,v,j,temp : longint;
begin
	v := t; temp := maxlongint;
	while v <> s do
	   begin
	   		j := trace[v];
	   		temp := min(temp,c[j]-f[j]);
			v := ke[-j];
	   end;
	v := t;
	while v <> s do
	   begin
	   		j := trace[v];
	   		dec(f[-j],temp); inc(f[j],temp);
	   		v := ke[-j];
	   end;
    inc(res,temp);
end;
	
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m,s,t);
	for i := 1 to m do
	  begin
		readln(u,v,l);
		ke[i] := v; next[i] := head[u]; head[u] := i; c[i] := l;
		ke[-i] := u; next[-i] := head[v]; head[v] := -i; c[-i] := 0;
	  end;
	while findpath do truyvet;
	writeln(res);
end.

