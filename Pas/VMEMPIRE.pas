Uses math;
Const
	inp = 'VMEMPIRE.INP';
	out = 'VMEMPIRE.OUT';
	maxn = 10001;
	oo = 1000000007;
Var
	n,m,k : longint;
	f,s : array [0..maxn,0..maxn] of longint;
    g : array [0..maxn] of longint;
	res,kq : longint;

procedure main;
	var i,j,x : longint;
begin
    f[0,0] := 1;
    for j := 1 to n do f[0,j] := 1;
	dec(m);
	for j := 1 to n do
	 for i := 1 to j do f[i,j] :=(f[i-1,j-1]+f[i,j-1]) mod oo;
    g[0] := 1;
    for i := 1 to n do
      begin
      	if i <= m then g[i] := (2*g[i-1]) mod oo
      	  else begin
      	  	for j := 0 to m do g[i] := (g[i]+f[j,i]) mod oo;
      	  end;
      end;
	for i := 1 to n do
	  begin
	  	f[i,0] := g[i-1]; s[i,0] := f[i,0];
	  	res := (int64(res)+(int64(f[i,0])*g[n-i]) mod oo) mod oo;
	  end;
	for i := 2 to n do
	  for j := 1 to i-1 do
	    begin
	    	if j > i-k then x := max(i-k,0)
	    	 else x := j-1;
	    	f[i,j] := (f[i,j]+(int64(s[j,x])*g[i-j-1]) mod oo) mod oo;
	    	s[i,j] := (s[i,j-1]+f[i,j]) mod oo;
	    	res := (Res+(int64(f[i,j])*g[n-i]) mod oo) mod oo;
	    end;
    for i := 1 to n do
      begin
          f[i,0] := 1; inc(kq);
      end;
    for i := 2 to n do
     for j := 1 to i-1 do
       begin
           if j > i-k then x := max(i-k,0)
            else x := j-1;
           f[i,j] := (f[i,j-1]+f[j,x]) mod oo;
           kq := (kq+f[j,x]) mod oo;
       end;
    writeln((res-kq+oo) mod oo);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m,k);
	main;
end.
