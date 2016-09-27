Uses math;
const
	inp = 'abcd.inp';
	out = 'abcd.out';

Var
	a,b,c,d,e,f,g,h : string;
	res : longint;

function abs(a,b : string) : string;
	var i,j,nho,x : longint;
		temp,c,ch : string;
begin
	while length(a) < length(b) do a := '0'+a;
	while length(a) > length(b) do b := '0'+b;
	if a < b then
	  begin
	  	temp := a; a := b; b := temp;
	  end;
	c := ''; nho := 0;
	for i := length(a) downto 1 do
	  begin
	  	 x := ord(a[i])-ord(b[i])-nho;
	  	 nho := 0;
	  	 if x < 0 then
	  	   begin
	  	   	 nho := 1; x := x+10;
	  	   end;
	  	 c := chr(x+48)+c;
	  end;
	while (length(c) > 1) and (c[1]='0') do delete(c,1,1);
	exit(c);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(a); readln(b); readln(c); readln(d);
	while res < 10000 do
	  begin
	  	 inc(res);
	  	 e := abs(a,b); f := abs(b,c); g := abs(c,d); h := abs(a,d);
	  	 a := e; b := f; c := g; d := h;
	  	 if (a='0') and (b='0') and (c='0') and (d='0') then
	  	   begin
	  	   	  writeln(res);
	  	   	  halt;
	  	   end;
	  end;
	writeln(-1);
end.
