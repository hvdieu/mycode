Uses math;
Const
	inp = 'STONE.INP';
	out = 'STONE.OUT';
	maxn = 101;

Var
	m,n,i,j,nn,res : longint;
	a : array [1..5,1..maxn] of char;
	id : array [1..5,1..5] of longint;
	f : array [1..maxn,0..1025] of longint;

function lay(x,i : longint) : longint;
begin
	lay := (x shr (i-1)) and 1;
end;

function bat(var x,i : longint) : longint;
begin
	bat := x or (1 shl (i-1));
end;

function count(x : longint) : longint;
	var dem : longint;
begin
	dem := 0;
	for i := 1 to m do
	 if lay(x,i)=1 then inc(dem);
	 exit(dem);
end;

function check(j,tt : longint) : boolean;
	var i : longint;
begin
	for i := 1 to m do
	 if (lay(tt,i)=1) and (a[i,j]='x') then exit(false);
    exit(true);
end;

function sua(t1,tt : longint) : longint;
	var i,j : longint;
begin
	for i := 1 to m do
	 for j := i+1 to m do
	  if (lay(tt,i)=1) and (lay(tt,j)=1) then
	    begin
	    	if lay(t1,id[i,j])=1 then exit(-1)
	    	 else t1 := bat(t1,id[i,j]);
	    end;
	exit(t1);
end;

procedure main;
	var i,j,dem,tt,t1,k,t2 : longint;
		ok : boolean;
begin
	dem := 0;
	for i := 1 to m do
	  for j := i+1 to m do
	    begin
	    	inc(dem);
	    	id[i,j] := dem;
	    end;
	nn := dem;
	for tt := 1 to 1 shl m-1 do
	 if check(1,tt) then
	  begin
	  	dem := 0; t1 := 0;
	  	for i := 1 to m do if lay(tt,i)=1 then inc(dem);
	  	for i := 1 to m do
	  	 for j := i+1 to m do
	  	  if (lay(tt,i)=1) and (lay(tt,j)=1) then t1 := bat(t1,id[i,j]);
	    f[1,t1] := dem;
	  end;
	for j := 1 to n-1 do
	  begin
	  	for t1 := 0 to 1 shl nn-1 do
	  	 for tt := 0 to 1 shl m-1 do
	  	  if check(j+1,tt) then
	  	    begin
	  	    	t2 := sua(t1,tt);
	  	    	if t2 <> -1 then
	  	    	f[j+1,t2] := max(f[j+1,t2],f[j,t1]+count(tt));
	  	    end;
	  end;
	for t1 := 0 to 1 shl nn-1 do
	 if f[n,t1] > res then res := f[n,t1];
	 writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(m,n);
	for i := 1 to m do
	  begin
	  	for j := 1 to n do read(a[i,j]);
	  	readln;
	  end;
	main;
end.
