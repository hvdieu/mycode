{$H+}
Uses math;
Const
	inp = '';
	out = '';
	maxn = 2001;

Type
	arr1 = array [1..maxn] of string;
	arr2 = array [0..maxn,0..maxn] of longint;
	arr3 = array [0..maxn] of longint;

Var
	n,i,j: longint;
	a : arr1;
	f,g : arr3;
	s : arr2;
	r1,r2,r3,d1,d2,d3 : longint;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do readln(a[i]);
	f[1] := 1; g[1] := 1; s[1,1] := 1;
	if a[1,1]='1' then
		begin
			inc(d2); r2 := 1;
		end
	else begin inc(d3); r3 := 1; end;
	i := 1;
	for j := 2 to n do
		begin
			if a[i,j]='1' then
			  begin inc(d2); r2 := 1; end
	            else begin inc(d3); r3 := 1; end;
			g[j] := 1;
			if a[i,j] <> a[i,j-1] then f[j] := f[j-1]+1 else f[j] := 1;
			s[i,j] := 1;
		end;
	for i := 2 to n do
	 for j := 1 to n do
	  begin
	  	 if j=1 then f[1] := 1
          else if a[i,j]<>a[i,j-1] then f[j] := f[j-1]+1 else f[j] := 1;
	  	 if a[i,j]<>a[i-1,j] then g[j] := g[j]+1 else g[j] := 1;

	  	 if j >= 1 then
	  	 	begin
	  	 		s[i,j] := min(g[j],f[j]);
	  	 		if (j>1) then
	  	 			begin
	  	 				if a[i,j]=a[i-1,j-1] then s[i,j] := min(s[i,j],s[i-1,j-1]+1)
	  	 				 else s[i,j] := 1;
	  	 			end;
	  	 		if s[i,j] mod 2=0 then
	  	 			begin
	  	 				if s[i,j]>r1 then begin r1 := s[i,j]; d1 := 1; end
	  	 				 else if s[i,j]=r1 then inc(d1);
	  	 				if (a[i,j]='1') and (s[i,j]-1>=r2) then
	  	 				  begin
	  	 				  	if s[i,j]-1>r2 then begin r2 := s[i,j]-1; d2 := 1; end else inc(d2);
	  	 				  end
	  	 				else if (s[i,j]-1>=r3) and (a[i,j]='0') then
	  	 				  begin
	  	 				  	if s[i,j]-1>r3 then begin r3 := s[i,j]-1; d3 := 1; end else inc(d3);
	  	 				  end;
	  	 			end
	  	 		else begin
	  	 				if (a[i,j]='1') and (s[i,j]>=r2) then
	  	 				  begin
	  	 				  	if s[i,j]>r2 then begin r2 := s[i,j]; d2 := 1; end else inc(d2);
	  	 				  end
	  	 				else if (s[i,j]>=r3) and (a[i,j]='0') then
	  	 				  begin
	  	 				  	if s[i,j]>r3 then begin r3 := s[i,j]; d3 := 1; end else inc(d3);
	  	 				  end;
	  	 				if s[i,j]-1 > r1 then begin r1 := s[i,j]-1; d1 := 1; end else if s[i,j]-1=r1 then inc(d1);
	  	 		end;
	  	 	end;
	  end;
    if r1=0 then d1 := 0;
    if r2=0 then d2 := 0;
    if r3=0 then d3 := 0;
	writeln(r1,' ',d1); writeln(r2,' ',d2); writeln(r3,' ',d3);
end.
