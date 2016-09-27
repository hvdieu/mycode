uses math;
Const
	inp = '';
	out = '';
	maxn = 1048590;

Var
	n,i: longint;
	a : array [1..maxn] of longint;
	f : array [1..maxn] of int64;
	s : string;

function tinh(i : longint) : int64;
	var res,l,r : int64;
begin
	if i*2 > n then exit(a[i]);
	res := 0;
	l := tinh(i*2);
    r := tinh(i*2+1);
	exit(-min(l,r)+a[i]);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n); n := 1 shl n-1;
	for i := 1 to n do read(a[i]);
    readln;
	readln(s);
	if s = 'first' then writeln(tinh(1))
	 else writeln(-tinh(1));
end.
