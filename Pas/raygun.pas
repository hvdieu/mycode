Uses math;
Const
	inp = 'input.txt';
	out = 'output.txt';
	maxn = 1000000;

Var
	m, n, i, ntest, test, t, j : longint;
	a : array [1..maxn] of qword;

begin
	//assign(input, inp); reset(input);
	//assign(output, out); rewrite(output);
	readln(ntest);
	for test := 1 to ntest do
		begin
			write('Case ',test,': ');
            readln(m, n);
			if (m > n) then
				begin
					t := m; m := n; n := t;
				end;
			if (m = 0) and (n = 0) then writeln(0)
			else if (m = 0) then writeln(1)
			else begin
				for i := m downto 1 do
					begin
						a[i] := (qword(m) div i) * (n div i);
						j := i*2;
						while (j <= m) do
							begin
								dec(a[i], a[j]);
								inc(j, i);
							end;
					end;
				writeln(a[1]+2);
			end;
		end;
end.
