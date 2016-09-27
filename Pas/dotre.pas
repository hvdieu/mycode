uses Math;
type
	arrayof2 = array[1..2] of longint;
var
	s, d, s2, d2 : array[1..2000] of longint;
	n, i, j, t, rm, best : longint;
	pre, suf : array[0..2000] of arrayof2;
	a : arrayof2;
	
procedure push(var a : arrayof2; x : longint);
begin
	if x > a[1] then
	begin
		a[2] := a[1];
		a[1] := x;
	end
	else if x > a[2] then a[2] := x;
end;
	
begin
        assign(input,'dotre.inp'); reset(input);
        assign(output, 'dotre.out'); rewrite(output);
	read(n);
	for i:=1 to n do read(s[i], d[i]);
	for i:=1 to n do
		for j:=i+1 to n do if d[j] < d[i] then
		begin
			t := s[i]; s[i] := s[j]; s[j] := t;
			t := d[i]; d[i] := d[j]; d[j] := t;
		end;
		
	best := 1000000000;
	for rm:=1 to n do
	begin
		j := 0;
		for i:=1 to n do if i <> rm then
		begin
			inc(j);
			s2[j] := s[i];
			d2[j] := d[i];
		end;
		fillchar( pre, sizeof(pre), 14 * 16);
		fillchar( suf, sizeof(suf), 14 * 16);
		t := 0;
		for i:=1 to n-1 do
		begin
			t := t + s2[i];
			pre[i] := pre[i-1];
			push(pre[i], t - d2[i]);
		end;
		for i:=n-1 downto 1 do
		begin
			suf[i] := suf[i+1];
			for j:=1 to 2 do suf[i,j] := suf[i,j] + s2[i];
			push( suf[i], s2[i] - d2[i]);
		end;
		t := 0;
		for i:=1 to n do
		begin
			a := suf[i];
			for j:=1 to 2 do a[j] := a[j] + t + s[rm];
			push(a, pre[i-1, 1]);
			push(a, pre[i-1, 2]);
			push(a, t + s[rm] - d[rm]);
			t := t + s2[i];
			best := min( best, max(a[1], 0) + max(a[2], 0));
		end;
	end;	
	writeln(best);
end.
