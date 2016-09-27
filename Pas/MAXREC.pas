Uses math;
Const
	inp = 'MAXREC.INP';
	out = 'MAXREC.OUT';
	maxm = 15001;
	maxn = 1501;

Var
	m,n,i,j,u,res : longint;
	a,b : array [0..maxn] of longint;
    ch : char;

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
		  	swap(b[i],b[j]);
		  	inc(i); dec(j);
		  end;
	until i > j;
	sort(l,j); sort(i,h);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(m,n);
	b[0] := -1;
	for i := 1 to m do
	begin
	  for j := 1 to n do
	    begin
	    	read(ch);
	    	if ch='1' then a[j] := a[j]+1
	    	 else a[j] := 0;
            b[j] := a[j];
	    end;
      sort(1,n);
	  for j := 1 to n do
	    begin
	      if b[j]<>b[j-1] then u := j;
	      res := max(res,b[j]*(n-u+1));
	    end;
	  readln;
	end;
	writeln(res);
end.
