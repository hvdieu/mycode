{$H+}
Uses math;
Const
	inp = 'input.txt';
	out = 'output.txt';
	oo = 1000000007;
    maxn = 100010;

Var
	ntest,n,m : longint;
	a,b : string;
	pos : array ['a'..'z'] of longint;
	next : array [0..maxn,'a'..'z'] of longint;
    f : array [0..maxn] of longint;
	res : int64;

procedure trace(i,j : longint);
	var ch : char;
		jj : longint;
begin
	if i > n then exit;
	if j > m then exit;
	for ch := chr(ord(b[j])+1) to 'z' do
     if (j=1) or ((j<>1) and (ch<>b[j-1])) then
	  begin
	  	  jj := next[i][ch];
          res := (res + f[jj]) mod oo;
	  end;
	if ((j>1) and (b[j]<>b[j-1])) or (j=1) then trace(next[i][b[j]],j+1);
end;

procedure main;
	var i,j : longint;
		ch : char;
begin
	for ch := 'a' to 'z' do pos[ch] := n+1;
	for i := n downto 0 do
	  begin
	  	 for ch := 'a' to 'z' do next[i][ch] := pos[ch];
	  	 if i<>0 then pos[a[i]] := i;
	  end;
    f[n] := 1; f[n+1] := 0;
    for i := n-1 downto 1 do
      begin
          f[i] := 1;
          for ch := 'a' to 'z' do
           if ch <> a[i] then
            begin
               j := next[i][ch];
               f[i] := (f[i] + f[j]) mod oo;
            end;
      end;
    res := 0;
    trace(0,1);
    writeln(res);
end;

begin
   assign(input,inp); reset(input);
   assign(output,out); rewrite(output);
	readln(ntest);
	while (ntest > 0) do begin
		dec(ntest);
		readln(a);
		readln(b);
		n := length(a); m := length(b);
		main;
	end;
end.
