Uses math;
const
	inp = '475D.INP';
	out = '475D.out';
	maxn = 100010;

Var
	n,q,i,vmax : longint;
	a : array [1..maxn] of longint;
	f : array [1..maxn,0..20] of longint;

function gcd(a,b : longint) : longint;
begin
	if b=0 then exit(a)
	 else exit(gcd(b,a mod b));
end;

function get(u,v : longint) : longint;
	var i,j,temp : longint;
begin
	
end;

procedure khoitao;
	var i,j : longint;
begin
	vmax := trunc(ln(n)/ln(2));
	for i := 1 to n do f[i][0] := a[i];
	for j := 1 to vmax do
      for i := 1 to n do
        if (i+1 shl (j-1) <= n) and (f[i+1 shl (j-1),j-1]<>0) then
          f[i,j] :=  gcd(f[i+1 shl (j-1),j-1],f[i,j-1]);

end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do read(a[i]);
	khoitao;
end.