{$M 1000000000}
Uses math;
Const
	inp = 'harbinge.inp';
	out = 'harbinge.out';
	maxn = 100010;

Type
	line = record
		a, b : int64;
		x : extended;
	end;

Var
	n, i : longint;
	head, cha : array [0..maxn] of longint;
    s, v, d : array [0..maxn] of int64;
	ke, next, w : array [-maxn..maxn] of longint;
	f : array [0..maxn] of int64;
	st : array [0..maxn] of line;
	top : longint;

procedure nhap();
	var i, uu, vv, l : longint;
begin
	//assign(input, inp); reset(input);
	//assign(output, out); rewrite(output);
	readln(n);
	for i := 2 to n do
		begin
			readln(uu, vv, l);
			ke[i] := vv; next[i] := head[uu]; w[i] := l; head[uu] := i;
			ke[-i] := uu; next[-i] := head[vv]; w[-i] := l; head[vv] := -i;
		end;
	for i := 2 to n do readln(s[i], v[i]);
end;

function cal(x : int64) : int64;
	var d, c, mid, ans : longint;
begin
    d := 1; c := top; ans := 0;
    while (d <= c) do
		begin
			mid := (d + c) div 2;
			if (x >= st[mid].x) then
				begin
					ans := mid; d := mid+1;
				end
			else c := mid-1;
		end;
	exit(x*st[ans].a + st[ans].b);
end;

procedure dfs(u : longint);
	var j, vv, l, lef, righ, mid, ans : longint;
		luu : line;
		temp, a1, b1, a2, b2 : int64;
		xx : extended;

begin
	l := top;
	if (u <> 1) then
		begin
			temp := cal(v[u]);
			f[u] := int64(d[u])*v[u] + s[u] + min(0, temp);
			a1 := -d[u]; b1 := f[u];
			lef := 1; righ := top;
			ans := top+1;
			while (lef <= righ) do
				begin
					mid := (lef+righ) div 2;
					a2 := st[mid-1].a; b2 := st[mid-1].b;
					xx := (b2-b1) / (a1-a2);
					if (xx <= st[mid].x) then
						begin
							ans := mid; righ := mid-1;
						end
					else lef := mid+1;
				end;
			top := ans; luu := st[ans];
			a2 := st[top-1].a; b2 := st[top-1].b;
			xx := (b2-b1)/(a1-a2);
			st[top].x := xx; st[top].a := a1; st[top].b := b1;
		end;

	j := head[u];
    while (j <> 0) do
		begin
			vv := ke[j];
			if (vv > 0) and (cha[vv] = 0) then
				begin
					cha[vv] := u;
					d[vv] := d[u] + w[j];
					dfs(vv);
				end;
			j := next[j];
		end;
	if (u <> 1) then
		begin
			top := l; st[ans] := luu;
		end;
end;

begin
	nhap();
	cha[1] := 1;
    top := 0;
    fillchar(st, sizeof(st), 0);
	dfs(1);
	for i := 2 to n do write(f[i],' ');
end.
