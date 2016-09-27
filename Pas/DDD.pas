Uses math;
Const
	inp = 'DDD.INP';
	out = 'DDD.OUT';
	maxn = 51;

Type  arr = array [1..maxn] of longint;

Var
	m,n,i,j,k,top,ma,mb : longint;
	a,b,c,d,id : array [1..maxn] of longint;
	x : array [1..maxn,1..maxn] of longint;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint);
	var i,j,k : longint;
begin
	if l >= h then exit;
	i := l; j := h; k := c[l+random(h-l+1)];
	repeat
		while (c[i]>k) do inc(i);
		while (c[j]<k) do dec(j);
		if i <= j then
		  begin
		  	swap(c[i],c[j]);
		  	swap(id[i],id[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

function check(i,j : longint; a,b : arr) : boolean;
	var u,v,k,top : longint;
begin
	top := 0;
	for k := j+1 to n do
	  begin
	  	inc(top); c[top] := b[k]; id[top] := k;
	  end;
	sort(1,top);
	for k := 1 to a[i] do
	  if c[k]=0 then exit(false);
	for k := 1 to a[i] do dec(b[id[k]]);
	for u := i+1 to m do
	  begin
	  	top := 0;
	  	for k := 1 to n do
	  	  begin
	  	  	c[k] := b[k]; id[k] := k;
	  	  end;
	  	sort(1,n);
	  	for k := 1 to a[u] do
	  	 if c[k]=0 then exit(false);
	  	for k := 1 to a[u] do dec(b[id[k]]);
	  end;
    for k := 1 to n do if b[k]<>0 then exit(false);
	exit(true);
end;

procedure main;
	var i,j : longint;
	    ok : boolean;
begin
	for i := 1 to m do
	  for j := 1 to n do
	    begin
	        if a[i]=n-j+1 then
	          begin
	          	if (b[j]=0) then
	          	  begin
	          	  	writeln(-1);
	          	  	exit;
	          	  end;
	          	x[i,j] := 1; dec(a[i]); dec(b[j]);
	          end
	        else begin
	    	if check(i,j,a,b) = false then
	    	  begin
	    	  	if (a[i]=0) or (b[j]=0) then
	    	  	  begin
	    	  	  	writeln(-1);
	    	  	  	exit;
	    	  	  end;
	    	  	x[i,j] := 1; dec(a[i]); dec(b[j]);
	    	  end;
	    	end;
	    end;
	for i := 1 to m do begin
      for j := 1 to n do write(x[i,j]);
    end;
	writeln;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	repeat
		readln(m,n);
		if m=0 then break;
        ma := 0; mb := 0;
		for i := 1 to m do
         begin
           read(a[i]);
           ma := max(ma,a[i]);
         end;
		for i := 1 to n do
         begin
           read(b[i]);
           mb := max(mb,b[i]);
         end;
         if (ma>n) or (mb>m) then writeln(-1) else
		main;
	until false;
end.
