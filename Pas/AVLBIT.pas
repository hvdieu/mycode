Uses math;
Const
	inp = '';
	out = '';
	maxn = 100001;

Var
	n,vmax,m,q : longint;
	a,b,id,pos : array [1..maxn] of longint;
	f : array [1..4,1..maxn,0..19] of longint;

procedure nhap();
	var i,j : longint;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,q);
	for i := 1 to n do
	  begin
	     read(a[i]); f[1,i,0] := a[i]; f[2,i,0] := a[i];
	     b[i] := a[i];
	     id[i] := i;
	  end;
end;

function gcd(a,b : longint) : longint;
begin
	if b=0 then exit(a) else exit(gcd(b,a mod b));
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
		while b[i]<k do inc(i);
		while b[j]>k do dec(j);
		if i <= j then
			begin
				swap(b[i],b[j]); swap(id[i],id[j]);
				inc(i); dec(j);
			end;
	until i > j;
	sort(l,j); sort(i,h);
end;

procedure roirac();
	var i,j : longint;
begin
	sort(1,n);
	m := 1; a[id[1]] := 1;
	for i := 2 to n do
		begin
			if b[i]<>b[i-1] then inc(m);
			a[id[i]] := m;
		end;
	for i := 1 to m do id[i] := -maxlongint;
	for i := 1 to n do
		begin
			f[4,i,0] := id[a[i]];
			id[a[i]] := i;
		end;
end;

procedure init();
	var i,j,u,v : longint;
begin
	vmax := round(ln(n)/ln(2));
    for i := 1 to n-1 do f[3,i,0] := abs(a[i]-a[i+1]);
	roirac;
	for j := 1 to vmax do
	 for u := 1 to n-1 shl j+1 do
	  begin
	  	v := u+1 shl (j-1);
	  	f[1,u,j] := min(f[1,u,j-1],f[1,v,j-1]);
	  	f[2,u,j] := max(f[2,u,j-1],f[2,v,j-1]);
	  	f[4,u,j] := max(f[4,u,j-1],f[4,v,j-1]);
	  	if v+1 shl (j-1)-1 <= n-1 then f[3,u,j] := gcd(f[3,u,j-1],f[3,v,j-1]);
	  end;
end;

function cmp(t,a,b : longint) : longint;
	begin
		if (t=2) or (t=4) then exit(max(a,b));
		if t=1 then exit(min(a,b));
		if t=3 then exit(gcd(a,b));
	end;

function get(t,u,v : longint) : longint;
	var res,j : longint;
begin
	res := f[t,u,0];
	for j := vmax downto 0 do
		if u>v then break else
		  begin
			if v-u+1>=1 shl j then
			  begin
				res := cmp(t,res,f[t,u,j]);
				u := u+1 shl j;
			  end;
		   end;
	exit(Res);
end;

function Qr(u,v : longint) : boolean;
	var i,j,l,m1,m2,m3,d,m4 : longint;
begin
	if u=v then exit(true);
	l := v-u+1;
	if (l=2) then if a[u]<>a[v] then exit(true) else exit(false);
	m1 := get(1,u,v);
	m2 := get(2,u,v);
	if (m2-m1) mod (l-1)<>0 then exit(false);
	d := (m2-m1) div (l-1);
	m3 := get(4,u,v);
	if m3 >= u then exit(false);
	m4 := get(3,u,v-1);
	if m4 mod d <> 0 then exit(false);
	exit(True);
end;

procedure main;
	var i,j,u,v : longint;
begin
	while q > 0 do
		begin
			dec(q);
			readln(u,v);
			if qr(u,v)=true then writeln('YES')
			 else writeln('NO');
		end;
end;

begin
	nhap;
	init;
	main;
end.


