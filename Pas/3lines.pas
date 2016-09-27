Uses math;
const
	inp = '';
	out = '';
	maxn = 50001;

Type
	arr = array [0..maxn] of longint;

Var
	n,i : longint;
	x,y,m1,m2,m3,m4,m5,m6 : array [0..maxn] of longint;
	b : array [1..6] of longint;

procedure swap(var x,y : longint);
	var temp : longint;
begin
	temp := x; x := y; y := temp;
end;

procedure sort(l,h : longint;var x,y : arr);
	var i,j,k : longint;
begin
	if l >= h then exit;
	i := l; j := h; k := x[l+random(h-l+1)];
	repeat
		while x[i] < k do inc(i);
		while x[j] > k do dec(j);
		if i <= j then
		  begin
		  	swap(x[i],x[j]);
		  	swap(y[i],y[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j,x,y); sort(i,h,x,y);
end;

function kt(i,j : longint) : boolean;
	var ii,jj,dem : longint;
begin
	b[1] := m1[i]; b[2] := m2[i]; b[3] := m3[i];
	b[4] := m4[j]; b[5] := m5[j]; b[6] := m6[j];
	for ii := 1 to 6 do
	  for jj := ii+1 to 6 do
	   if b[ii] > b[jj] then swap(b[ii],b[jj]);
	dem := 1;
	for ii := 2 to 6 do if b[ii] <> b[ii-1] then inc(dem);
	if b[1]=-maxlongint then dec(dem);
	if dem <= 2 then exit(true);
    exit(false);
end;

function check(x,y : arr) : boolean;
	var i,j,dem : longint;
		ok : boolean;
begin
	sort(1,n,x,y);
	dem := 1;
	for i := 2 to n do if x[i] <> x[i-1] then inc(dem);
	if dem <= 3 then exit(true);
	for i := 0 to n+1 do
	  begin
	  	m1[i] := -maxlongint; m2[i] := m1[i]; m3[i] := m1[i]; m4[i] := m1[i];
        m5[i] := m1[i]; m6[i] := m1[i];
	  end;
	for i := 1 to n do
	  begin
	  	m1[i] := m1[i-1]; m2[i] := m2[i-1]; m3[i] := m3[i-1];
	  	if y[i] > m1[i] then
	  	  begin
	  	  	m3[i] := m2[i]; m2[i] := m1[i]; m1[i] := y[i];
	  	  end
	  	else if (y[i]<m1[i]) and (y[i]>m2[i]) then
	  	  begin
	  	  	m3[i] := m2[i]; m2[i] := y[i];
	  	  end
	  	else if y[i] < m2[i] then m3[i] := y[i];
	  end;
	for i := n downto 1 do
	  begin
	  	m4[i] := m4[i+1]; m5[i] := m5[i+1]; m6[i] := m6[i+1];
	  	if y[i] > m4[i] then
	  	  begin
	  	  	m6[i] := m5[i]; m5[i] := m4[i]; m4[i] := y[i];
	  	  end
	  	else if (y[i]<m4[i]) and (y[i]>m5[i]) then
	  	  begin
	  	  	m6[i] := m5[i]; m5[i] := y[i];
	  	  end
	  	else if y[i] < m5[i] then m6[i] := y[i];
	  end;
	i := 1; j := 1;
	while i <= n do
	  begin
	  	j := i;
	  	while (j<n) and (x[j+1]=x[i]) do inc(j);
	  	if kt(i-1,j+1) then exit(true);
	  	i := j+1;
	  end;
	exit(false);
end;

procedure main;
	var i,j : longint;
begin
	if check(x,y) then writeln(1)
	 else if check(y,x) then writeln(1)
	  else writeln(0);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do read(x[i],y[i]);
	main;
end.
