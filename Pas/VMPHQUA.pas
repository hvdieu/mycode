{$INLINE ON}
Uses math,sysutils;
const
	inp = '';
	out = '';
	maxn = 501;
	oo = 999999999;
    range = 100;

Var
	n,c,k,sl,r1,i : longint;
	a,id : array [0..maxn] of longint;
	d : array [0..maxn,0..maxn] of double;
	goc : array [1..maxn] of double;
	x,y : array [0..maxn] of double;
	kq,path : array [1..100,0..maxn] of longint;
	kl : array [1..100] of longint;
	free : array [1..maxn] of boolean;
	res,time,bound : double;
	time1,time2 : tdatetime;
	sum : array [1..100] of double;

procedure ghikq; inline;
	var i,j : longint;
begin
	for i := 1 to k do
	  begin
	  	write(0,' ');
	  	for j := 1 to kq[i,0] do write(id[kq[i,j]],' ');
        writeln(0);
	  end;
	halt;
end;

function tinhgoc(x,y : double) : double; inline;
	var o : double;
begin
	if x=0 then
	  begin
	  	 if y=0 then exit(0);
	  	 if y>0 then exit(pi/2)
	  	  else exit((3/2)*pi);
	  end;
	if y=0 then
	  begin
	  	  if x > 0 then exit(0)
	  	   else exit(pi)
	  end;
	o := abs(arctan(y/x));
	if x > 0 then
	  begin
	  	if y > 0 then exit(o)
	  	 else exit(2*pi-o)
	  end
	else begin
		if y > 0 then exit(pi-o)
		 else exit(pi+o);
	end;
end;

procedure swap(Var x,y : double); inline;
	var temp : double;
begin
	temp := x; x := y; y := temp;
end;

procedure sort(l,h : longint);
	var i,j,t : longint;
		k : double;
begin
	if l >= h then exit;
	i := l; j := h; k := goc[l+random(h-l+1)];
	repeat
		while goc[i] < k do inc(i);
		while goc[j] > k do dec(j);
		if i <= j then
		  begin
		  	swap(goc[i],goc[j]);
		  	swap(x[i],x[j]);
		  	swap(y[i],y[j]);
		  	t := id[i]; id[i] := id[j]; id[j] := t;
		  	t := a[i]; a[i] := a[j]; a[j] := t;
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure init; inline;
	var i,j,dem,sl,u,sum1,sum2,v,d1 : longint;
		temp : double;
begin
	for i := 1 to n do
	  begin
	    goc[i] := tinhgoc(x[i]-x[0],y[i]-y[0]);
	    id[i] := i;
	  end;
	sort(1,n-1);
	for i := 0 to n do
	 for j := 0 to i-1 do
	   begin
	   	d[i,j] := sqrt(sqr(x[i]-x[j])+sqr(y[i]-y[j]));
	   	d[j,i] := d[i,j];
	   end;
	dem := 0; sl := n;
	res := 0;
	fillchar(free,sizeof(free),true);
	repeat
		if sl=0 then break;
		inc(dem);
		i := 0; sum1 := 0; kq[dem,0] := 0;
		repeat
			temp := 999999999; v := 0;
		 	for u := 1 to n do
		 	 if free[u] and (d[i,u] <= temp) and (a[u]+sum1 <= c) then
		 	   begin
		 	   	 temp := d[i,u];
		 	   	 v := u;
		 	   end;
		 	if v=0 then
		 	  begin
		 	  	res := res+d[i,0];
		 	  	sum[dem] := sum[dem]+d[i,0];
		 	  	bound := max(bound,d[i,0]);
		 	  	break;
		 	  end;
		 	dec(sl); inc(kq[dem,0]); kq[dem,kq[dem,0]] := v; sum1 := sum1+a[v];
		 	inc(kl[dem],a[v]);
		 	free[v] := false; res := res+d[i,v];
		 	bound := max(bound,d[i,v]);
		 	sum[dem] := sum[dem]+d[i,v];
		 	i := v;
		 until false;
	until false;
	if dem > k then res := oo;
