Uses math;
Const
	inp = 'asd.inp';
	out = 'asd.out';
	maxn = 9;
    xx = 9;

Var
	i,j,n,ii,jj,dem,top,r1,u,v : longint;
	a,b,c : array [1..maxn,1..maxn] of longint;
	x,y,sum,x1,y1,s1 : array [1..maxn] of longint;
    x2,y2 : array [1..50,1..maxn] of longint;
	d1,d2 : array [1..maxn] of boolean;
	res : longint;
    ok : boolean;

function check(i,j,k : longint) : boolean;
	var u,v : longint;
begin
	if (k>3) and (k<=6) then inc(i,3)
	 else if k > 6 then inc(i,6);
	if (k mod 3=2) then inc(j,3)
	 else if k mod 3=0 then inc(j,6);
	if d1[i] and d2[j] then
	  begin
	  	x[k] := i; y[k] := j;
	  	ii := i; jj := j;
	  	exit(true);
	  end;
	exit(false);
end;

procedure tinh(num : longint);
	var i,j,res : longint;
begin
	res := 0;
	for i := 1 to 9 do
	 for j := 1 to i-1 do
	  res := res + abs(x[i]-x[j])*abs(y[i]-y[j]);
	if res > sum[num] then
	  begin
         sum[num] := res;
         if num=xx then
         begin
           dem := 1;
	       x2[dem] := x; y2[dem] := y;
         end
        else begin
            x1 := x; y1 := y;
        end;
	  end
	else if (res = sum[num]) and (num=xx) then
      begin
          inc(Dem); x2[dem] := x; y2[dem] := y;
      end;
end;

procedure ql(k,num : longint);
	var i,j,u,v : longint;
begin
	if k > 9 then
	  begin
	  	tinh(num);
	  	exit;
	  end;
	for i := 1 to 3 do
	  for j := 1 to 3 do
	    begin
	    	u := i; v := j;
	    	if (k>3) and (k<=6) then inc(u,3)
	 			else if k > 6 then inc(u,6);
			if (k mod 3=2) then inc(v,3)
	 		 	else if k mod 3=0 then inc(v,6);
			if d1[u] and d2[v] and (a[u,v]=0) then
			  begin
			  	d1[u] := false; d2[v] := false;
                x[k] := u; y[k] := v;
			  	ql(k+1,num);
			  	d1[u] := true; d2[v] := true;
			  end;
	    end;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	n := 9;
    for i := 1 to n do
     for j := 1 to n do read(a[i,j]);
    for i := 1 to n do
     for j := 1 to n do
      if a[i,j] < xx then a[i,j] := 0;
    fillchar(d1,sizeof(d1),true);
    d2 := d1;
    ql(1,xx);
    b := a;
    s1 := sum;
    while dem > 0 do
      begin
         a := b;
         ok := true;
         fillchar(sum,sizeof(sum),0);
         for j := 1 to n do a[x2[dem,j],y2[dem,j]] := xx;
         dec(dem);
         for i := xx-1 downto 1 do
           begin
               fillchar(d1,sizeof(d1),true);
               d2 := d1;
               fillchar(x1,sizeof(x1),0);
               y1 := x1;
               ql(1,i);
               if x1[1]=0 then
                begin
                  ok := false;
                  break;
                end;
               for j := 1 to n do a[x1[j],y1[j]] := i;
           end;
         if ok=false then continue;
         fillchar(sum,sizeof(sum),0);
         for i := 1 to n do for j := 1 to n do for u := 1 to n do for v := 1 to n do if a[i,j] = a[u,v] then inc(sum[a[i,j]],abs(u-i)*abs(v-j));
         res := 0;
         for i := 1 to n do res := res+(sum[i] div 2)*i;
         if res > r1 then
           begin
               r1 := res;
               c := a;
           end;
      end;
    writeln(r1);
    for i := 1 to n do
      begin
          for j := 1 to n do
           if c[i,j]>=0 then write(c[i,j],' ')
            else write(0,' ');
          writeln;
      end;
end.
