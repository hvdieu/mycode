Uses math;
Const
	inp = 'ad.inp';
	out = 'asd.out';

Var
	n,p,i : longint;
	s : array [-1..1001] of char;

procedure find(i,ok : longint);
	var j : longint;
		ch : char;
begin
    if i=0 then
      begin
          writeln('NO');
          halt;
      end;
	if i > n then
	  begin
	  	for j := 1 to n do write(s[j]);
	  	halt;
	  end;
	if ok=0 then
	  begin
	  	for j := ord(s[i])+1 to ord('a')+p-1 do
	  	 begin
	  	  	ch := chr(j);
	  	  	if (ch <> s[i-1]) and (ch<>s[i-2]) then
	  	  	 begin
	  	  	 	s[i] := ch;
	  	  	 	find(i+1,1);
	  	  	 end;
	  	  end;
	  end
	else begin
		for j := ord('a') to ord('a')+p-1 do
		  begin
		  	ch := chr(j);
		  	if (ch<>s[i-1]) and (ch<>s[i-2]) then
		  	  begin
		  	  	s[i] := ch;
		  	  	find(i+1,1);
		  	  end;
		  end;
	end;
	find(i-1,0);
end;

begin
	s[0] := '.'; s[-1] := '.';
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,p);
	for i := 1 to n do read(s[i]);

	find(n,0);
	writeln('NO');
end.
