Uses math;
Const
	inp = '';
	out = '';
	maxn = 3001;
	oo = 1000000000000000;
Var
	n,i,j : longint;
	a : array [1..maxn,1..maxn] of longint;
	f,g : array [1..maxn,1..maxn] of int64;
	res : int64;

procedure main;
	var i,j : longint;
		s : int64;
begin
	s := 0;
	for i := 1 to n do g[i,n-i+2] := -oo;
	for j := 1 to n do
	  begin
	  	inc(s,a[1,j]);
	  	f[i,j] := s;
	  end;
	for j := n downto 1 do g[1,j] := max(g[1,j+1],f[i,j]);
	for i := 2 to n do
	  begin
	  	s := 0;
	  	for j := 1 to n-i+1 do
         begin
           inc(s,a[i,j]);
           f[i,j] := g[i-1,j]+s;
         end;
	  	for j := n-i+1 downto 1 do g[i,j] := max(g[i,j+1],f[i,j]);
	  end;
	for i := 1 to n do
	  for j := 1 to n-i+1 do res := max(res,f[i,j]);
	writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do
	  for j := 1 to i do read(a[i-j+1,j]);
	main;
end.
