Uses math;
Const
	inp = 'GRGAME.INP';
	out = 'GRGAME.OUT';
	maxn = 101;

Var
	a,b : array [1..maxn] of longint;
	n,ntest,i,aa,bb,bound,oo,x,j : longint;
	f : array [0..10000] of longint;
	ok : boolean;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	while ntest > 0 do
	   begin
	   	  dec(ntest);
	   	  readln(n); aa := 0; bb := 0;
	   	  for i := 1 to n do
	   	    begin
	   	    	read(a[i]);
	   	    	a[i] := a[i]*100; aa := max(aa,a[i]);
	   	    end;
	   	  for i := 1 to n do
	   	    begin
	   	    	read(b[i]); bb := max(bb,b[i]);
	   	    end;
	   	  bound := aa+bb;
	   	  for oo := bound downto 1 do
	   	     begin
	   	     	ok := true;
	   	     	for i := 1 to n do inc(f[b[i] mod oo]);
	   	     	for i := 1 to n do
	   	     	  begin
	   	     	  	x := a[i] mod oo;
	   	     	  	x := (oo - x) mod oo;
	   	     	  	if f[x] > 0 then dec(f[x])
	   	     	  	 else
                      begin
                        ok := false;
                        break;
                      end;
	   	     	  end;
                if ok=true then
	   	     	  	  begin
	   	     	  	  	writeln(oo);
	   	     	  	  	for j := 1 to n do f[b[j] mod oo] := 0;
	   	     	  	  	break;
	   	     	  	  end;
	   	     	for i := 1 to n do f[b[i] mod oo] := 0;
	   	     end;
	   end;
end.
