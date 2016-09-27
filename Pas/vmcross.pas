Uses math,sysutils;
Const
	inp = '';
	out = '';
	maxk = 1001;
	maxn = 51;

Var
	m,n,k,i,j,sl,kk : longint;
	time1,time2 : tdatetime;
    time : double;
	s : array [1..maxk] of string;
	a : array [1..maxn,1..maxn] of char;
	d : array [1..maxn,1..maxn] of integer;
	id1,x1,y1,z1,id2,x2,y2,z2 : array [1..maxk] of longint;
	free : array [1..maxk] of boolean;
	res : double;
	ss : string;

procedure ghikq;
	var i : longint;
begin
	writeln(sl);
	for i := 1 to sl do writeln(id2[i],' ',x2[i],' ',y2[i],' ',z2[i]);
	halt;
end;

function place(u,v : longint; s : string; var dd,z,t : longint) : boolean;
	var i,j,l : longint;
begin
	l := length(s);
	if dd=0 then
	  begin
	  	i := u; j := v+l-1;
	  	if (v-1>0) and (d[u,v-1]=dd) then exit(false);
	  	if (i>m) or (j>n) then exit(false);
	  	for j := v to v+l-1 do
	  	 begin
	  	   if (a[u,j]<>'.') and (a[u,j]<>s[j-v+1]) then exit(false);
	  	   if dd=d[u,j] then exit(false);
	  	   if a[u,j]='.' then inc(t)
	  	    else inc(z);
	  	 end;
	  	exit(true);
	  end
	else begin
		i := u+l-1; j := v;
		if (u-1>0) and (d[u-1,v]=dd) then exit(false);
		if (i>m) or (j>n) then exit(false);
		for j := u to u+l-1 do
		 begin
		   	if (a[j,v]<>'.') and (a[j,v]<>s[j-u+1]) then exit(false);
		   	if dd=d[j,v] then exit(false);
		   	if a[j,v]='.' then inc(t)
		   	 else inc(z);
		 end;
		exit(true);
	end;
end;

procedure update(u,v : longint; s : string; dd : longint);
	var i,j,l : longint;
begin
	l := length(s);
	if dd=0 then
	  begin
	  	for j := v to v+l-1 do
	  	  if a[u,j]='.' then
	  	    begin
	  	    	a[u,j] := s[j-v+1];
	  	    	d[u,j] := 0;
	  	    end;
	  end
	else begin
		for i := u to u+l-1 do
		  if a[i,v]='.' then
		    begin
		    	a[i,v] := s[i-u+1];
		    	d[i,v] := 1;
		    end;
	end;
end;

procedure rollback(u,v : longint; s : string; dd : longint);
	var i,j,l : longint;
begin
	l := length(s);
	if dd=0 then
	  begin
	  	for j := v to v+l-1 do
	  	   if d[u,j]=dd then
	  	     begin
	  	     	d[u,j] := -1; a[u,j] := '.';
	  	     end;
	  end
	else begin
		for i := u to u+l-1 do
		   if d[i,v]=dd then
		     begin
		        d[i,v] := -1; a[i,v] := '.';
		     end;
	end;
end;

procedure ql(i,x,y,z,t : longint);
	var j,u,v,solan,dd,z3,t3,h1,d1,d2 : longint;
begin
	time2 := now;
    time := (time2-time1)*24*3600;
    if time > 0.95 then ghikq;
	if x*y+sqrt(z*z*z)+t > res then
	  begin
	  	res := x*y+sqrt(x*x*x)+t;
	  	sl := x+y;
	  	for j := 1 to sl do
	  	  begin
	  	  	id2[j] := id1[j]; x2[j] := x1[j]; y2[j] := y1[j]; z2[j] := z1[j];
	  	  end;
	  	exit;
	  end;
	solan := 0;
	repeat
		j := random(k)+1;
		inc(solan);
		d1 := random(1); d2 := 1-d1;
		if free[j] then
		  begin
		    free[j] := false;
		  	for u := 1 to m do
		  	 for v := 1 to n do
		  	   begin
		  	   		z3 := 0; t3 := 0;
		  	    	if place(u,v,s[j],d1,z3,t3) then
		  	    	  begin
		  	    	  	id1[i] := j; x1[i] := u; y1[i] := v; z1[i] := d1;
		  	    	  	update(u,v,s[j],d1);
		  	    	  	if d1=0 then ql(i+1,x+1,y,z+z3,t+t3)
		  	    	  	 else ql(i+1,x,y+1,z+z3,t+t3);
		  	    	  	rollback(u,v,s[j],d1);
		  	    	  end;
		  	    	z3 := 0; t3 := 0;
		  	    	if place(u,v,s[j],d2,z3,t3) then
		  	    	  begin
		  	    	  	id1[i] := j; x1[i] := u; y1[i] := v; z1[i] := d2;
		  	    	  	update(u,v,s[j],d2);
		  	    	  	if d2=0 then ql(i+1,x+1,y,z+z3,t+t3)
		  	    	  	 else ql(i+1,x,y+1,z+z3,t+t3);
		  	    	  	rollback(u,v,s[j],d2);
		  	    	  end;
		  	   end;
		  	free[j] := true;
		  end;
	until solan = min(20,k);
end;

begin
	time1 := now;
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(m,n,k);
	for i := 1 to k do
	  begin
	  	readln(ss);
	  	if length(ss) <= max(m,n) then
	  	  begin
	  	  	inc(kk); s[kk] := ss;
	  	  end;
	  end;
	k := kk;
	for i := 1 to m do
	 for j := 1 to n do
	  begin
	    a[i,j] := '.';
	    d[i,j] := -1;
	  end;
	fillchar(free,sizeof(free),true);
	ql(1,0,0,0,0);
	ghikq;
end.

