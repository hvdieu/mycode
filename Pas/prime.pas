Uses math;
Const
	inp = 'prime.inp';
	out = 'prime.out';
	maxn = 1501;
	maxa = 1000000;

Var
	m,n,i,j : longint;
	p : array [0..maxa] of boolean;
	a : array [1..maxn,1..maxn] of integer;
	res,sum : int64;

procedure init;
	var i,j : longint;
begin
	fillchar(p,sizeof(p),true);
	p[1] := false; p[0] := false;
	for i := 2 to trunc(sqrt(maxa)) do
	 if p[i] then
	  begin
	  	 j := i*i;
	  	 while j <= maxa do
	  	   begin
	  	   	 p[j] := false;
	  	   	 j := j+i;
	  	   end;
	  end;
end;

procedure main;
	var i,j,k,s1,s2,s3 : longint;
begin
	for i := 1 to m do
	  for j := 1 to n do
       if a[i,j]<>0 then
	    begin
	        s1 := a[i,j]; s2 := s1; s3 := s1;
	    	if p[a[i,j]] then
             begin inc(res); inc(sum,a[i,j]); end;
	    	for k := 1 to 5 do
	    	  begin
	    	  	 if j+k<=n then
	    	  	   begin
	    	  	   	 s1 := s1*10+a[i,j+k];
	    	  	   	 if p[s1] then
                      begin inc(res); inc(sum,s1); end;
	    	  	   end;
	    	  	 if i+k<=m then
	    	  	   begin
	    	  	     s2 := s2*10+a[i+k,j];
	    	  	     if p[s2] then
	    	  	       begin inc(res); inc(sum,s2); end;
	    	  	   end;
	    	  	 if (i+k<=m) and (j+k<=n) then
	    	  	   begin
	    	  	   	 s3 := s3*10+a[i+k,j+k];
	    	  	   	 if p[s3] then
	    	  	   	  begin inc(res); inc(sum,s3); end;
	    	  	   end;
	    	  end;
	    end;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(m,n);
	for i := 1 to m do
	  for j := 1 to n do read(a[i,j]);
	init;
	main;
	writeln(res,' ',sum);
end.
