Uses math;
Const
	inp = 'HINHTHOI_10.IN';
	out = 'HINHTHOI.OUT';
	maxn = 1501;

Var	
	n,m : longint;
	x,y : array [1..maxn] of integer;
	head,dd : array [-100..100,-100..100] of longint;
	a,b,next : array [1..maxn*maxn] of longint;
	res : int64;

procedure nhap;
	var i,j : longint;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do read(x[i],y[i]);
end;

function gcd(a,b : longint) : longint;
begin
	if b=0 then exit(a) else exit(gcd(b,a mod b));
end;

procedure init();
	var i,j,xx,yy,aa,bb,t : longint;
begin
	for i := 1 to n do
	  for j := i+1 to n do
	    begin
	    	xx := (x[i]+x[j]); yy := (y[i]+y[j]);
	    	aa := (x[j]-x[i]); bb := (y[j]-y[i]);
	    	if (aa<>0) and (bb<>0) then
	    		begin
	    			t := gcd(aa,bb);
	    			aa := aa div t; bb := bb div t;
	    		end;
            if aa < 0 then
	    		begin
	    			aa := -aa; bb := -bb;
	    		end;
	    	inc(m); a[m] := aa; b[m] := bb; next[m] := head[xx,yy]; head[xx,yy] := m;
	    end;
end;

procedure main;
	var i,j,x1,y1,u,v,dx,dy,x2,y2 : longint;
begin
	for u := -100 to 100 do
	  for v := -100 to 100 do
	    begin
	    	j := head[u,v]; dx := 0; dy := 0;
	    	while j <> 0 do
	    		begin
	    			x1 := a[j]; y1 := b[j];
	    			if x1=0 then
	    			  begin
	    			  	 res := res + dy; inc(dx);
	    			  end
	    			else if y1=0 then
	    			  begin
	    			  	 res := res + dx; inc(dy);
	    			  end
	    			else
	    			  begin
	    			  	x2 := -y1; y2 := x1;
	    			  	if x2<0 then begin x2 := -x2; y2 := -y2; end;
	    			  	res := res + dd[x2,y2];
	    			  	inc(dd[x1,y1]);
	    			  end;
	    			j := next[j];
	    		end;
	    	j := head[u,v];
	    	while j<>0 do
	    		begin
	    			x1 := a[j]; y1 := b[j];
	    			if (x1<>0) and (y1<>0) then dec(dd[x1,y1]);
                    j := next[j];
	    		end;
	    end;
	writeln(res);
end;

begin
	nhap;
	init;
	main;
end.
