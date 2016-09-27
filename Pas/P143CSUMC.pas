{$H+}
Uses math;
const
	inp = '';
	out = '';
	maxn = 100001;

Var
	a,s : array [0..maxn] of longint;
	n,sum,i,res : longint;
	x : string;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
    readln(n);
	for i := 1 to n do read(a[i]);
    readln;
	readln(x);
	for i := 1 to n do s[i] := s[i-1]+a[i];
	for i := n downto 1 do
	 if x[i]='1' then
	   begin
	   	 res := max(res,sum+s[i-1]);
	   	 sum := sum+a[i];
         res := max(sum,res);
	   end;
	writeln(Res);
end.
