
uses math;
Const
	inp = '';
	out = '';
	oo = 1234567891;
	maxn = 21;

Var
	n,i,j : longint;
	a : array [1..maxn,1..maxn] of longint;
	f : array [0..maxn,0..1048576] of longint;
	t : array [1..maxn,1..184756] of longint;
	sl : array [1..maxn] of longint;

procedure main;
	var i,j,tt,x,dem,k : longint;
begin
	for tt := 1 to 1 shl n-1 do
	 begin
	 	dem := 0;
	 	for i := 1 to n do
	 	 if (tt shr (i-1)) and 1=1 then inc(dem);
	 	inc(sl[dem]); t[dem,sl[dem]] := tt;
	 end;
	for i := 1 to n do
	 if a[1,i]=1 then f[1,1 shl (i-1)] := 1;
	for i := 1 to n-1 do
	  for k := 1 to sl[i] do
	   begin
	    tt := t[i,k];
	   	for j := 1 to n do
	   	 if ((tt shr (j-1)) and 1=0) and (a[i+1,j]=1) then
          begin
           x := tt or (1 shl (j-1));
	   	   f[i+1,x] := (int64(f[i+1,x])+f[i,tt]) mod oo;
          end;
	   end;
	write(f[n,1 shl n-1]);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do
	  for j := 1 to n do read(a[i,j]);
	main;
end.
