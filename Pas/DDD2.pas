Uses math;
Const
	inp = 'DDD2.INP';
	out = 'DDD2.OUT';
	maxn = 31;
	oo = 100000000;

Type arr = array [0..100] of longint;
	 arr1= array [0..40] of int64;

Var
	m,n,i,j : longint;
	a : array [1..maxn,1..maxn] of longint;
	x : array [1..maxn*maxn,1..maxn*maxn] of integer;
	res : arr;

function nhan(a : arr; b : longint) : arr;
	var i,j : longint;
		x,nho : int64;
begin
	fillchar(nhan,sizeof(nhan),0);
	nhan[0] := a[0];
	nho := 0;
	for i := 1 to a[0] do
	  begin
	  	x := (int64(a[i])*b)+nho;
	  	nhan[i] := x mod oo;
	  	nho := x div oo;
	  end;
	if nho <> 0 then
	   begin
	   	 inc(nhan[0]); nhan[nhan[0]] := nho;
	   end;
end;

procedure ghi(a : arr);
var i : longint;
    s : string;
        begin
            write(a[a[0]]);
            for i := a[0]-1 downto 1 do
              begin
                  str(a[i],s);
                  while length(s) < 8 do s := '0'+s;
                  write(s);
              end;
            writeln;
        end;

procedure main;
	var i,j,d2,d1,u,v,ii,jj : longint;
begin
	d1 := 0;
    fillchar(x,sizeof(x),0);
	for i := 1 to m do
	  for j := 1 to n do
	    begin
	    	inc(d1);
	    	if a[i,j]<>-1 then
	    	  begin
	    	  	 d2 := 0;
	    	  	 for u := 1 to m do
	    	  	  for v := 1 to n do
	    	  	  begin
	    	  	   inc(d2);
	    	  	   if (abs(i-u)<=1) and (abs(j-v)<=1) and ((i<>u) or (j<>v)) then x[d1,d2] := 1
	    	  	    else x[d1,d2] := 0;
	    	  	  end;
	    	  	inc(d2); x[d1,d2] := a[i,j];
	    	  end;
	    end;
	res[0] := 1; res[1] := 1;
	for i := 1 to d1 do
	  begin
	  	u := 0;
	  	for j := 1 to m*n do
	  	  if x[i,j]<>0 then
	  	   begin
	  	   	u := j; break;
	  	   end;
	  	if u=0 then
	  	  begin
	  	    if x[i,m*n+1]=0 then res := nhan(res,2)
	  	     else
	  	      begin
	  	      	writeln(-1);
	  	      	exit;
	  	      end;
	  	  end
	  	 else begin
	  	 	for ii := i+1 to d1 do
	  	 	  if x[ii,u]=1 then
	  	 	   begin
	  	 	   	 for jj := 1 to m*n+1 do
	  	 	   	  x[ii,jj] := (x[ii,jj]+x[i,jj]) mod 2;
	  	 	   end;
	  	 end;
	  end;
	ghi(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	repeat
		readln(m,n);
		if m=0 then break;
		for i := 1 to m do
		 for j := 1 to n do read(a[i,j]);
		main;
	until false;
end.
