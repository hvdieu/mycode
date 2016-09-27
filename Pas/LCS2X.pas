Uses math;
Const
	inp = 'LCS2X.IN1';
	out = 'LCS2X.OUT';
	maxn = 1501;

Var
	n,ntest,i,m,dem,res : longint;
	a,b,c,id,d : array [1..maxn] of longint;
	t : array [1..maxn,1..maxn] of longint;
	ok : boolean;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint);
	var i,j,k : longint;
begin
	if l >= h then exit;
	i := l; j := h; k := c[l+random(h-l+1)];
	repeat
		while c[i]<k do inc(i);
		while c[j]>k do dec(j);
		if i <= j then
		  begin
		  	swap(c[i],c[j]);
		  	swap(id[i],id[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure init;
	var i,j : longint;
begin
	dem := 0;
	for i := 1 to m do
	  begin
	  	ok := false;
	  	for j := 1 to n do if a[i]=b[j] then
	  	  begin
	  	    ok := true;
	  	    break;
	  	  end;
	  	if ok then
	  	  begin
	  	  	inc(dem); a[dem] := a[i];
	  	  end;
	  end;
	m := dem; dem := 0;
	for i := 1 to n do
	  begin
	  	ok := false;
	  	for j := 1 to m do if a[j]=b[i] then
	  	  begin
	  	    ok := true; break;
	  	  end;
	  	if ok then
	  	  begin
	  	  	inc(dem); b[dem] := b[i];
	  	  end;
	  end;
	n := dem;
    if m=0 then exit;
	for i := 1 to m do
	  begin
	    c[i] := a[i];
	    id[i] := i;
	  end;
	sort(1,m);
	dem := 1; d[id[1]] := 1;
	for i := 2 to m do
	  begin
	  	if c[i]<>c[i-1] then inc(dem);
	  	d[id[i]] := dem;
	  end;
end;

function find(l,r,key : longint) : longint;
	var mid,ans : longint;
begin
	ans := 0;
	while l <= r do
	  begin
	  	 mid := (l+r) shr 1;
	  	 if c[mid] <= key then
	  	   begin
	  	   	 ans := mid; l := mid+1;
	  	   end
	  	else r := mid-1;
	  end;
	exit(ans);
end;

procedure update(i,j,val : longint);
	var jj : longint;
begin
	while i <= n do
	  begin
	  	jj := j;
	  	while jj <= m do
	  	  begin
	  	  	t[i,jj] := max(t[i,jj],val);
	  	  	inc(jj,jj and (-jj));
	  	  end;
	    inc(i,i and (-i));
	  end;
end;

function get(i,j : longint) : longint;
	var jj,res : longint;
begin
	res := 0;
	while i > 0 do
	  begin
	  	jj := j;
	  	while jj > 0 do
	  	  begin
	  	  	res := max(res,t[i,jj]);
	  	  	dec(jj,jj and (-jj));
	  	  end;
	  	dec(i,i and (-i));
	  end;
	exit(res);
end;

procedure main;
	var i,j,k,kq : longint;
begin
	init;
	if (m=0) or (n=0) then
	  begin
	  	writeln(0);
	  	exit;
	  end;
	res := 0;
	fillchar(t,sizeof(t),0);
	for i := 1 to m do
	  for j := n downto 1 do
	   if a[i]=b[j] then
	     begin
	     	k := find(1,m,a[i] div 2);
	     	if k = 0 then kq := 1
	     	 else begin
	     	 	k := d[id[k]];
	     	 	kq := get(j-1,k)+1;
	     	 end;
	        res := max(res,kq);
            update(j,d[i],kq);
	     end;
    writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	while ntest > 0 do
	  begin
	  	dec(ntest);
	  	readln(m,n);
	  	for i := 1 to m do read(a[i]);
	  	for i := 1 to n do read(b[i]);
	  	main;
	  end;
end.
