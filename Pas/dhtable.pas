{$Coperators ON}
{$H+}
Uses math;
Const
	inp = 'input.txt';
	out = 'output.txt';
	maxn = 151;

Var
	n, i : longint;
	s, res : string;


function cong(a, b : string) : string;
	var c, s : string;
		i, nho, x : longint;
begin
	while (length(a) < length(b)) do a := '0' + a;
	while (length(a) > length(b)) do b := '0' + b;
	c := ''; nho := 0;
	for i := length(a) downto 1 do
		begin
			x := ord(a[i]) - ord('0') + ord(b[i]) - ord('0') + nho;
			nho := x div 10;
			x := x mod 10;
			str(x, s);
			c := s + c;
		end;
	if (nho = 1) then c := '1' + c;
	exit(c);
end;

function tru(a, b : string) : string;
	var c, s : string;
		i, nho, x : longint;
begin
	while (length(a) < length(b)) do a := '0' + a;
	while (length(a) > length(b)) do b := '0' + b;
	nho := 0; c := '';
	for i := length(a) downto 1 do
		begin
			x := ord(a[i]) - ord(b[i]) - nho;
			if (x < 0) then
				begin
					x += 10;
					nho := 1;
				end
			else nho := 0;
			str(x, s);
			c := s + c;
		end;
	while (length(c) > 1) and (c[1] = '0') do delete(c, 1, 1);
	exit(c);
end;

Function nhan1(a : string;b : longint) : string;
Var i,j,sum,carry,s : longint;
    c,tmp,st : string;
        BEGIN
            c := ''; carry := 0;
            For i := length(a) downto 1 do
               BEGIN
                   sum := (ord(a[i]) - ord('0')) * b + carry;
                   carry := sum div 10;
                   sum := sum mod 10;
                   str(sum,st);
                   c := st + c;
               END;
            if carry > 0 then str(carry,tmp) else tmp := '';
            nhan1 := tmp + c;
        END;

Function nhan(a,b : string) : string;
Var sum,tmp : string;
    m,i,j  :  longint;
        BEGIN
             m := -1; sum := '';
             For i := length(a) downto 1 do
                BEGIN
                     inc(m);
                     tmp := nhan1(b,ord(a[i]) - 48);
                     For j := 1 to m do tmp := tmp + '0';
                     sum := cong(tmp,sum);
                END;
             nhan := sum;
        END;


function count(x : string) : string;
	var i, j, len : longint;
		mu, sum, y : string;
begin
	sum := '0'; mu := '9'; y := '';
	len := length(x);
	for i := 1 to length(x)-1 do
		begin
			sum := cong(sum, nhan1(mu, i));
			mu := mu + '0';
			y := y + '9';
		end;
	x := tru(x, y);
	sum := cong(sum, nhan1(x, len));
	exit(sum);
end;

function getmin(a, b : string) : string;
	var i : longint;
begin
	if (length(a) < length(b)) then exit(a);
	if (length(a) > length(b)) then exit(b);
	for i := 1 to length(a) do
	if (a[i] < b[i]) then exit(a)
	else if (a[i] > b[i]) then exit(b);
	exit(a);
end;

function compare(a, b : string; t : longint) : boolean;
    var i, j : longint;
begin
    if (t = 0) then
    begin
        for i := 1 to min(length(a), length(b)) do
        if (a[i] <> b[i]) then exit(false);
        exit(true);
    end;
    i := length(a); j := length(b);
    while (i > 0) and (j > 0) do
        begin
            if (a[i] <> b[j]) then exit(false);
            dec(i); dec(j);
        end;
    exit(true);
end;

function check(x, y : string) : string;
    var i, nho, num : longint;
        z : string;
begin
    z := '1';
    for i := 1 to length(x)-1 do z := '0' + z;
    nho := 0;
    for i := length(x) downto 1 do
      begin
        if (x[i] <> '*') and (y[i] <> '*') then
          begin
              if (ord(x[i]) - ord(y[i]) - nho <> ord(z[i]) - ord('0')) then exit('-1');
              nho := 0;
          end
        else if (x[i] = '*') then
          begin
             num := nho + ord(y[i]) - ord('0') + ord(z[i]) - ord('0');
             nho := num div 10;
             num := num mod 10;
             x[i] := chr(ord('0') + num);
          end
        else begin
             num := ord(x[i]) - ord('0') - (ord(z[i]) - ord('0')) - nho;
             if (num < 0) then
               begin
                   num += 10;
                   nho := 1;
               end;
             y[i] := chr(ord('0') + num);
        end;
      end;
    exit(y);
end;

procedure sub1();
	var i, j, lx, ly, len : longint;
        flag : boolean;
        x, y, sl, z : string;
begin
    if (s[1] <> '0') and (length(s) < 16) then res := count(s)
    else if (length(s) < 15) then res := count('1' + s)
    else begin
         flag := true;
         for i := 1 to length(s) do if (s[i] <> '0') then flag := false;
         if (flag) then res := count('1' + s);
    end;
    for i := 1 to n-1 do
    if (s[i+1] <> '0') then
        begin
            x := copy(s, i+1, n-i); lx := length(x);
            y := copy(s, 1, i); ly := length(y);
            for len := max(lx, ly) to lx + ly do
              begin
                  x := copy(s, i+1, n-i);
                  y := copy(s, 1, i);
                  while (length(x) < len) do x := x + '*';
                  while (length(y) < len) do y := '*' + y;
                  z := check(x, y);
                  if (z <> '-1') then
                    begin
                        str(n-i, sl);
                        if (res <> getmin(res, cong(count(z), sl))) then
                            begin
                              res := getmin(res, cong(count(z), sl));
                              writeln(z);
                            end;
                    end;
              end;
        end;
end;

procedure sub2();
	var i, j, len : longint;
		x, y, temp, tmp : string;
		flag : boolean;
begin
	for len := 1 to min(n, 15) do
		for i := 1 to min(n-len+1, len) do
         if (s[i] <> '0') then
			begin
				x := copy(s, i, len);
				flag := true;
				if (i > 1) and (compare(tru(x, '1'), copy(s, 1, i-1), 1) = false) then flag := false;
				j := i + len;
				while (j <= n) and flag do
					begin
						x := cong(x, '1');
						y := copy(s, j, length(x));
						if (compare(x, y, 0) = false) then flag := false;
                        j += length(x);
					end;
				x := copy(s, i, len);
				if flag then
					begin
						temp := count(x);
						str(n-i+1-len, tmp);
    			        temp := cong(temp, tmp);
						res := getmin(res, temp);
					end;
			end;
end;

begin
    assign(input, inp); reset(input);
    assign(output, out); rewrite(output);
	readln(n);
	readln(s);
    res := '';
    for i := 1 to 10000 do res := res + '9';
	if (n <= 30) then sub1();
	sub2();
    //writeln(count('270537624309716'));
    if (length(res) <> 10000) then writeln(res)
    else writeln(-1);
end.
