Uses math;
Const
	inp = 'TBIKE.INP';
	out = 'TBIKE.OUT';
	maxn = 2001;

Var
	n : longint;
	a : array [0..maxn] of longint;
	f : array [0..maxn] of integer;
	next,prev : array [1..maxn,1..maxn] of integer;

procedure nhap;
	var i,j : longint;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do read(a[i]);
end;

procedure init;
	var i,j : longint;
begin
	for i := 1 to n do
		for j := i+1 to n do
		 begin
		 	if ((next[i,j-1]=0) and (a[j]>a[i])) or ((next[i,j-1]<>0) and (a[next[i,j-1]]>a[j]) and (a[j]>a[i])) then next[i,j] := j
		 	  else next[i,j] := next[i,j-1];
		 	if ((prev[i,j-1]=0) and (a[j]<=a[i])) or ((prev[i,j-1]<>0) and (a[prev[i,j-1]]<a[j]) and (a[j]<=a[i])) then prev[i,j] := j
		 	  else prev[i,j] := prev[i,j-1];
		 end;
end;

procedure main();
	var i,j,m1,d1,u,v : longint;
begin
	f[1] := 1;
    if a[i]=a[i-1] then f[2]:=2 else f[2] := 1;
	for i := 3 to n do
		begin
			f[i] := f[i-1]+1;
            if a[i]=a[i-1] then continue;
            f[i] := min(f[i],f[i-2]+1);
			m1 := abs(a[i]-a[i-1]); d1 := 1;
			for j := i-2 downto 1 do
			  begin
			  	 u := next[j,i];
			  	 v := prev[j,i];
			  	 if u<>0 then
			  	   if a[u]-a[j]=m1 then inc(d1) else if a[u]-a[j]<m1 then begin m1 := a[u]-a[j]; d1 := 1; end;
			  	 if v<>0 then
			  	   if a[j]-a[v]=m1 then inc(d1) else if a[j]-a[v]<m1 then begin m1 := a[j]-a[v]; d1 := 1; end;
                if m1=0 then break;
                if d1=i-j then f[i] := min(f[i],f[j-1]+1);
			  end;
		end;
	write(f[n]);
end;

begin
	nhap;
	init;
	main;
end.
