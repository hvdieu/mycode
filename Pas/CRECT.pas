Uses math;
Const
	inp = '';
	out = '';
	maxn = 401;

Type	arr1 = array [0..maxn,0..maxn] of longint;
		arr2 = array [0..maxn] of longint;

Var
	m,n,top : longint;
    res : int64;
	a,h : arr1;
	st : arr2;
    f : array [0..4,0..4,0..4] of int64;
    dd : array [0..4] of boolean;

procedure nhap();
	var i,j : longint;
		s : ansistring;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(m,n);
	for i := 1 to m do
		begin
			readln(s);
			for j := 1 to n do a[i,j] := ord(s[j])-65;
		end;
end;


function xuly() : int64;
	var i,j : longint;
		s1,s2,s3,res : int64;
begin
	res := 0;
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
	exit(res);
end;

procedure init(c1,c2,c3 : longint);
	var i,j : longint;
begin
	fillchar(h,sizeof(h),0);
	for i := 1 to m do
	  for j := 1 to n do
	   if (a[i,j]=c1) or (a[i,j]=c2) or (a[i,j]=c3) then h[i,j] := h[i-1,j]+1 else h[i,j] := 0;
end;

procedure main();
	var i,j,tt,k,dem,c1,c2,c3,c4,c5,c6: longint;
begin
	res := 0;
	for c1 := 0 to 4 do
	  for c2 := c1 to 4 do
	    for c3 := c2 to 4 do
	      begin
	      	init(c1,c2,c3);
	      	f[c1,c2,c3] := xuly;
	      end;

	for c1 := 0 to 4 do
	  for c2 := c1+1 to 4 do
	    for c3 := c2+1 to 4 do
	      begin
            res := res + f[c1,c2,c3]-f[c1,c1,c2]-f[c1,c1,c3]-f[c2,c2,c3]+f[c1,c1,c1]+f[c2,c2,c2]+f[c3,c3,c3];
	      end;
	writeln(res);
end;

begin
	nhap;
	main;
end.
