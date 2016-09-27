Uses math;
Const
	inp = 'swapb.inp';
	out = 'swapb.out';
	maxn = 500010;

Var
	m,n,k,i,j,kind,dem : longint;
	a,t,pos : array [1..maxn] of longint;
	free : array [1..maxn] of boolean;
	res : int64;

procedure sub1;
    var i,j,u : longint;
begin
	fillchar(free,sizeof(free),true);
	for i := 1 to k do
	  if (a[i]<>i) and free[i] then
	   begin
	   	  dem := 1; free[i] := false; u := i;
	   	  repeat
	   	  	 u := a[u]; free[u] := false;
	   	  	 inc(dem);
	   	  until a[u]=i;
	   	  res := res + dem-1;
	   end;
	writeln(res);
end;

procedure update(i,val : longint);
begin
	while i <= k do
	  begin
	  	inc(t[i],val);
	  	inc(i,i and (-i));
	  end;
end;

function get(i : longint) : longint;
	var s : longint;
begin
	s := 0;
	while i > 0 do
	  begin
	  	inc(s,t[i]);
	  	dec(i,i and (-i));
	  end;
	get := s;
end;

procedure swap(var xx,yy : longint);
    var temp : longint;
begin
    temp := xx; xx := yy; yy := temp;
end;

procedure trau;
    var i,j,u : longint;
begin
    res := 0;
    for i := 1 to k do
      begin
          for j := 1 to k do
            if a[j]=i then
              begin
                  u := j;
                  break;
              end;
          res := res+u-i;
          for j := u-1 downto i do swap(a[j],a[j+1]);
      end;
    writeln(res);
end;

procedure sub2;
    var i,j,u : longint;
begin
	for i := 1 to k do pos[a[i]] := i;
	for i := 1 to k do
	  begin
	  	u := pos[i]+get(pos[i]);
	  	if u <> i then
	  	  begin
	  	  	res := res + u-i;
	  	  	update(1,1);
	  	  	update(pos[i]+1,-1);
	  	  end;
	  end;
	writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(m,n);
	for j := 1 to n do
	  for i := 1 to m do
	   begin
	   	inc(k); a[k] := j+(i-1)*n;
	   end;
    readln(kind);
    if kind=1 then sub1
     else if k <= 5000 then trau
      else sub2;
end.
