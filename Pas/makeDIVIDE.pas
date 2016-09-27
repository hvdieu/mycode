uses math;
Const
	out = 'divide.inp';
    sub = 3;
    maxn = 5000;
   	maxa = 40000;
Var
	n, i, j : longint;
    a,b : array [1..maxn] of longint;
	dd : array [0..maxa] of longint;

procedure makesub1;
	var i, j : longint;
begin
	n := 5000;
    dd[0] := 1;
    for i := 1 to n do
      begin
          a[i] := 0;
          while (dd[a[i]] = 1) do
          a[i] := random(maxa)+1;
          b[i] := a[i];
          dd[a[i]] := 1;
      end;
end;

procedure makesub2;
	var i, j : longint;
begin
	dd[0] := 1;
    n := 20;
    for i := 1 to n do
      begin
          a[i] := 0;
          while (dd[a[i]] = 1) do a[i] := random(maxa)+1;
          dd[a[i]] := 1;
          b[i] := random(maxa)+1;
      end;
end;

procedure makesub3;
	var i,j : longint;
begin
    dd[0] := 1;
    n := 5000;
    for i := 1 to n do
      begin
          a[i] := 0;
          while (dd[a[i]] = 1) do a[i] := random(maxa)+1;
          dd[a[i]] := 1;
          b[i] := random(maxa)+1;
      end;
end;

begin
    randomize;
    assign(output, out); rewrite(output);
    if sub = 1 then makesub1
    else if sub = 2 then makesub2
    else makesub3;
    writeln(n);
    for i := 1 to n do write(a[i],' ');
    writeln;
    for i := 1 to n do write(b[i],' ');
end.
	
