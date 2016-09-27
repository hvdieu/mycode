{$H+}
Uses math;
Const
	inp = 'ACStr.inp';
	out = 'ACStr.out';
	maxn = 1001;
	maxk = 101;
	oo = 999999999;

Var
	ntest,k,m,n : longint;
	s,a : string;
	d : array [0..maxn,0..27] of longint;
    s1 : array [1..maxn] of longint;
	vt,gt,ts : array [0..maxn] of longint;
	f : array [0..maxn,0..100] of longint;

procedure main;
	var i,j,res,sum : longint;
		ch : char;
begin
	n := length(s); m := length(a);
	for i := 1 to n do
     begin
      if i mod m=0 then inc(d[m,ord(s[i])-96])
        else inc(d[i mod m,ord(s[i])-96]);
     end;
	for i := 1 to min(m,n) do
	  begin
	  	sum := 0;
        for j := 1 to 26 do sum := sum + d[i,j];
        s1[i] := sum;
        res := 0;
        for j := 1 to 26 do
         if d[i,j] > res then res := d[i,j];
        gt[i] := res;
	  end;
	for i := 0 to min(m,n) do
	  for j := 0 to k do f[i,j] := oo;
	f[0,0] := 0;
	for i := 1 to min(m,n) do
	  for j := 0 to k do
	     begin
	     	f[i,j] := f[i-1,j]+s1[i]-d[i,ord(a[i])-96];
	     	if j > 0 then f[i,j] := min(f[i,j],f[i-1,j-1]+s1[i]-gt[i]);
	     end;
	res := oo;
	for j := 0 to k do res := min(res,f[min(m,n),j]);
	writeln(res);
    for i := 1 to n do
     begin
      if i mod m=0 then dec(d[m,ord(s[i])-96])
        else dec(d[i mod m,ord(s[i])-96]);
     end;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest,k);
	readln(s);
	while ntest > 0 do
	  begin
	  	dec(ntest);
	  	readln(a);
	  	main;
	  end;
end.
