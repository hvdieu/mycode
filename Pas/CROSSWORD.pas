Uses math;
Const
	inp = '';
	out = '';
	maxk = 1001;
	maxn = 51;

Var
	m,n,k,i,j,sl,kk,t1,sl2 : longint;
    time : double;
	s : array [1..maxk] of string;
	a : array [1..maxn,1..maxn] of char;
	d : array [1..maxn,1..maxn] of integer;
	id1,x1,y1,z1,id2,x2,y2,z2,vt : array [1..maxk] of longint;
	free : array [1..maxk] of boolean;
	res,r1 : double;
	ss,temp : string;

procedure ghikq;
	var i : longint;
begin
	writeln(sl);
	for i := 1 to sl do writeln(id2[i],' ',x2[i],' ',y2[i],' ',z2[i]);
end;

function check(u,v,dd : longint; s : string) : boolean;
	var i,j,l : longint;
begin
	l := length(s);
	if dd=0 then
	  begin
	  	i := u; j := v+l-1;
	  	if (v-1>0) and (d[u,v-1]=dd) then exit(false);
	  	if (v+l<=n) and (d[u,v+l]=dd) then exit(false);
	  	if (i>m) or (j>n) then exit(false);
	  	for j := v to v+l-1 do
	  	 begin
	  	   if (a[u,j]<>'.') and (a[u,j]<>s[j-v+1]) then exit(false);
	  	   if dd=d[u,j] then exit(false);
	  	 end;
	  	exit(true);
	  end
	else begin
		i := u+l-1; j := v;
		if (u-1>0) and (d[u-1,v]=dd) then exit(false);
		if (u+l<=m) and (d[u+l,v]=dd) then exit(false);
		if (i>m) or (j>n) then exit(false);
		for j := u to u+l-1 do
		 begin
		   	if (a[j,v]<>'.') and (a[j,v]<>s[j-u+1]) then exit(false);
		   	if dd=d[j,v] then exit(false);
		 end;
		exit(true);
	end;
end;

procedure update(u,v,dd : longint; s : string);
	var i,j,l : longint;
begin
	l := length(s);
	if dd=0 then
	  begin
	  	for j := v to v+l-1 do
	  	  if a[u,j]='.' then
	  	    begin
	  	    	a[u,j] := s[j-v+1];
	  	    	d[u,j] := 0;
	  	    end;
	  end
	else begin
		for i := u to u+l-1 do
		  if a[i,v]='.' then
		    begin
		    	a[i,v] := s[i-u+1];
		    	d[i,v] := 1;
		    end;
	end;
end;

function dat(i,dd : longint) : boolean;
	var u,v : longint;
begin
	if dd=0 then
	begin
	for u := 1 to m do
	 for v := 1 to n do
	  if check(u,v,dd,s[i]) then
	    begin
	    	update(u,v,dd,s[i]);
            inc(sl); id1[sl] := vt[i];
            x1[sl] := u; y1[sl] := v; z1[sl] := dd;
	    	exit(true);
	    end;
	end else 
	begin
		for v := n downto 1 do 
		 for u := m downto 1 do 
		  if check(u,v,dd,s[i]) then
	    begin
	    	update(u,v,dd,s[i]);
            inc(sl); id2[sl] := vt[i];
            x1[sl] := u; y1[sl] := v; z1[sl] := dd;
	    	exit(true);
	    end;
	end;
	exit(false);
end;

procedure search;
	var i,j,t,u,v,dd,u1,v1,d1,temp,uu,vv,d2,dem1 : longint;
begin
	for i := 1 to k do
	  begin
	  	if sl mod 2=0 then dd := 0
	  	 else dd := 1;
	  	If dat(i,dd)=false then dat(i,1-dd);
	  end;
end;

procedure sort(l,h : longint);
	var i,j,k,t1 : longint;
		temp : string;
begin
	if l >= h then exit;
	i := l; j := h; k := length(s[(h+l) div 2]);
	repeat
		while (length(s[i]) < k) do inc(i);
		while (length(s[j]) > k) do dec(j);
		if i <= j then
		  begin
            if i < j then
            begin
		  	temp := s[i]; s[i] := s[j]; s[j] := temp;
		  	t1 := vt[i]; vt[i] := vt[j]; vt[j] := t1;
            end;
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure sort4(l,h : longint);
	var i,j,k,t1 : longint;
		temp : string;
begin
	if l >= h then exit;
	i := l; j := h; k := length(s[vt[l+random(h-l+1)]]);
	repeat
		while (length(s[vt[i]]) < k) do inc(i);
		while (length(s[vt[j]]) > k) do dec(j);
		if i <= j then
		  begin
            if i < j then
            begin
		  	t1 := vt[i]; vt[i] := vt[j]; vt[j] := t1;
            end;
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure sort2;
	var i,j : longint;
begin
	for i := 1 to k do
	 for j := i+1 to k do
	  if length(s[vt[i]]) > length(s[vt[j]]) then
	    begin
	     	temp := s[i]; s[i] := s[j]; s[j] := temp;
		  	t1 := vt[i]; vt[i] := vt[j]; vt[j] := t1;
	    end;
end;

procedure sort3;
	var i,j : longint;
begin
	for i := 1 to k do
	 for j := i+1 to k do
	  if length(s[vt[i]]) >= length(s[vt[j]]) then
	    begin
	     	temp := s[i]; s[i] := s[j]; s[j] := temp;
		  	t1 := vt[i]; vt[i] := vt[j]; vt[j] := t1;
	    end;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(m,n,k);
	
	for i := 1 to k do
	  begin
	  	readln(ss);
	  	if length(ss) <= max(m,n) then
	  	  begin
	  	  	inc(kk); s[kk] := ss; vt[kk] := i;
	  	  end;
	  end;
	k := kk;
	for i := 1 to k do vt[i] := i;
	for i := 1 to m do
	 for j := 1 to n do
	  begin
	    a[i,j] := '.';
	    d[i,j] := -1;
	  end;
	sort(1,k);
	search;
	
	fillchar(free,sizeof(free),true);
	search;
	ghikq;
end.




