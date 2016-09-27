{$H+}
Uses math;
Const
    inp = '';
	out = '';
	maxn = 1001;

Type
	arr1 = array [1..maxn] of string;
	arr2 = array [1..maxn,1..1] of char;

Var
	a,b,c : arr1;
	d,e,f : arr2;
	ntest,n,i,j : longint;
	ch : Char;
    s : array [1..maxn] of string;

function nhan(a : arr1;b : arr2) : arr2;
	var i,j,k,x,n1,n2 : longint;
		c : arr2;
begin
    for i := 1 to n do
	  for j := 1 to 1 do
	    begin
	    	x := 0;
	    	for k := 1 to n do
	    	  begin
	    	  	n1 := ord(a[i,k])-ord('0'); n2 := ord(b[k,j])-ord('0');
	    	  	x := (x+n1*n2) mod 10;
	    	  end;
            c[i,j] := chr(x+ord('0'));
	    end;
	exit(c);
end;

procedure main;
	var i,j,k,dem : longint;
		ok : boolean;
        ch : char;
begin
	ok := true;
	for dem := 1 to 5 do
	  begin
	  	for i := 1 to n do d[i,1] := chr(random(10)+ord('0'));
	  	e := nhan(b,d); e := nhan(a,e);
	  	f := nhan(c,d);
        for i := 1 to n do
         if e[i,1]<>f[i,1] then
           begin
             ok := false;
             break;
           end;
	  	if ok=false then break;
	  end;
	if ok then writeln('YES')
	  else writeln('NO');
end;

begin
	randomize;
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	while ntest > 0 do
	   begin
	   	  dec(ntest);
	   	  readln(n);
          for i := 1 to n do readln(a[i]);
          for i := 1 to n do readln(b[i]);
          for i := 1 to n do readln(c[i]);
	   	  main;
	   end;
end.

