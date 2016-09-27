Uses math;
Const
	inp = 'NKLEAVES.INP';
	out = 'NKLEAVES.OUT';
	maxn = 100001;

Type
	bb = record
		f : array [1..maxn] of int64;
		top : longint;
		da : array [1..maxn] of longint;
		db : array [1..maxn] of int64;
		dx,dy : array [1..maxn] of double;
	end;

Var
	n,k,t : longint;
	a,s : array [1..maxn] of longint;
	dp : array [0..1] of bb;
	all : int64;
    g : array [1..10,1..maxn] of longint;

procedure nhap;
	var i,j : longint;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,k);
	for i := 1 to n do read(a[i]);
	for i := n downto 1 do
	 begin
	   s[i] := s[i+1]+a[i];
	   all := all+s[i];
	 end;
end;

procedure push(t,a1 : longint; b1 : int64);
	var a2 : longint; b2 : int64;
		xx,yy : double;
begin
    with dp[t] do
    begin
    while (top>0) do
	    begin
	   	    if top=1 then
	   	  	  begin
	   	  	    xx := 0; yy := b1;
	   	  	  end
	   	  	else begin
	   	  	  a2 := da[top-1]; b2 := db[top-1];
	   	  	  xx := (b2-b1)/(a1-a2);
	   	  	  yy := a1*xx+b1;
	   	  	end;
            if yy>=dy[top] then dec(top) else break;
	   	end;
    end;
	with dp[t] do
	  begin
	  	inc(top);
	  	da[top] := a1; db[top] := b1;
	  	if top=1 then
	  	  begin
	  	  	dx[top] := 0; dy[top] := b1;
	  	  end
	  	else begin
	  		a2 := da[top-1]; b2 := db[top-1];
	  		xx := (b2-b1)/(a1-a2);
	  		yy := a1*xx+b1;
	  		dx[top] := xx; dy[top] := yy;
	  	end;
	  end;
end;

procedure main;
	var i,j,b,jj,a1,a,a2 : longint;
		b1,b2 : int64;
		xx,yy : double;
begin
	t := 0; dp[0].top := 0;
	for b := 1 to n do
	  begin
	    dp[0].f[b] := 0;
	  	push(0,-s[b],int64(s[b])*b);
	  end;
	for jj := 2 to k do
	  begin
	   	t := 1-t;
	   	dp[t].top := 0;
	   	j := 0;
	   	for a := 1 to n-jj+1 do
	   	  begin
	   	  	while (j<dp[1-t].top) and (a>dp[1-t].dx[j+1]) do inc(j);
	   	  	dp[t].f[a] := int64(dp[1-t].da[j])*a+dp[1-t].db[j];
	   	  	a1 := -s[a]; b1 := int64(s[a])*a+dp[t].f[a];
            push(t,a1,b1);
	   	  end;
	  end;
end;

procedure trau;
    var i,j,a,b : longint;
begin
     for i := 2 to k do
      for a := 1 to n do
        for b := a+1 to n do
         g[i,a] := max(g[i,a],g[i-1,b]+(b-a)*s[b]);

end;

begin
	nhap;
    trau;
	main;
	writeln(all-s[1]-dp[t].f[1]);
end.
