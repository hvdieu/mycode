{$MODE OBJFPC}
{$INLINE ON}
uses math;
Const
	inp = 'c11yard.inp';
	out = 'C11YARD.OUT';
	maxn = 2010;
	h : array [1..4] of integer = (-1,0,1,0);
	c : array [1..4] of integer = (0,1,0,-1);

Type
	edge = record
		y1,y2,tt : longint;
	end;

Var
	m,n,k,i,j,x,left,right,top,res,sl,mm,xmin,xmax : longint;
	ch : char;
	s,a : array [0..maxn,0..maxn] of longint;
	free : array [0..maxn,0..maxn] of boolean;
	qx,qy : array [1..maxn*maxn] of longint;
	t,f : array [1..8*maxn] of longint;
	head : array [1..maxn] of longint;
    ke : array [1..maxn*maxn*2] of edge;
    next : array [1..maxn*maxn*2] of longint;

procedure push(a,b,c,d : longint); inline;
begin
	inc(mm);
	next[mm] := head[a]; head[a] := mm;
	with ke[mm] do
	  begin
	  	y1 := b; y2 := c; tt := d;
	  end;
end;

procedure update(i,lo,hi,u,v,x : longint);
	var mid : longint;
begin
	if (lo=u) and (hi=v) then
	  begin
	  	f[i] := f[i] + x;
	  	if f[i]<>0 then t[i] := hi-lo+1
	  	 else if (lo=hi) then t[i] := 0
	  	  else t[i] := t[i*2] + t[i*2+1];
	  	exit;
	  end;
	mid := (lo+hi) shr 1;
	if u <= mid then update(i*2,lo,mid,u,min(mid,v),x);
	if v > mid then update(i*2+1,mid+1,hi,max(u,mid+1),v,x);
	if f[i] <> 0 then t[i] := hi-lo+1
	 else t[i] := t[i*2] + t[i*2+1];
end;

procedure Area; inline;
	var i,j,x : longint;
		Q : edge;
begin
	j := head[xmin];
	sl := 0;
    if k<>1 then
    begin
	while j <> 0 do
	  begin
	  	Q := ke[j];
	  	if Q.tt = 0 then update(1,1,m,Q.y1,Q.y2,1)
	  	 else update(1,1,m,Q.y1,Q.y2,-1);
	  	j := next[j];
	  end;
	head[xmin] := 0;
	for i := xmin+1 to xmax+k do
	  begin
	  	 sl := sl + t[1];
	  	 j := head[i];
	  	 while j <> 0 do
	  	   begin
	  	   	  Q := ke[j];
	  		  if Q.tt = 0 then update(1,1,m,Q.y1,Q.y2,1)
	  			 else update(1,1,m,Q.y1,Q.y2,-1);
	  		  j := next[j];
	  	   end;
	  	 head[i] := 0;
	  end;
    end else sl := right;
	res := max(res,sl);
end;

procedure bfs; inline;
	var i,j,u,v,t : longint;
begin
	while left < right do
	  begin
	  	inc(left); i := qx[left]; j := qy[left];
	  	xmin := min(xmin,j);
	  	xmax := max(xmax,j);
	  	for t := 1 to 4 do
	  	  begin
	  	  	u := i+h[t]; v := j+c[t];
	  	  	if (u>0) and (v>0) and (u<=m-k+1) and (v<=n-k+1)
	  	  	  and (a[u][v]=1) and (free[u][v]) then
	  	  	    begin
	  	  	    	inc(right);
	  	  	    	qx[right] := u; qy[right] := v;
	  	  	    	push(v,u,u+k-1,0);
	  	  	    	push(v+k,u,u+k-1,1);
	  	  	    	free[u][v] := false;
	  	  	    end;
	  	  end;
	  end;
	area;
end;

procedure main; inline;
	var i,j,u,v,x : longint;
begin
	res := -1;
    if s[m][n]=0 then
      begin
          writeln(m*n);
          exit;
      end;
	for i := 1 to m-k+1 do
	  for j := 1 to n-k+1 do
	    begin
	    	u := i+k-1; v := j+k-1;
	    	x := s[u][v] - s[u][j-1] - s[i-1][v] + s[i-1][j-1];
	    	if (x=0) then a[i][j] := 1
	    	 else a[i][j] := 0;
	    end;
	fillchar(free,sizeof(free),true);
	for i := 1 to m-k+1 do
	  for j := 1 to n-k+1 do
	   if free[i][j] and (a[i][j]=1) then
	    begin
	    	xmin := j; xmax := j;
	    	mm := 0;
	    	qx[1] := i; qy[1] := j;
	    	left := 0; right := 1;
	    	free[i][j] := false;
	    	push(j,i,i+k-1,0);
	    	push(j+k,i,i+k-1,1);
	    	bfs;
	    end;
	writeln(res);
end;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
	readln(m,n,k);
	for i := 1 to m do
	  begin
	  	for j := 1 to n do
	  	  begin
	  	  	read(ch);
	  	  	if ch='.' then x := 0 else x := 1;
	  	  	s[i][j] := s[i-1][j] + s[i][j-1] - s[i-1][j-1] + x;
	  	  end;
	  	readln;
	  end;
	main;
end.
