Uses math;
Const
	inp = 'RECURR.INP';
	out = 'RECURR.OUT';
	maxn = 51;

Type
	arr = array [1..maxn,1..maxn] of longint;

Var
	ntest,n,d,i,j : longint;
	a,b : array [1..maxn] of longint;
	x : array [1..maxn,1..maxn] of longint;
	c,e : arr;
    ok : boolean;

function nhan(a,b : arr) : arr;
	var i,j,k : longint;
		c : arr;
begin
    fillchar(c,sizeof(c),0);
	for i := 1 to d do
	 for j := 1 to d do
	  begin
	  	c[i,j] := 0;
	  	for k := 1 to d do
	  	   c[i,j] := (c[i,j]+a[i,k]*b[k,j]) mod 3;
	  end;
     exit(c);
end;

function mu(a : arr; x : longint) : arr;
	var temp : arr;
begin
	if x=1 then exit(a);
	temp := mu(a,x div 2);
	if x mod 2=0 then exit(nhan(temp,temp))
	 else exit(nhan(nhan(temp,temp),a));
end;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure main;
	var i,j,k,hs,sum : longint;
        e : arr;
begin
	fillchar(c,sizeof(c),0);
	for i := 1 to d do c[i,1] := 1;
	i := 0;
	for j := 2 to d do
      begin
      	inc(i); c[i,j] := 1;
      end;
    c := mu(c,n-1);
    for i := 1 to (d+1) div 2 do swap(b[i],b[d-i+1]);
    fillchar(x,sizeof(x),0);
    for i := 1 to d do
      begin
      	for j := 1 to d do x[i,j] := c[j,i];
      	x[i,d+1] := b[i];
      end;
    for i := 1 to d do
       begin
       	 if x[i,i]=0 then
       	 for j := i+1 to d do
       	  if x[j,i]<>0 then
       	    begin
       	      for k := 1 to d+1 do swap(x[i,k],x[j,k]);
       	      break;
       	    end;
       	 if x[i,i]<>0 then
       	   begin
       	   	 for j := i+1 to d do
       	   	  if x[j,i]<>0 then
       	   	   begin
       	   	      if (x[i,i]=x[j,i]) then
                   begin
                   for k := 1 to d+1 do
                    x[j,k] := (x[i,k]-x[j,k]+3) mod 3;
                   end
                  else for k := 1 to d+1 do
                   x[j,k] := (x[i,k]+x[j,k]) mod 3;
       	   	   end;
       	   end;
       end;
    for i := d downto 1 do
       begin
       	  j := n-i+1;
       	  sum := 0;
       	  for k := i+1 to d do sum := (sum+x[i,k]*a[k]) mod 3;
       	  for k := 0 to 2 do
       	    if (k*x[i,i]+sum) mod 3 = x[i,d+1] then
       	      begin
       	      	a[i] := k;
       	      	break;
       	      end;
       end;
    for i := 1 to d do e[1,i] := a[i];
   // e := nhan(e,c);
  //  ok := true;
   // for i := 1 to d do if e[1,i]<>b[i] then ok := false;
    for i := d downto 1 do write(a[i],' ');
    writeln;
  //  if ok then writeln('DUNG')
  //   else writeln('SAI');
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	while ntest > 0 do
	  begin
	  	dec(ntest);
	  	readln(n,d);
	  	for i := 1 to d do read(b[i]);
	  	main;
	  end;
end.
