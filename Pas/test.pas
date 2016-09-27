Uses math;
Const
	inp = 'test.inp';
	out = 'test.out';
	maxn = 1001;

Var
	n,ntest,i : longint;
	a,id,b,c,d,e : array [1..maxn] of longint;

procedure sort(l,r : longint);
	var i,j,top,dem,dem1 : longint;
		ok : boolean;
begin
	dem := 0; dem1 := 0;
	for i := l to r do
	  if a[i] mod 2 = 1 then
	    begin
	    	inc(dem); b[dem] := a[i]; c[dem] := id[i];
	    end
	  else
        begin
	    	inc(dem1); d[dem1] := a[i]; e[dem1] := id[i];
	    end;
	ok := true;
	for i := l+1 to r do 
	  if a[i]<>a[i-1] then ok := false;
	if ok = true then exit;
	for i := 1 to dem do
	  begin
	  	a[l+i-1] := (b[i]-1) div 2;
	  	id[l+i-1] := c[i];
	  end;
	for i := 1 to dem1 do
	  begin
	  	a[l+dem+i-1] := d[i] div 2;
	  	id[l+dem+i-1] := e[i];
	  end;
	sort(l,l+dem-1); sort(l+dem,r);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest); 
	while ntest > 0 do
	   begin
        dec(ntest);
	   	readln(n);
	   	for i := 1 to n do
	   	  begin
	   	  	read(a[i]);
	   	  	id[i] := i;
	   	  end;
	   	sort(1,n);
        for i := 1 to n do write(id[i],' ');
        writeln;
	   end;
end.
