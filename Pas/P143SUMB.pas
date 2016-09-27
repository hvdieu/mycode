Uses math;
Const 
	inp = 'asd.inp';
	out = 'asd.out';
	maxn = 1001;

Var
	m,n,i,j,r1,r2,u,temp,v,tmp : longint;
	a,b : array [1..maxn] of longint;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m);
	for i := 1 to m do read(a[i]);
	for i := 1 to m do b[i] := a[i];
	for i := 1 to n do 
	  begin
	  	 u := 0; temp := 0; v := 0; tmp := maxlongint;
	  	 for j := 1 to m do 
	  	 begin
	  	  if a[j] > temp then 
	  	    begin
	  	     	temp := a[j]; u := j;
	  	     end; 
	  	  if (b[j]<>0) and (b[j]<tmp) then
	  	    begin
	  	    	tmp := b[j]; v := j;
	  	    end;
	  	 end;
	  	 r1 := r1 + a[u]; dec(a[u]);
	  	 r2 := r2 + b[v]; dec(b[v]);
	  end;
	  writeln(r1,' ',r2);
end.