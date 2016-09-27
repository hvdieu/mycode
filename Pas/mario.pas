{$INLINE ON}
{$MODE OBJFPC}
Uses math;
Const
	inp = 'mario.inp';
	out = 'mario.out';
	maxn = 5001;
	inf = 1000000000000000;
	h : array [0..3] of integer = (-1,0,1,0);
	c : array [0..3] of integer = (0,1,0,-1);

Var
	m,n,time,x,y,i,j : longint;
	s : array [1..maxn] of longint;
	f : array [1..maxn,0..1] of int64;
	res  : int64;

function id(i,j : longint) : longint; inline;
begin
	id := (i-1)*n+j;
end;

procedure main; inline;
	var i,j,t,k,u,v,tt : longint;
begin
	for i := 1 to m*n do
	 for j := 0 to 0 do
	  f[i][j] := -inf;
	f[id(x,y)][0] := 0;
	res := 0;
    tt := 0;
	for t := 1 to min(time,m+n) do
    begin
     tt := 1-tt;
	 for i := max(x-t,1) to min(x+t,m) do
	  for j := max(y-t,1) to min(y+t,n) do
	  begin
         f[id(i,j)][tt] := -inf;
	  	 for k := 0 to 3 do
	  	   begin
	  	   	  u := i+h[k]; v := j+c[k];
	  	   	  if (u > 0) and (v > 0) and (u <= m) and (v <= n) then
	  	   	    begin
	  	   	    	f[id(i,j)][tt] := max(f[id(i,j)][tt],f[id(u,v)][1-tt] + s[id(i,j)]);
	  	   	  		res := max(res,f[id(i,j)][tt] + ((int64(time)-t) div 2)*(s[id(i,j)]+s[id(u,v)]) + ((time-t) mod 2) * s[id(u,v)]);
	  	   	    end;
	  	   end;
	  end;
    end;
	writeln(res);
end;

procedure sub2;
    var i,j,t,u,v,tt,k : longint;
begin
    for i := 1 to m*n do
	 for j := 0 to 0 do
	  f[i][j] := -inf;
	f[id(x,y)][0] := 0;
	res := 0;
    tt := 0;
	for t := 1 to min(time,m+n) do
    begin
     tt := 1-tt;
	 for i := 1 to 1 do
	  begin
         if (y-t > 0) then
         begin
         j := y-t;
         f[id(i,j)][tt] := -inf;
	  	 for k := 0 to 3 do
	  	   begin
	  	   	  u := i+h[k]; v := j+c[k];
	  	   	  if (u > 0) and (v > 0) and (u <= m) and (v <= n) then
	  	   	    begin
	  	   	    	f[id(i,j)][tt] := max(f[id(i,j)][tt],f[id(u,v)][1-tt] + s[id(i,j)]);
	  	   	  		res := max(res,f[id(i,j)][tt] + ((int64(time)-t) div 2)*(s[id(i,j)]+s[id(u,v)]) + ((time-t) mod 2) * s[id(u,v)]);
	  	   	    end;
	  	   end;
         end;
         if (j+t <= n) then
         begin
           j := y+t;
         f[id(i,j)][tt] := -inf;
	  	 for k := 0 to 3 do
	  	   begin
	  	   	  u := i+h[k]; v := j+c[k];
	  	   	  if (u > 0) and (v > 0) and (u <= m) and (v <= n) then
	  	   	    begin
	  	   	    	f[id(i,j)][tt] := max(f[id(i,j)][tt],f[id(u,v)][1-tt] + s[id(i,j)]);
	  	   	  		res := max(res,f[id(i,j)][tt] + ((int64(time)-t) div 2)*(s[id(i,j)]+s[id(u,v)]) + ((time-t) mod 2) * s[id(u,v)]);
	  	   	    end;
	  	   end;
         end;
	  end;
    end;
	writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(m,n,x,y,time);
	for i := 1 to m do
	 for j := 1 to n do read(s[id(i,j)]);
	if m <> 1 then main
     else sub2;
end.
