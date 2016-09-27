Uses math;
Const
	inp = 'mmc.inp';
	out = 'mmc.out';
	maxn = 501;

Type
	arr = array [1..maxn,1..maxn] of qword;
	arr1 = array [1..maxn,1..maxn] of qword;

Var
	c,d,e : arr;
	a,b : arr1;
	n,ntest,i,j,dem : longint;
	ok,kq : boolean;

function nhan(var a : arr1; var b : arr) : arr;
	var c : arr;
		i,j,k : longint;
begin
	for i := 1 to n do
	  for j := 1 to 1 do
	   begin
	   	  c[i,j] := 0;
	   	  for k := 1 to n do c[i,j] := c[i,j]+a[i,k]*b[k,j];
	   end;
	nhan := c;
end;

begin
	randomize;
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	while ntest > 0 do
	  begin
	  	 dec(ntest);
	  	 readln(n);
	  	 for i := 1 to n do
	  	   for j := 1 to n do read(a[i,j]);
	  	 for i := 1 to n do
	  	   for j := 1 to n do read(b[i,j]);
         dem := 0;
         kq := true;
         repeat
         inc(Dem);
	  	 for i := 1 to n do c[i,1] := random(10)+1;
	  	 d := nhan(b,c);
         e := nhan(a,c);
	  	 for i := 1 to 2 do e := nhan(a,e);
	  	 ok := true;
	  	 for i := 1 to n do
	  	   if d[i,1]<>e[i,1] then ok := false;
         if ok=false then
           begin
               writeln('NO');
               kq := false;
               break;
           end;
         until dem=1;
         if kq then writeln('YES');
	  end;
end.
