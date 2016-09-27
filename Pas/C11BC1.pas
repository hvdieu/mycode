Uses math;
Const
	inp = 'C11BC1.INP';
	out = 'C11BC1.OUT';
	maxn = 100010;
	maxk = 52;
	M = 790972;

Var
	n,k,i : longint;
	a,b : array [1..maxn] of longint;
	f,g : array [0..maxn,0..maxk,0..1] of longint;

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
		while b[i] < k do inc(i);
		while b[j] > k do dec(j);
		if i <= j then
		 begin
		 	swap(a[i],a[j]);
		 	swap(b[i],b[j]);
		 	inc(i); dec(j);
		 end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure main;
	var i,j,L,res : longint;
		x,y : int64;
begin
	sort(1,n);
	f[1][1][0] := a[1]; g[1][1][0] := a[1];
	L := 1;
	For i := 2 to n do
	  begin
	     if b[i] <> b[i-1] then L := i;
	  	 f[i][1][0] := a[i];
	  	 g[i][1][0] := (g[i-1][1][0]+f[i][1][0]) mod M;
	  	 x := a[i];
	  	 For j := 2 to k do
	  	   begin
	  	   	  y := g[i-1][j-1][1]+g[L-1][j-1][0];
	  	   	  y := (y*x) mod M;
	  	   	  f[i][j][1] := y;
	  	   	  g[i][j][1] := (g[i-1][j][1]+f[i][j][1]) mod M;
	  	   	  f[i][j][0] := 0;
	  	   	  if L <> i then
	  	   	    begin
	  	   	    	y := g[i-1][j-1][0]-g[L-1][j-1][0];
	  	   	    	if y < 0 then y := y+M;
	  	   	    	y := (y*x) mod M;
	  	   	    	f[i][j][0] := y;
 	  	   	    end;
 	  	   	  g[i][j][0] := (g[i-1][j][0]+f[i][j][0]) mod M;
	  	   end;
	  end;
	res := 0;
	For i := 1 to n do res := (res + f[i][k][1]) mod M;
	writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,k);
	for i := 1 to n do read(a[i],b[i]);
	main;
end.
