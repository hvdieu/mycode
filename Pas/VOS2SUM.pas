Uses math;
Const
	inp = '';
	out = '';
	maxn = 10001;
	p1 = 10027;
	p2 = 9929;

Var
	a : array [0..maxn] of longint;
	q,n,i,last,now,top : longint;
	b,vt,k1,k2,r1,r2 : array [0..maxn*100] of longint;
	dd : array [0..p1,0..p2] of boolean;

procedure Find(x: longint);
	var i,j: longint;
begin
	i := 1; j := n;
	while i < j do
	  begin
	  	if a[i]+a[j]=x then
	  	  begin
	  	  	writeln(i,' ',j);
	  	  	exit;
	  	  end;
	  	if a[i]+a[j]>x then dec(j)
	  	 else inc(i);
	  end;
	writeln(-1,' ',-1);
end;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint);
	var i,j,k : longint;
begin
	if l >= h then exit;
	i := l; j := h; k := b[l+random(h-l+1)];
	repeat
		while b[i] < k do inc(i);
		while b[j] > k do dec(j);
		if i <= j then
		  begin
		  	swap(b[i],b[j]);
		  	swap(vt[i],vt[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure sub1;
	var i,j : longint;
begin
	for i := 1 to q do find(b[i]);
end;

function search(key : longint) : longint;
	var d,c,mid,ans : longint;
begin
	d := 1; c := q; ans := 0;
	while d <= c do
	  begin
	  	mid := (d+c) shr 1;
	  	if b[mid]=key then
	  	  begin
	  	  	ans := mid; c := mid-1
	  	  end
	  	else if b[mid] > key then c := mid-1
	  	 else d := mid+1;
	  end;
	exit(ans);
end;

procedure sub2;
	var i,j,x,y,u : longint;
begin
	sort(1,q);
	for i := 1 to q do dd[b[i] mod p1,b[i] mod p2] := true;
	for i := 1 to n do
	 if a[i]<>a[i-1] then
	 for j := n downto i+1 do
	  if (a[j]<>a[j+1])  then
	  begin
	  	 x := (a[i]+a[j]) mod p1;
	  	 y := (a[i]+a[j]) mod p2;
         if dd[x,y] then
           begin
           	  u := search(a[i]+a[j]);
           	  if (u<>0) and (k1[u]=0) then
           	    begin
           	    	k1[u] := i; k2[u] := j;
           	    end;
           end;
	  end;
	r1[vt[1]] := k1[1]; r2[vt[1]] := k2[1];
	for i := 2 to q do
	  begin
	  	if b[i]=b[i-1] then
	  	  begin
	  	  	r1[vt[i]] := r1[vt[i-1]]; r2[vt[i]] := r2[vt[i-1]];
	  	  end
	  	else begin
	  		r1[vt[i]] := k1[i]; r2[vt[i]] := k2[i];
	  	end;
	  end;
	for i := 1 to q do
	 if r1[i]=0 then writeln(-1,' ',-1)
	  else writeln(r1[i],' ',r2[i]);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do read(a[i]);
	a[0] := -1;
	a[n+1] := maxlongint;
	readln(q);
	for i := 1 to q do
	  begin
	    read(b[i]);
	    vt[i] := i;
	  end;
   if n <= 1000 then sub1
   else sub2;
end.

