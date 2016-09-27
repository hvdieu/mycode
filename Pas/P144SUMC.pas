Uses math;
Const
	inp = 'P144SUMC.INP';
	out = 'P144SUMC.OUT';
	oo = 1000000007;
    maxn = 1000001;

Var
	a,b,n,x,i : longint;
	res,kq,k1 : int64;
	gt : array [0..maxn] of int64;

function pow(a,x : longint) : longint;
	var temp : qword;
begin
	if x=0 then exit(1);
	if x=1 then exit(a mod oo);
	temp := pow(a, x div 2);
	if x mod 2=0 then exit((temp*temp) mod oo)
        else exit((temp*((temp*a) mod oo)) mod oo);
end;

function check(x : longint) : boolean;
begin
	while x > 0 do
	  begin
	  	if (x mod 10 <> a) and (x mod 10 <> b) then exit(false);
	  	x := x div 10;
	  end;
	exit(true);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(a,b,n);
	gt[1] := 1; gt[0] := 1;	
	for i := 2 to n do
	  begin
	  	gt[i] :=(gt[i-1]*i) mod oo;
	  end;
	for i := 0 to n do
	  begin
	  	x := i*a+(n-i)*b;
	  	if check(x) then
	  	  begin
	  	  	res := (res+(gt[n]*pow((gt[i]*gt[n-i]) mod oo,oo-2)) mod oo) mod oo;
	  	  end;
	  end;
    writeln(res);
end.
