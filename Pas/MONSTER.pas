Uses math;
const
	inp = 'MONSTER.INP';
	out = 'MONSTER.OUT';
	maxLH = 251;
	maxLS = 101;
	maxN = 41;
	oo = 1000000000;

var
	LS,LH,N,left,right,i : longint;
	D : array [1..maxLS] of longint;
	f : array [0..maxLH,0..maxLS,0..maxN] of longint;
	free : array [0..maxLH,0..maxLS,0..maxN] of boolean;
	qi,qj,qk : array [1..maxLH*maxLS*maxN] of longint;

procedure push(i,j,k : longint);
begin
	if free[i][j][k] then
	  begin
	  	free[i][j][k] := false;
	  	inc(right);
	  	qi[right] := i; qj[right] := j; qk[right] := k;
	  end;
end;

procedure pop(var i,j,k : longint);
begin
	inc(left);
	i := qi[left]; j := qj[left]; k := qk[left];
end;

procedure cc(u,v,t,x : longint);
begin
	if (u > 0) and (f[u][v][t] > x+1) then
	  begin
	  	f[u][v][t] := x+1;
	  	push(u,v,t);
	  end;
end;

procedure main;
	var i,j,k,u,v,t,u1,v1,t1,x : longint;
begin
	for i := 0 to LH do
	 for j := 0 to LS do
	  for k := 0 to N do
	   begin
	     f[i][j][k] := oo;
	     free[i][j][k] := true;
	   end;
	left := 0; right := 0;
	push(LH,0,N);
	f[LH][0][N] := 0;
	while left < right do
	  begin
	  	pop(u,v,t);
	  	x := f[u][v][t];
	  	if t = 0 then
	  	  begin
	  	  	writeln(f[u][v][t]);
	  	  	exit;
	  	  end;
	  	t1 := t-1; u1 := u-t1; v1 := min(v+1+t1 mod 3,LS);
	  	cc(u1,v1,t1,x);
	  	t1 := t; u1 := min(u + LH div 5 - t1,LH); v1 := min(LS,v+t1 mod 3);
	  	cc(u1,v1,t1,x);
	  	if v > 0 then
	  	  begin
	  	  	t1 := max(0,t1 - D[v]); v1 := t1 mod 3; u1 := u - t1;
	  	  	cc(u1,v1,t1,x);
	  	  end;
	  	t1 := t; u1 := u-t1; v1 := min(v + t1 mod 3,LS);
	  	cc(u1,v1,t1,x);
	  end;
    writeln('HELP!');
end;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
	while not seekeof(input) do
	   begin
	   	 readln(LH,LS,N);
	   	 for i := 1 to LS do read(D[i]);
	   	 main;
	   end;
end.
