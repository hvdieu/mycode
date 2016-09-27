Uses math;
Const
	inp = 'VMAZE.INP';
	out = 'VMAZE.OUT';
	maxn = 2001;
	h : array [1..4] of integer = (-1,0,1,0);
	c : array [1..4] of integer = (0,1,0,-1);

Var
	m,n,i,j,left,right,l,r : longint;
	a : array [1..maxn,1..maxn] of char;
	d : array [1..maxn,1..maxn,0..1] of longint;
	free : array [1..maxn,1..maxn,0..1] of boolean;
	qx,qy : array [1..maxn*maxn*2] of longint;

function check(c1,c2 : char; tt : longint) : boolean;
begin
	if (c1='.') or (c2='.') then exit(false);
	if (c1='+') and (c2='+') then exit(true);
	if tt=1 then
	  begin
	  	if (c1='+') and (c2='|') then exit(true);
	  	if (c1='|') and (c2='+') then exit(true);
	  	if (c1='|') and (c2='|') then exit(true);
	  	exit(false);
	  end else
	  begin
	  	if (c1='+') and (c2='-') then exit(true);
	  	if (c1='-') and (c2='+') then exit(true);
	  	if (c1='-') and (c2='-') then exit(true);
	  	exit(false);
	  end;
end;

procedure push(i,j,k : longint);
begin
	if free[i,j,k]=false then exit;
	free[i,j,k] := false;
	if k=0 then
	  begin
	  	inc(right); qx[right] := i; qy[right] := j;
	  end
	else begin
		dec(r); qx[r] := i; qy[r] := j;
	end;
end;

procedure main;
	var i,j,k,u,v : longint;
begin
	left := 0; right := 0; l := m*n*2+1; r := l;
    fillchar(free,sizeof(free),true);
    for i := 1 to m do
     for j := 1 to n do
      begin
          d[i,j,0] := m*n;
          d[i,j,1] := m*n;
      end;
    d[m,1,0] := 0;
	push(m,1,0);
	repeat
		if (left=right) and (l=r) then break;
		if left < right then
		  begin
		  	 inc(left); i := qx[left]; j := qy[left];
             if free[i,j,1] then
               begin
                   d[i,j,1] := d[i,j,0]+1;
                   push(i,j,1);
               end;
		  	 for k := 1 to 4 do
		  	   begin
		  	   	 u := i+h[k]; v := j+c[k];
		  	   	 if (u>0) and (v>0) and (u<=m) and (v<=n) then
		  	   	   begin
		  	   	   	  if check(a[i,j],a[u,v],k mod 2) and free[u,v,0] then
		  	   	   	    begin
		  	   	   	    	d[u,v,0] := d[i,j,0];
		  	   	   	    	push(u,v,0);
		  	   	   	    end;
		  	   	   	  if check(a[i,j],'+',k mod 2) and (free[u,v,1]) then
		  	   	   	    begin
		  	   	   	    	d[u,v,1] := d[i,j,0]+1;
		  	   	   	    	push(u,v,1);
		  	   	   	    end;
		  	   	   end;
		  	   end;
		  end
		else begin
			dec(l); i := qx[l]; j := qy[l];
			for k := 1 to 4 do
		  	   begin
		  	   	 u := i+h[k]; v := j+c[k];
		  	   	 if (u>0) and (v>0) and (u<=m) and (v<=n) then
		  	   	   begin
		  	   	   	  if check('+',a[u,v],k mod 2) and free[u,v,0] then
		  	   	   	    begin
		  	   	   	    	d[u,v,0] := d[i,j,1];
		  	   	   	    	push(u,v,0);
		  	   	   	    end;
		  	   	   	  if check('+','+',k mod 2) and (free[u,v,1]) then
		  	   	   	    begin
		  	   	   	    	d[u,v,1] := d[i,j,1]+1;
		  	   	   	    	push(u,v,1);
		  	   	   	    end;
		  	   	   end;
		  	   end;
		end;
	until false;
	writeln(min(d[1,n,0],d[1,n,1]));
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(m,n);
	for i := 1 to m do
	  begin
	  	for j := 1 to n do read(a[i,j]);
	  	readln;
	  end;
	main;
end.
