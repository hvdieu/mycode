{$Coperators ON}
Uses math;
const
	inp = 'kgroup.inp';
	out = 'kgroup.out';
	maxn = 100001;

Var
	n,k,i,m,top,bot : longint;
	s,x : array [0..maxn] of int64;
	res : int64;

procedure swap(var xx,yy : int64);
	var temp : int64;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint);
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
		   	  inc(i); dec(j);
		   end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure main;
	var i,j,u,v : longint;
begin
	for j := 1 to n-k+1 do
	  begin
	  	v := j+k-1; u := j-1;
	  	for i := u+1 to v do
	  	 res := min(res,s[v]-s[i]-x[i]*(v-i)+x[i]*(i-u)-(s[i]-s[u]));
	  end;
	writeln(res);
end;

procedure sub2;
    var i,j,u,v : longint;
begin
    for j := 1 to n-k+1 do
	  begin
	  	v := j+k-1; u := j-1;
        i := (u+1+v) div 2;
	  	 res := min(res,s[v]-s[i]-x[i]*(v-i)+x[i]*(i-u)-(s[i]-s[u]));
	  end;
	writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,k);
	for i := 1 to n do read(x[i]);
    sort(1,n);
	for i := 1 to n do s[i] := s[i-1]+x[i];
    res := s[n];
    if (n<=5000) and (k<=5000) then main
     else sub2;
end.
