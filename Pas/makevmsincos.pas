Uses math;
Const
	out = 'VMSINCOS.INP';

Var	
	n,q,i,a,u,v : longint;
	x : double;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

begin
	randomize;
	assign(output,out); rewrite(output);
	n := 20000; q := 10000;
	writeln(n);
	for i := 1 to n do
	  begin	
	  	a := random(2);
	  	if a=1 then write('-');
	  	x := random(31400000)/100000000;
	  	write(x:0:3,' ');
	  end;
    writeln;
    writeln(q);
	for i := 1 to q do
	  begin
	  	 a := random(4);
	  	 u := random(n)+1; v := random(n)+1; x := random(31400000)/100000000;
	  	 if u > v then swap(u,v);
	  	 if a=0 then writeln('Modify ',u,' ',x:0:3)
	  	  else if a=1 then writeln('Mul ',u,' ',v,' ',x:0:3)
	  	   else if a=2 then writeln('Sin ',u,' ',v,' ',x:0:3)
	  	    else if a=3 then writeln('Cos ',u,' ',v,' ',x:0:3)
	  	     else writeln('Reverse ',u,' ',v);
	  end;
end.
