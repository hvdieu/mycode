Uses math,windows;
Const
	inp = 'asd.inp';
	out = 'asd.out';
	maxn = 9;
	range : array [1..9] of longint = (1000,1000,6,6,6,6,6,2,0);

Type arr= array [1..9,1..9] of boolean;

Var
	n,i,j,res,r1,u,v : longint;
	a,kq,b,c : array [1..maxn,1..maxn] of longint;
	s1,sum,x1,y1 : array [1..maxn] of longint;
	d1,d2 : array [1..maxn,1..maxn] of boolean;
    x,y : array [1..maxn,1..maxn] of longint;
    now,time : double;

procedure ghikq;
    var i,j : longint;
begin
    writeln(r1);
    for i := 1 to n do
     begin
         for j := 1 to n do write(c[i,j],' ');
         writeln;
     end;
    halt;
end;

procedure ql(k,num : longint);
	var i,j,u,v,res : longint;
begin
    now := gettickcount;
    if now-time > 60000*5 then ghikq;
	if num = 0 then
	  begin
	  	res := 0;
	  	for i := 1 to n do res := res+sum[i]*i;
	  	if res > r1 then
	  	  begin
	  	  	r1 := res;
	  	  	c := a;
	  	  end;
	  	exit;
	  end;
	if k > 9 then
	  begin
	  	res := 0;
		for i := 1 to 9 do
	 	for j := 1 to i-1 do
	  		res := res + abs(x[num,i]-x[num,j])*abs(y[num,i]-y[num,j]);
	 	if abs(res-s1[num]) <= range[num] then
	 	  begin
            sum[num] := res;
	 	  	ql(1,num-1);
            exit;
	 	  end;
	  end;
	for i := 1 to 3 do
	  for j := 1 to 3 do
	    begin
	    	u := i; v := j;
	    	if (k>3) and (k<=6) then inc(u,3)
	 			else if k > 6 then inc(u,6);
			if (k mod 3=2) then inc(v,3)
	 		 	else if k mod 3=0 then inc(v,6);
			if d1[num,u] and d2[num,v] and (a[u,v]=0) then
			  begin
			  	d1[num,u] := false; d2[num,v] := false;
                x[num,k] := u; y[num,k] := v;
                a[u,v] := num;
			  	ql(k+1,num);
                a[u,v] := 0;
			  	d1[num,u] := true; d2[num,v] := true;
			  end;
	    end;
end;

begin
    time := gettickcount;
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(r1);
	n := 9;
	for i := 1 to n do
	 for j := 1 to n do read(c[i,j]);
	for i := 1 to n do
	 for j := 1 to n do
	  for u := 1 to n do
	   for v := 1 to n do
	    if c[i,j]=c[u,v] then inc(s1[c[i,j]],abs(u-i)*abs(v-j));
	for i := 1 to n do s1[i] := s1[i] div 2;
	fillchar(d1,sizeof(d1),true);
	fillchar(d2,sizeof(d2),true);
	ql(1,9);
    ghikq;
end.
