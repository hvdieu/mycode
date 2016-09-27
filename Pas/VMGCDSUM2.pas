Uses math;
Const
	inp = 'vmgcdsum.inp';
	out = 'asd.out';
	maxn = 16;
	oo = 1000000007;

Var
	p,k : array [1..maxn] of longint;
	s,sum,tg,tmp,t2 : int64;
	n,i,j : longint;

function mu(a,b : longint) : longint;
	var temp : longint;
begin
	if b=0 then exit(1);
	if b=1 then exit(a mod oo);
	temp := mu(a,b div 2);
	temp := (int64(temp)*temp) mod oo;
	if b mod 2=0 then exit(temp)
	 else exit((int64(temp)*a) mod oo);
end;

function tinh(a,b : longint) : longint;
	var temp,x : longint;
begin
	if b=0 then exit(0);
	if b=1 then exit(a mod oo);
	temp := tinh(a,b div 2);
	x := mu(a,(b+1) div 2);
	temp := (int64(temp)*x) mod oo;
	if b mod 2=0 then exit(temp)
	 else exit((temp+x) mod oo);
end;

procedure main;
	var i,j : longint;
begin
	sum := 1;
	for i := 1 to n do
	  begin
	  	tmp := mu(p[i],k[i]);
	  	tmp := (int64(tmp)*tmp) mod oo;
        t2 := (sum*tmp) mod oo;
	  	sum := (((sum*mu(p[i],k[i])) mod oo)*((tinh(p[i],k[i]-1)+1)*2)) mod oo;
        sum := (sum+t2) mod oo;
	  end;
	tg := 1;
	for i := 1 to n do tg := (tg*mu(p[i],k[i])) mod oo;
	tg := mu(tg,oo-2);
	writeln((sum*tg) mod oo);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do read(p[i],k[i]);
	main;
end.

