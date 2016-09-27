Uses math;
const
	inp = 'voscal.inp';
	out = 'voscal.out';
	maxn = 2000001;

Var
	res,oo : int64;
	m,n : longint;
	mu,p : array [1..maxn] of longint;
	i,dem,maxl : longint;

procedure sangngto;
	var i,j : longint;
begin
	for i := 2 to trunc(sqrt(maxl)) do
	  if p[i]=0 then
	    begin
	    	j := i*i;
	    	while j <= maxn do
	    	  begin
	    	  	p[j] := i;
	    	  	j := j+i;
	    	  end;
	    end;
end;

function nhan(a,b : int64) : int64;
	var temp : int64;
begin
	if oo <= 1000000000 then exit((a*b) mod oo);
	if b=0 then exit(0);
	if b=1 then exit(a mod oo);
	temp := nhan(a,b div 2);
	if b mod 2=0 then exit((temp+temp) mod oo)
	 else exit((temp+temp+a) mod oo);
end;

function tinh(k,n : longint) : int64;
	var i,j,x : longint;
		kq : int64;
begin
	if n < k then exit(0);
	kq := 1;
	for i := 1 to k do
	  begin
	  	x := i;
	  	while p[x] <> 0 do
	  	   begin
	  	   	 j := p[x];
	  	   	 while x mod j = 0 do
	  	   	   begin
	  	   	   	 dec(mu[j]);
	  	   	   	 x := x div j;
	  	   	   end;
	  	   end;
        if x > 1 then dec(mu[x]);
	  end;
	for i := n-k+1 to n do
	  begin
	  	 x := i;
	  	 while p[x] <> 0 do
	  	   begin
	  	   	 j := p[x];
	  	   	 while x mod j = 0 do
	  	   	   begin
	  	   	   	 inc(mu[j]);
	  	   	   	 x := x div j;
	  	   	   end;
	  	   	 while mu[j] > 0 do
	  	   	   begin
	  	   	   	 kq := nhan(kq,j);
	  	   	   	 dec(mu[j]);
	  	   	   end;
	  	   end;
         if x > 1 then inc(mu[x]);
         while mu[x] > 0 do
           begin
           	 kq := nhan(kq,x);
           	 dec(mu[x]);
           end;
	  end;
    exit(kq);
end;

procedure sub1; inline;
    var i,j : longint;
begin
     maxl := m+n;
     sangngto;
     writeln(tinh(n,n+m) mod oo);
end;

function pow(a,x : longint) : longint;
	var temp : qword;
begin
	if x=0 then exit(1);
	if x=1 then exit(a mod oo);
	temp := pow(a, x div 2);
	if x mod 2=0 then exit((temp*temp) mod oo)
        else exit((temp*((temp*a) mod oo)) mod oo);
end;

function tinh2(k,n : longint) : longint;
	var i,j : longint;
		kq,k1 : qword;
begin
    if n < k then exit(0);
    if n=k then exit(1);
    kq := 1;
    for i := 1 to max(k,n-k) do
      begin
      	kq := (kq*i) mod oo;
      	if i=min(k,n-k) then k1 := kq;
      end;
    k1 := (kq*k1) mod oo;
    k1 := pow(k1,oo-2);
    for i := max(k,n-k)+1 to n do kq := (kq*i) mod oo;
    exit((kq*k1) mod oo);
end;

procedure sub2;
	var i,j,x,x1,x2,t : longint;
begin
    t := n;
    n := n+m;
    m := t;
	res := 1;
	while (m>0) and (n>0) do
	  begin
	  	x1 := m mod oo; x2 := n mod oo; m := m div oo; n := n div oo;
	  	res := (res*tinh2(x1,x2)) mod oo;
        if res=0 then break;
	  end;
	writeln(res mod oo);
end;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
	readln(n,m,oo);
	dec(m);
    if (n <= 1000000) and (m <= 1000000) then sub1
      else
    sub2;
end.

