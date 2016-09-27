{$mode delphi}
type
	itarray = array[1..100000 * 4] of longint;
var
	it : array[1..2,1..2] of itarray; // left - right, down - up
	n, m, x, code, u, v, i : longint;
	ok : boolean;
	a : array[1..100000] of longint;
	
function get(var it : itarray; i, l, r, p : longint) : longint;
var
	m : longint;
begin
	if it[i] <> -1 then get := it[i]
	else
	begin
		m := (l + r) div 2;
		if p <= m then get := get( it, 2 * i, l, m, p)
		else get := get( it, 2 * i + 1, m + 1, r, p);
	end;
end;

procedure color(var it : itarray; i, l, r, u, v, c : longint);
var
	m : longint;
begin
	if (u <= l) and (r <= v) then
	begin
		it[i] := c;
	end
	else
	begin
		if it[i] <> -1 then
		begin
			it[2*i] := it[i];
			it[2*i+1] := it[i];
			it[i] := -1;
		end;
		m := (l + r) div 2;
		if u <= m then color( it, 2 * i, l, m, u, v, c);
		if m < v then color( it, 2 * i + 1, m + 1, r, u, v, c);
	end;
end;

procedure update(i, v : longint);
var
	le, ri : longint;
begin
	a[i] := v;

	le := get( it[1][2], 1, 1, n, i);
	ri := get( it[2][1], 1, 1, n, i);

	if (le < i) and (a[i] > a[i-1]) then color( it[2][1], 1, 1, n, le, i - 1, i-1)
	else if (le <= i) and (ri > i) and (a[i] < a[i+1]) then color( it[2][1], 1, 1, n, le, i, i);
	if (ri > i) and (a[i] < a[i+1]) then color( it[1][2], 1, 1, n, i + 1, ri, i+1)
	else if (ri >= i) and (le < i) and (a[i] > a[i-1]) then color( it[1][2], 1, 1, n, i, ri, i);

	le := get( it[1][2], 1, 1, n, i);
	if (le > 1) and (a[le-1] >= a[le]) then le := get( it[1][2], 1, 1, n, le-1);	
	ri := get( it[2][1], 1, 1, n, i);
	if (ri < n) and (a[ri+1] <= a[ri]) then ri := get( it[2][1], 1, 1, n, ri+1);
	color( it[1][2], 1, 1, n, le, ri, le);
	color( it[2][1], 1, 1, n, le, ri, ri);
	

	le := get( it[1][1], 1, 1, n, i);
	ri := get( it[2][2], 1, 1, n, i);

	if (le < i) and (a[i] < a[i-1]) then color( it[2][2], 1, 1, n, le, i - 1, i-1)
	else if (le <= i) and (ri > i) and (a[i] > a[i+1]) then color( it[2][2], 1, 1, n, le, i, i);
	if (ri > i) and (a[i] > a[i+1]) then color( it[1][1], 1, 1, n, i + 1, ri, i+1)
	else if (ri >= i) and (le < i) and (a[i] < a[i-1]) then color( it[1][1], 1, 1, n, i, ri, i);

	le := get( it[1][1], 1, 1, n, i);
	if (le > 1) and (a[le-1] <= a[le]) then le := get( it[1][1], 1, 1, n, le-1);	
	ri := get( it[2][2], 1, 1, n, i);
	if (ri < n) and (a[ri+1] >= a[ri]) then ri := get( it[2][2], 1, 1, n, ri+1);
	color( it[1][1], 1, 1, n, le, ri, le);
	color( it[2][2], 1, 1, n, le, ri, ri);
end;

begin
	read(n, m);
	fillchar( it, -1, sizeof(it));
	color( it[1][1], 1, 1, n, 1, n, 1);
	color( it[1][2], 1, 1, n, 1, n, 1);
	color( it[2][1], 1, 1, n, 1, n, n);
	color( it[2][2], 1, 1, n, 1, n, n);
	for i:=1 to n do
	begin
		read(x);
		update(i, x);
	end;
	for i:=1 to m do
	begin
		read(code, u, v);
		if code = 1 then
			update(u, v)
		else
		begin
			// writeln('exe');
			ok := false;
			x := get( it[2][1], 1, 1, n, u);
			// writeln('x = ', x);
			if x < v then
			begin
				x := get( it[2][2], 1, 1, n, x);
				// writeln('x = ', x);
				if x < v then ok := true;
			end;
			if ok then writeln(1)
			else writeln(0);
		end;
	end;
end.
