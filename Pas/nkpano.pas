Uses math;
Const
	inp = 'NKPANO.INP';
	out = 'NKPANO.OUT';
	maxn = 16001;
	maxk = 101;

Type
	arr1 = array [1..maxk] of longint;
	arr2 = array [0..maxn] of longint;
	arr3 = array [1..maxk,0..maxn] of longint;

Var
	n,k,i : longint;
	l,p,s : arr1;
	f : arr2;
	g : arr3;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(d,c : longint);
	var k,i,j : longint;
begin
	if d >= c then exit;
	i := d; j := c; k := s[d+random(c-d+1)];
	repeat
		while s[i]<k do inc(i);
		while s[j]>k do dec(j);
		if i <= j then
		  begin
		  	swap(s[i],s[j]); swap(p[i],p[j]); swap(l[i],l[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(d,j); sort(i,c);
end;

procedure main();
	var i,j,x : longint;
begin
	sort(1,k);
	for i := 1 to n do
	begin
	 f[i] := f[i-1];
	 for j := 1 to k do
	  if s[j] > i then break else
		begin
			if s[j]=i then
			  begin
			  	 for x := 1 to min(l[j],s[j]) do
			  	   begin
			  	   	 f[i] := max(f[i],f[i-x]+x*p[j]);
			  	   	 g[j,x] := max(g[j,x-1],f[i-x]+x*p[j]);
			  	   end;
			  end
			else if i-s[j]+1<=l[j] then
			  begin
			     x := i-s[j]+1;
				 f[i] := max(f[i],(x-1)*p[j]+g[j,l[j]-x+1]);
			  end;
		end;
	end;
	writeln(f[n]);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,k);
	for i := 1 to k do read(l[i],p[i],s[i]);
	main;
end.
