Uses math;
Const
	inp = 'QCHESS.INP';
	out = 'QCHESS.OUT';
	maxn = 11;
	h : array [1..4] of integer = (-1,-1,1,1);
	c : array [1..4] of integer = (-1,1,1,-1);

Var
	ntest,i,j,n,res : Longint;
	a,b : array [0..maxn,0..maxn] of char;

function check(i,j : longint) : boolean;
begin
	if i mod 2 <> j mod 2 then exit(true)
	 else exit(false);
end;

procedure dfs(i,j,dem : longint);
	var u,v,uu,vv,K : longint;
begin
	if dem > res then res := dem;
	for k := 1 to 4 do
	   begin
	   	 u := i+h[k]; v := j+c[k];
	   	 if b[u,v]='B' then
	   	   begin
	   	   	  uu := u+h[k]; vv := v+c[k];
	   	   	  if (b[uu,vv]='#') then
	   	   	    begin
	   	   	    	if check(u,v) then b[u,v] := '#'
                     else b[u,v] := '.';
	   	   	    	dfs(uu,vv,dem+1);
                    b[u,v] := 'B';
	   	   	    end;
	   	   end;
	   end;
end;

procedure main;
	var i,j,ii,jj : longint;
begin
	res := 0;
	for i := 1 to n do
      for j := 1 to n do
       if (a[i,j]='W') and (check(i,j)) then
        begin
            b := a;
            b[i,j] := '#';
        	dfs(i,j,0);
        end;
    writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest); n := 10;
	for i := 0 to n+1 do
	 for j := 0 to n+1 do a[i,j] := '\';
	while ntest > 0 do
	   begin
	   	  dec(ntest); readln;
	   	  for i := 1 to n do
	   	    begin
	   	    	for j := 1 to n do read(a[i,j]);
	   	    	readln;
	   	    end;
	   	  main;
	   end;
end.
