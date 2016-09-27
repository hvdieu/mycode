Uses math;
Const
	inp = 'CRECT01.INP';
	out = 'CRECT01.OUT';
	maxn = 1001;

Type
	arr1 = array [0..maxn,0..maxn] of integer;
	arr2 = array [0..maxn] of longint;

Var	
	m,n,top : longint;
	a,h : arr1;
	st : arr2;
	res : int64;

procedure nhap();
	var i,j : longint;
	x : char;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(m,n);
	for i := 1 to m do
	begin
	  for j := 1 to n do
	   begin
	   	  read(x);
	   	  if x='0' then h[i,j] := 0 else h[i,j] := h[i-1,j]+1;
	   end;
	  readln;
	end;
end;

procedure main();
	var i,j : longint;
		s1,s2,s3 : int64;
begin
	for i := 1 to m do
		begin
			top := 1; st[1] := 0;
			s1 := 0; s2 := 0; s3 := 0;
			for j := 1 to n do
				begin
					while (top>0) and (h[i,j] <= h[i,st[top]]) do
						begin
							s1 := s1 - h[i,st[top]];
                            s2 := s2 - st[top-1]*h[i,st[top]];
                            s3 := s3 - st[top-1]*h[i,st[top-1]];
                            dec(top);
						end;
                    inc(top); st[top] := j;
                    s1 := s1 + h[i,st[top]];
                    s2 := s2 + st[top-1]*h[i,st[top]];
                    s3 := s3 + st[top-1]*h[i,st[top-1]];
                    res := res + s1*j-(s1-h[i,j])*j-s2+s3;
				end;
		end;
	writeln(res);
end;

begin
	nhap;
	main;
end.