end;

procedure ql(i,u,sum,tt : longint; dd : double);
	var j,v : longint;
begin
	time2 := now;
	time := (time2-time1)*24*3600;
   //if time > 0.95 then ghikq;
    if (tt=k+1) and (i<=n) then exit;
	if (i > n) then
	  begin
        if u<>0 then dd := dd+d[u,0];
	  	if res > dd then
	  	begin
	  	   res := dd;
	  	   for i := 1 to k do
	  	      for j := 0 to path[i,0] do kq[i,j] := path[i,j];
	  	   end;
	  	exit;
	  end;
	for j := u+1 to n do
	 if free[j] and (sum+a[j]<=c) and (dd+d[u,j]<=res) and (abs(d[u,j]-bound)<=range) then
	  begin
	  	free[j] := false;
	  	inc(path[tt,0]); path[tt,path[tt,0]] := id[j];
	  	ql(i+1,j,sum+a[j],tt,dd+d[u,j]);
	  	dec(path[tt,0]);
	  	free[j] := true;
	  end;
	for j := 1 to u-1 do
	 if free[j] and (sum+a[j]<=c) and (dd+d[u,j]<=res) and (abs(d[u,j]-bound)<=range) then
	  begin
	  	free[j] := false;
	  	inc(path[tt,0]); path[tt,path[tt,0]] := id[j];
	  	ql(i+1,j,sum+a[j],tt,dd+d[u,j]);
	  	dec(path[tt,0]);
	  	free[j] := true;
	  end;
	if (dd+d[u,0]<=res) and (abs(d[u,0]-bound)<=range) then ql(i,0,0,tt+1,dd+d[u,0]);
end;

procedure dc(var x,y : longint); inline;
	var temp : longint;
begin
	temp := x; x := y; y := temp;
end;

procedure lsearch; inline;
	var i,j,u,v,t,sum1,sum2 : longint;
		r1,r2,temp : double;
begin
	repeat
		time2 := now;
		time := (time2-time1)*24*3600;
	    if time > 0.9 then ghikq;
		for i := 1 to k do
		 for j := 1 to kq[i,0] do
		  begin
		  u := random(k)+1; v := random(kq[u,0])+1;
		if (kq[i,0]<>0) and (kq[u,0]<>0) and (kl[i]-a[kq[i,j]]+a[kq[u,v]]<=c) and (kl[u]-a[kq[u,v]]+a[kq[i,j]]<=c) then
		   begin
		     time := (time2-time1)*24*3600;
		   	 if time > 0.9 then ghikq;
		   	 dc(kq[i,j],kq[u,v]);
		   	 temp := res-sum[i]-sum[u];
		   	 r1 := d[0,kq[i,1]]+d[kq[i,kq[i,0]],0];
		   	 r2 := d[0,kq[u,1]]+d[kq[u,kq[u,0]],0];
             sum1 := a[kq[i,1]]; sum2 := a[kq[u,1]];
		   	 for t := 2 to kq[i,0] do
              begin
                r1 := r1+d[kq[i,t],kq[i,t-1]];
                sum1 := sum1+a[kq[i,t]];
              end;
		   	 for t := 2 to kq[u,0] do
              begin
                r2 := r2+d[kq[u,t],kq[u,t-1]];
                sum2 := sum2 + a[kq[u,t]];
              end;
		   	 if (res >= temp+r1+r2) and (sum1<=c) and (sum2<=c) then
		   	   begin
		   	   		res := temp+r1+r2;
                    sum[i] := r1; sum[u] := r2;
                    kl[i] := sum1; kl[u] := sum2;
		   	   end
		   	 else dc(kq[i,j],kq[u,v]);
		   end;
		 end;
	until false;
end;

begin
	randomize;
	time1 := now;
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,k,c);
	dec(n);
	for i := 0 to n do readln(a[i],x[i],y[i]);
	init;
	fillchar(free,sizeof(Free),true);
	lsearch;
	//ql(1,0,0,1,0);
	ghikq;
end.
