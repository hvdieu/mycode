{$H+}
Uses math;
Const
	inp = '';
	out = '';
	maxn = 2500001;
	p1 = 1000000007;
	p2 = 1000000000000000007;

Var
	a : array [1..maxn] of longint;
	b : array [1..maxn] of qword;
	ntest,i : longint;
	q1,q2 : qword;
    s : string;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure dc(var xx,yy : qword);
	var temp : qword;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint);
	var i,j,k,k1 : longint;
		k2 : qword;
begin
	if l >= h then exit;
	i := l; j := h; k := l+random(h-l+1);
	k1 := a[k]; k2 := b[k];
	repeat
		while (a[i]<k1) or ((a[i]=k1) and (b[i]<k2)) do inc(i);
		while (a[j]>k1) or ((a[j]=k1) and (b[j]>k2)) do dec(j);
		if i <= j then
		  begin
		  	if i < j then
		  	  begin
		  	  	swap(a[i],a[j]);
		  	  	dc(b[i],b[j]);
		  	  end;
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure init;
	var i : longint;
begin
	a[1] := 1; a[2] := 1;
	b[1] := 1; b[2] := 1;
	for i := 3 to maxn do
	  begin
	  	a[i] := a[i-1]+a[i-2];
	  	b[i] := b[i-1]+b[i-2];
	  	if a[i] >= p1 then a[i] := a[i]-p1;
	  	if b[i] >= p2 then b[i] := b[i]-p2;
	  end;
	sort(1,maxn);
end;

function find(key1,key2 : qword) : boolean;
	var d,c,mid : longint;
begin
	d := 1; c := maxn;
	while d <= c do
	  begin
	  	mid := (d+c) shr 1;
	  	if a[mid]=key1 then
	  	  begin
	  	  	if b[mid]=key2 then exit(true);
	  	  	if b[mid]>key2 then c := mid-1
	  	  	 else d := mid+1;
	  	  end
	  	else if a[mid]>key1 then c := mid-1
	  	 else d := mid+1;
	  end;
	exit(false);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	init;
	readln(ntest);
	while ntest > 0 do
	  begin
	  	dec(ntest);
	  	readln(s);
	  	q1 := 0; q2 := 0;
	  	for i := 1 to length(s) do
	  	  begin
	  	  	q1 := (q1*10+ord(s[i])-ord('0')) mod p1;
	  	  	q2 := (q2*10+ord(s[i])-ord('0')) mod p2;
	  	  end;
	  	if find(q1,q2) then writeln('Yes')
	  	 else writeln('No');
	  end;
 end.
