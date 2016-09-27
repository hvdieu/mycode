Uses math;
Const
	inp = '';
	out = '';
	a : array [1..6] of string =
	(
		'+------------------------+ ',
		'|#.#.#.#.#.#.#.#.#.#.#.|D|)',
		'|#.#.#.#.#.#.#.#.#.#.#.|.| ',
		'|#.......................| ',
		'|#.#.#.#.#.#.#.#.#.#.#.|.|)',
		'+------------------------+ '
	);
Var
	m,n : longint;
	i,j : longint;
	ok : boolean;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	while n > 0 do
	  begin
        dec(n);
	    ok := false;
	  	for j := 1 to 27 do
	  	begin
	  	 for i := 1 to 6 do
	  	  if a[i][j] = '#' then
	  	   begin
	  	   	 ok := true;
	  	   	 a[i][j] := 'O';
	  	   	 break;
	  	   end;
	  	   if ok then break;
	  	 end;
	  end;
    for i := 1 to 26 do write(a[1][i]); writeln;
    for i := 1 to 27 do write(a[2][i]); writeln;
    for i := 3 to 4 do
     begin
         for j := 1 to 26 do write(a[i][j]);
         writeln;
     end;
    for i := 1 to 27 do write(a[5][i]); writeln;
    for i := 1 to 26 do write(a[6][i]);
end.
