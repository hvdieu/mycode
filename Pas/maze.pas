Uses math;
Const
	inp = 'maze.inp';
	out = 'maze.out';
	maxn = 101;
	oo = 99999999;
	h : array [1..4] of integer = (1,0,-1,0);
	c : array [1..4] of integer = (0,-1,0,1);
	g : array [1..4] of integer = (8,4,2,1);
Var
	m,n,k,u1,v1,u2,v2,i,j,nheap : longint;
	a : array [1..maxn,1..maxn] of integer;
	hi,hj,hk : array [1..maxn*maxn*4] of longint;
	d : array [1..maxn,1..maxn,0..3] of longint;
    pos : array [1..maxn,1..maxn,0..3] of longint;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure update(cha,con : longint);
begin
	swap(hi[cha],hi[con]); swap(hj[cha],hj[con]); swap(hk[cha],hk[con]);
	pos[hi[cha],hj[cha],hk[cha]] := cha;
	pos[hi[con],hj[con],hk[con]] := con;
end;

procedure upheap(i,j,k : longint);
	var cha,con : longint;
begin
	con := pos[i,j,k];
	if con=0 then
	  begin
	  	inc(nheap); hi[nheap] := i; hj[nheap] := j; hk[nheap] := k;
	  	pos[i,j,k] := nheap; con := nheap;
	  end;
	repeat
		cha := con div 2;
		if (cha=0) or (d[hi[cha],hj[cha],hk[cha]]<=d[hi[con],hj[con],hk[con]]) then break;
		update(cha,con);
		con := cha;
	until false;
end;

procedure pop(var u,v,t : longint);
	var cha,con : longint;
begin
	u := hi[1]; v := hj[1]; t := hk[1];
	hi[1] := hi[nheap]; hj[1] := hj[nheap]; hk[1] := hk[nheap];
	pos[hi[1],hj[1],hk[1]] := 1; dec(nheap); cha := 1;
	repeat
		con := cha*2;
		if (con<nheap) and (d[hi[con],hj[con],hk[con]]>d[hi[con+1],hj[con+1],hk[con+1]]) then inc(con);
		if (con>nheap) or (d[hi[cha],hj[cha],hk[cha]]<=d[hi[con],hj[con],hk[con]]) then break;
		update(cha,con);
		cha := con;
	until false;
end;

procedure main;
	var i,j,kk,x,u,v,t,tt : longint;
begin
	for i := 1 to m do
	 for j := 1 to n do
	   for kk := 0 to k do d[i,j,kk] := oo;
	d[u1,v1,k] := 0; upheap(u1,v1,k);
	repeat
		if nheap=0 then break;
		pop(u,v,t);
		if (u=u2) and (v=v2) then
		  begin
		  	writeln(d[u,v,t]);
		  	exit;
		  end;
        x := a[u,v];
        for kk := 1 to 4 do
            begin
            	i := u+h[kk]; j := v+c[kk];
                if (x>=g[kk]) then
                  begin
                      dec(x,g[kk]);
                      tt := 1;
                  end
                else tt := 0;
            	if (i<=m) and (i>0) and (j<=n) and (j>0) then
            	  begin
            	  	if (tt=1) and (t>0) then
            	  	  begin
            	  	  	 if d[i,j,t-1] > d[u,v,t]+1 then
            	  	  	   begin
            	  	  	   	  d[i,j,t-1] := d[u,v,t]+1;
            	  	  	   	  upheap(i,j,t-1);
            	  	  	   end;
            	  	  end
            	  	else if (tt=0) then
            	  	  begin
            	  	       if d[i,j,t] > d[u,v,t]+1 then
            	  	         begin
            	  	         	d[i,j,t] := d[u,v,t]+1;
            	  	         	upheap(i,j,t);
            	  	         end;
            	  	  end;
            	  end;
            end;
	until false;
	writeln(-1);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(m,n,k);
	readln(u1,v1,u2,v2);
	for i := 1 to m do
	  for j := 1 to n do read(a[i,j]);
	main;
end.
