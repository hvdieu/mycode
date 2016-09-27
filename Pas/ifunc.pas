Uses math;
Const
	inp = 'IFUNC.INP';
	out = 'IFUNC.OUT';
	maxn = 100000007;
    oo =   100000007;

Var
	check,dd : array [0..maxn] of boolean;
	f : array [0..maxn] of qword;
    g : array [0..oo] of qword;
    n : int64;
    i : longint;

function max(x,y : qword) : qword;
begin
    if x > y then exit(x) else exit(y);
end;

function tinh(i : qword) : qword;
	var x : int64;
begin
	if (i<=maxn) and check[i] then exit(f[i]);
    if (i > maxn) and dd[i mod oo] then exit(g[i mod oo]);
	x := max(i,tinh(i div 2)+tinh(i div 3)+tinh(i div 4));
	if i <= maxn then
	  begin
	  	check[i] := true;
	  	f[i] := x;
        exit(x);
	  end;
    dd[i mod oo] := true;
    g[i mod oo] := x;
	exit(x);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	check[0] := true;
	while not seekeof(input) do
	   begin
	   	 readln(n);
	   	 writeln(tinh(n));
	   end;
    //for i := 1 to 100000000 do if tinh(i)=i then writeln(i);
end.
