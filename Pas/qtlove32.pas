{$MODE OBJFPC}
{$INLINE OFF}
Uses math;
const
	inp = 'qtlove3.inp';
	out = 'asd.out';
	maxn = 2000001;

Var
	k,m,n,res,oo : int64;
	mu,p : array [1..maxn] of longint;
	i,dem,maxl : longint;

procedure sangngto; inline;
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

function tinh(k,n : longint) : int64; inline;
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
     writeln(tinh(m,m+n));
end;

function tinh2(k,n : longint) : int64; inline;
	var i,j : longint;
		kq : int64;
begin
    if n < k then exit(0);
	kq := 1;
	for i := 1 to k do kq := (kq*i) mod oo;
	for j := 0 to oo-1 do
	 if (kq*j) mod oo=1 then
	   begin
	   	 kq := j;
	   	 break;
	   end;
	for i := n-k+1 to n do kq := (kq*i) mod oo;
	exit(kq);
end;

procedure sub2; inline;
	var i,j,x,x1,x2 : longint;
begin
	n := n+m;
	res := 1;
	while (m>0) and (n>0) do
	  begin
	  	x1 := m mod oo; x2 := n mod oo; m := m div oo; n := n div oo;
	  	res := (res*tinh2(x1,x2)) mod oo;
        if res=0 then break;
	  end;
	writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m,oo);
	dec(m);
    if (n <= 1000000) and (m <= 1000000) then sub1
      else sub2;
end.



