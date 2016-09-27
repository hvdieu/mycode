{$COPERATORS ON}
Uses math;
const
	inp = 'vpbindeg.inp';
	out = 'vpbindeg.out';
	maxn = 100010;

Var
	n,k : longint;
	s : string;

procedure main;
	var i,j : longint;
begin
	
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	while (ntest > 0) do begin
		dec(ntest);
		readln(n,k);
		readln(s);
		main;
	end;
end.