Uses math;
const
	inp = 'LRF.INP';
	out = 'LRF.out';

Type	arr = array [1..2,1..2] of longint;

Var
	n,l,r,oo,ntest,dem,x,a,b,i,j : longint;
	s : string;
	c,bb : arr;
	kq,ok : boolean;

function nhan(a,b : arr) : arr;
	var c : arr;
		i,j,k : longint;
begin
	for i := 1 to 2 do
	  for j := 1 to 2 do
	    begin
	    	c[i,j] := 0;
	    	for k := 1 to 2 do c[i,j] := (int64(c[i,j])+(int64(a[i,k])*b[k,j]) mod oo) mod oo;
	    end;
	nhan := c;
end;

function mu(a : arr;n : longint) : arr;
	var temp : arr;
begin
	if n=1 then exit(a);
	temp := mu(a,n div 2);
	if n mod 2=0 then exit(nhan(temp,temp))
	 else exit(nhan(temp,nhan(temp,a)));
end;

begin
	randomize;
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	while ntest > 0 do
	  begin
	  	dec(ntest);
	  	readln(n,l,r);
	  	readln(s);
	  	kq := false;
        oo := 1000000000+random(1000000000);
	  	x := 0;
	  	for i := 1 to length(s) do
         x := (int64(x)*10+(ord(s[i])-ord('0'))) mod oo;
        c[1,1] := 0; c[1,2] := 1; c[2,1] := 1; c[2,2] := 1;
	  	if n > 1 then c := mu(c,n-1);
	  	for a := l to r do
	  	  for b := l to r do
	  	begin
	  		bb[1,1] := a; bb[1,2] := b;
	  		if n > 1 then bb := nhan(bb,c);
	  		if bb[1,1]=x then
              begin
                ok := true;
                  for dem := 1 to 3 do
                    begin
                        oo := 1000000000+random(1000000000);
	  	                x := 0;
	  	                for i := 1 to length(s) do
                        x := (int64(x)*10+(ord(s[i])-ord('0'))) mod oo;
                        c[1,1] := 0; c[1,2] := 1; c[2,1] := 1; c[2,2] := 1;
	  	                if n > 1 then c := mu(c,n-1);
                        bb[1,1] := a; bb[1,2] := b;
	  		            if n > 1 then bb := nhan(bb,c);
                        if bb[1,1]<>x then
                          begin
                              ok := false;
                              break;
                          end;
                    end;
                  if ok then kq := true;
              end;
	  	end;
	  	if kq = false then writeln('NO')
         else writeln('YES');
	  end;
end.
