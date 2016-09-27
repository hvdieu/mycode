Uses math;
Const
	inp = 'input.txt';
	out = 'output.txt';
	maxn = 11;
	maxm = 101;
	eps = 0.0000000001;
Var
	m, n, i, j, k, pt, dem, cnt : longint;
    res, x : array [1..maxm] of extended;
    a : array [1..maxm, 1..maxm] of extended;
	vt : array [1..maxm] of longint;
	c : array [1..maxn,1..maxn] of extended;

function id(i, j : longint) : longint;
begin
	exit((i-1)* n + j);
end;

procedure swap(Var xx, yy : extended);
	var temp : extended;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure dc(var xx, yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure solve();
	var i, j,ii, jj, dem, t, len : longint;
		hs, sum : extended;
begin
	pt := 0;
	for i := 1 to m do for j := 1 to n do begin
		dem := 0; inc(pt);
		for ii := 1 to m do for jj := 1 to n do
		if (abs(i-ii) + abs(j-jj) <= k) then
        begin
			inc(dem); a[pt][id(ii,jj)] := 1;
		end else a[pt][id(ii,jj)] := 0;
		a[pt][m*n+1] := c[i][j] * dem;
	end;

	for i := 1 to m*n do vt[i] := i;
	for i := 1 to pt do
	begin
		if (abs(a[i][i]) <= eps) then
		begin
			for j := i + 1 to pt do if (abs(a[i][j]) > eps) then
			begin
				for t := 1 to pt do swap(a[t][j], a[t][i]);
				dc(vt[i], vt[j]);
				break;
			end;
		end;

		for j := i + 1 to pt do if (abs(a[j][i]) > eps) then
		begin
			hs := a[i][i] / a[j][i];
			for t := i to m * n + 1 do a[j][t] := a[j][t] * hs - a[i][t];
		end;
	end;

	for i := pt downto 1 do
	begin
		sum := 0;
		for j := i + 1 to pt do sum := sum + x[j] * a[i][j];
		x[i] := (a[i][m*n+1] - sum) / a[i][i];
		res[vt[i]] := x[i];
	end;

	for i := 1 to m*n do
	begin
        t := trunc(res[i]);
        if (t = 0) then len := 1 else
        begin
            len := 0;
            while (t > 0) do
            begin
                inc(len); t := t div 10;
            end;
        end;
        for j := 1 to 8-3-len do write(' ');
		write(res[i]:0:2); if ((i mod n = 0) and (i < m*n)) then writeln;
	end;
end;

begin
   //assign(input, inp); reset(input);
   //assign(output, out); rewrite(output);
	while (true) do begin
		readln(n, m, k);
		if (n = 0) then break;
        inc(cnt);
        if (cnt > 1) then begin
            writeln; writeln;
        end;
		for i := 1 to m do for j := 1 to n do read(c[i][j]);
		solve();
	end;
end.
