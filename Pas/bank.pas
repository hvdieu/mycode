Uses math;
Const
	inp = 'bank.inp';
	out = 'bank.out';
	maxn = 31;

Var
	n,m,i,j,ntest,ma,mb : longint;
	a,b,x : array [1..maxn] of longint;
	ok : boolean;
	check : array [1..31,0..1000,0..1000] of boolean;
	dd : array [0..1048577] of boolean;
    free : array [1..maxn] of boolean;

procedure try(i,s : longint);
	var j : longint;
begin
	if ok then exit;
	if (i>m) and (s=a[1]) then
	  begin
	  	for j := 1 to m do write(x[j],' ');
	  	writeln;
	  	ok := true;
	  	exit;
	  end
    else if i > m then exit;
	x[i] := 0; try(i+1,s);
	if s+b[i]<=a[1] then
	  begin
	  	x[i] := 1;
	  	try(i+1,s+b[i]);
	  end;
end;

procedure sub1;
	var i,j : longint;
begin
	ok := false;
	try(1,0);
	if ok=false then writeln(-1);
end;

procedure call(i,s1,s2 : longint);
	var j : longint;
begin
	if ok then exit;
	if check[i,s1,s2] then exit;
	if (i>m) and (s1=0) and (s2=0) then
	  begin
	  	for j := 1 to m do write(x[j],' ');
	  	writeln;
	  	ok := true;
	  	exit;
	  end
    else if i > m then exit;
	x[i] := 0; call(i+1,s1,s2);
	if s1-b[i]>=0 then
	  begin
	  	x[i] := 1; call(i+1,s1-b[i],s2);
	  end;
	if s2-b[i] >= 0 then
	  begin
	  	x[i] := 2; call(i+1,s1,s2-b[i]);
	  end;
	check[i,s1,s2] := true;
end;

procedure sub2;
	var i,j : longint;
begin
	fillchar(check,sizeof(check),false);
	ok := false;
	call(1,a[1],a[2]);
	if ok=false then writeln(-1);
end;

procedure duyet(tt : longint);
	var i,j,s : longint;
begin
	if ok then exit;
	if dd[tt] then exit;
	s := 0;
	for i := 1 to m do
	  if (tt shr (i-1)) and 1=1 then inc(s,b[i]);
	j := 1;
	for i := 1 to n do
	  if s >= a[i] then
	    begin
	    	inc(j);
	    	s := s-a[i];
	    end
      else break;
	if j > n then
	    begin
	    	for i := 1 to m do write(x[i],' ');
	    	writeln;
	    	ok := true;
	    	exit;
	    end;
	for i := 1 to m do
	  if ((tt shr (i-1)) and 1=0) and (s+b[i]<=a[j]) then
	    begin
	    	x[i] := j;
	    	duyet(tt or (1 shl (i-1)));
	    	x[i] := 0;
	    end;
    dd[tt] := true;
end;

procedure sub3;
	var i,j : longint;
begin
	fillchar(free,sizeof(free),true);
	fillchar(dd,sizeof(dd),false);
	fillchar(x,sizeof(x),0);
    ok := false;
	duyet(0);
	if ok=false then writeln(-1);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	while ntest > 0 do
	  begin
	  	dec(ntest);
	  	readln(n,m); ma := 0; mb := 0;
	  	a[1] := 0; a[2] := 0;
	  	for i := 1 to n do
	  	    begin read(a[i]); ma := max(ma,a[i]); end;
	  	for i := 1 to m do
	  	    begin read(b[i]); mb := max(mb,b[i]); end;
	  	if (n=1) and (m<=20) then sub1
	    else if (n<=2) and (m<=30) and (ma<=1000) and (mb<=1000) then sub2
	  	  else sub3;
	  end;
end.
