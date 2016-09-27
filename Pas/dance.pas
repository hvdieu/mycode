Uses math;
Const
	inp = 'DANCE.INP';
	out = 'DANCE.OUT';
	maxn = 1000001;

Var
	dd : array [-maxn..maxn] of longint;
	res : int64;
	i,x,n : longint;
	ch : char;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	inc(dd[0]);
	for i := 1 to n do
	  begin
	  	read(ch);
	  	if ch='a' then inc(x) else dec(x);
	  	res := res + dd[x];
	  	inc(dd[x]);
	  end;
	writeln(res);
end.
