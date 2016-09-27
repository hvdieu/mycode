Uses math;
Const 
	inp = 'D.inp';
	out = 'D.out';
	maxn = 13;
	inf = 1000000000000000000;

Var
	ntest,n,m,i,j,s1,s2,x,y,work,left,right : longint;
	d : array [0..4097] of int64;
	x,y,c,x1 : array [1..1001] of longint;

procedure push(x : longint);
begin
	inc(right); q[right] := x; free[x] := false;
end;

procedure bfs;
	var i,j,t1 : longint;
begin
	for i := 0 to 1 shl n-1 do d[i] := inf;
	d[s1] := 0;
	fillchar(free,sizeof(free),true);
	push(s1);
	while left < right do 
	  begin
	  	inc(left); tt := q[left];
	  	free[tt] := false;
	  	for i := 1 to m do 
	  	 if (tt or x[i]=tt) then 
	  	   begin
	  	   	 t1 := (tt and x1[i]) or y[i];
	  	   	 if free[t1] and (d[t1]>d[tt]+c[i]) then

	  	   end;
	  end;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	while ntest > 0 do 
	  begin
	  	dec(ntest);
	  	readln(n,m);
	  	s1 := 0; s2 := 0;
	  	read(size);
	  	for i := 1 to size do 
	  	 begin
	  	 	read(j); s1 := s1 or (1 shl j);
	  	 end;
	  	read(size);
	  	for i := 1 to size do 
	  	  begin
	  	  	read(j); s2 := s2 or (1 shl j);
	  	  end;
	  	for i := 1 to m do 
	  	  begin
	  	  	read(work);
	  	  	read(size); x[i] := 0; y[i] := 0; c[i] := work;
	  	  	x1[i] := 1 shl n-1;
	  	  	for i := 1 to size do 
	  	  	  begin
	  	  	  	read(j); x[i] := x[i] or (1 shl j);
	  	  	  	x1[i] := x1[i] and (not (1 shl j));
	  	  	  end;
	  	  	read(size);
	  	  	for i := 1 to size do 
	  	  	  begin
	  	  	  	read(j); y[i] := y[i] or (1 shl j);
	  	  	  end;
	  	  end;
	  	bfs;
	  end;
end.