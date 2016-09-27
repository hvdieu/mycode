Uses math;
Const
	inp = 'LSORTVN.INP';
	out = 'LSORTVN.OUT';
	maxn = 1001;
	oo = 999999999;

Var
	n,i: longint;
	a,pos : array [1..maxn] of longint;
	f : array [1..maxn,1..maxn] of longint;
	t : array [1..maxn] of longint;

procedure update(i,val : longint);
begin
	while i <= n do
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
	exit(s);
end;

procedure main;
	var i,j,d,k,u : longint;
begin
	for i := 1 to n do
		for j := 1 to n do
		 if i=j then f[i,j] := pos[i] else f[i,j] := oo;
	for d := 1 to n-1 do
	  begin
	  	fillchar(t,sizeof(t),0);
	  	for i := 1 to d-1 do update(pos[i],1);
	  	for i := 1 to n-d+1 do
	  		begin
	  			j := i+d-1;
	  			update(pos[j],1);
	  			if i > 1 then
	  				begin
	  					k := pos[i-1] - get(pos[i-1]);
	  					f[i-1,j] := min(f[i-1,j],f[i,j]+k*(d+1));
	  				end;
	  			if j < n then
	  				begin
	  					k := pos[j+1] - get(pos[j+1]);
	  					f[i,j+1] := min(f[i,j+1],f[i,j]+k*(d+1));
	  				end;
	  			update(pos[i],-1);
	  		end;
	  end;
	writeln(f[1,n]);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do
		begin
			read(a[i]); pos[a[i]] := i;
		end;
	main;
end.
