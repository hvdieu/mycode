Uses math;
Const
	out = 'VMAZE.INP';
	maxn = 2001;

Var	
	m,n,i,j,k : longint;

begin
	randomize;
	assign(output,out); rewrite(output);
	m := 2000; n := 2000;
	writeln(m,' ',n);
	for i := 1 to m do
	  begin
	  	for j := 1 to n do
	  	  begin
	  	  	k := random(4);
	  	  	if k=0 then write('-');
	  	  	if k=1 then write('+');
	  	  	if k=2 then write('.');
	  	  	if k=3 then write('|');
	  	  end;
	  	writeln;
	  end;
end.
