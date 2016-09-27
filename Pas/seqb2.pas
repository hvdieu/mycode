{$mode delphi}
uses SysUtils, Math;

var
	L : array[1..100000] of longint;
	n, i, j, inf, x, le, ri, mi : longint;
	str : string;
begin
	readln(n);
	inf := 2000000000;
	for i:=1 to n do L[i] := inf;
	for i:=1 to n do 
	begin
		readln(str);
		if str = '*' then
		begin
			for j:=n downto 2 do L[j] := min(L[j], L[j-1] + 1);
			L[1] := 0;
		end
		else
		begin
			x := StrToInt(str);
			if x <= L[1] then L[1] := x
			else
			begin
				le := 1;
				ri := n;
				while le < ri do
				begin
					mi := (le + ri) div 2 + 1;
					if L[mi] < x then le := mi
					else ri := mi - 1;
				end;
				L[le+1] := min(L[le+1], x);
			end;
		end;
	end;
	for i:=n downto 1 do if L[i] < inf then
	begin
		writeln(i);
		break;
	end;
end.
