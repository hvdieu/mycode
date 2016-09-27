Uses math;
const
	inp = '475C.iNP';
	out = '475C.out';
	maxn = 1001;
	h : array [1..4] of longint = (-1,0,1,0);
	c : array [1..4] of longint = (0,1,0,-1);

Var
	m,n,i,j,cnt,sl,p,q,xmin,ymin,dem,xmax,ymax,res : longint;
	a,s : array [0..maxn,0..maxn] of longint;
	free : array [0..maxn,0..maxn] of boolean;
    fr : array [0..maxn,0..maxn] of longint;
    ch : char;
    sol : boolean;

procedure dfs(i,j : longint);
	var k,u,v : longint;
begin
	free[i][j] := false;
	for k := 1 to 4 do
	 begin
	 	u := i+h[k]; v := j+c[k];
	 	if (u>0) and (v>0) and (u<=m) and (v<=n) and (free[u][v]) then dfs(u,v);
	 end;
end;

function CheckComp : boolean;
	var i,j,tt : longint;
begin
    for i := 1 to m do
     begin
         tt := 0;
         for j := 2 to n do
          if (a[i][j]=1) and (a[i][j-1]=0) then inc(tt);
         if tt > 1 then exit(false);
     end;
    for j := 1 to n do
      begin
          tt := 0;
          for i := 2 to m do
           if (a[i][j]=1) and (a[i-1][j]=0) then inc(tt);
          if tt > 1 then exit(false);
      end;
	fillchar(free,sizeof(free),true);
	for i := 1 to m do
	 for j := 1 to n do
	  if free[i][j] and (a[i][j]=1) then
	    begin
	    	inc(dem);
	    	dfs(i,j);
	    end;
	if dem > 1 then exit(false)
	 else exit(true);
end;

function CheckT : boolean;
	var i,j : longint;
begin
	for i := 1 to m-1 do
	 for j := 2 to n do
	  if (a[i][j] = 1) and (a[i+1][j-1]=1) and (a[i+1][j]=0) then exit(false);
	exit(true);
end;

function get(i,j,u,v : longint) : longint;
begin
	get := s[u][v] - s[u][j-1] - s[i-1][v] + s[i-1][j-1];
end;

procedure loang(i,j,p,q : longint);
	var u,v,k,x,u1,v1,sll : longint;
begin
	fr[i][j] := cnt;
	for k := 2 to 3 do
	  begin
	  	u := i+h[k]; v := j+c[k];
	  	if (u<=m-p+1) and (v<=n-q+1) and (u>0) and (v>0) then
	  	  begin
	  	  	if get(u,v,u+p-1,v+q-1) = p*q then
	  	  	  begin
	  	  	  	loang(u,v,p,q);
	  	  	  	break;
	  	  	  end;
	  	  end;
	  end;
end;

function Check(p,q : longint) : boolean;
	var i,j,x : longint;
begin
	inc(cnt);
	loang(xmin,ymin,p,q);
	if (fr[xmax-p+1][ymax-q+1]<>cnt) then exit(false);
	for i := 1 to m-p+1 do
     for j := 1 to n-q+1 do
      if (fr[i][j]<>cnt) and (get(i,j,i+p-1,j+q-1)=p*q) then exit(false);
    exit(true);
end;

procedure main;
	var i,j,temp,x : longint;
begin
	if sl = 0 then
	  begin
	  	writeln(0);
	  	exit;
	  end;
	if CheckComp = false then
	  begin
	  	writeln(-1);
	  	exit;
	  end;
	if CheckT = false then
	  begin
	  	writeln(-1);
	  	exit;
	  end;
	p := max(m,n); q := p;
	for i := 1 to m do
	  begin
	  	 temp := 0;
	  	 for j := 1 to n do if a[i][j]=1 then inc(temp);
	  	 if temp <> 0 then q := min(q,temp);
	  end;
	for j := 1 to n do
	  begin
	  	temp := 0;
	  	for i := 1 to m do inc(temp,a[i][j]);
	  	if temp <> 0 then p := min(p,temp);
	  end;
    for i := 1 to m do
	 for j := 1 to n do
	  s[i][j] := s[i-1][j] + s[i][j-1] - s[i-1][j-1] + a[i][j];
	x := get(xmin,ymin,xmax,ymax);
	if (x=sl) and (x = (ymax-ymin+1)*(xmax-xmin+1)) then
	  begin
	  	writeln(min(ymax-ymin+1,xmax-xmin+1));
	  	halt;
	  end;
    res := 123456789;
	for i := 1 to p do
     if check(i,q) then
      begin
       res := min(res,i*q);
       break;
      end;
    for j := 1 to q do
     if check(p,j) then
      begin
        res := min(res,p*j);
        break;
      end;
	if res = 123456789 then writeln(-1)
     else writeln(res);
end;

begin
  // assign(input,inp); reset(input);
  // assign(output,out); rewrite(output);
	readln(m,n);
	xmin := m; ymin := n;
	for i := 1 to m do
	  begin
	  	for j := 1 to n do
	  	  begin
	  	  	read(ch);
	  	  	if ch = 'X' then
	  	  	 begin
	  	  	   a[i][j] := 1;
	  	  	   xmin := min(xmin,i);
	  	  	   ymin := min(ymin,j);
	  	  	   xmax := max(xmax,i);
	  	  	   ymax := max(ymax,j);
	  	  	   inc(sl);
	  	  	 end
	  	  	 else a[i][j] := 0;
	  	  end;
	  	readln;
	  end;
	main;
end.
