Uses math;
Const
	inp = '';
	out = '';
	maxn = 100001;

Var
	n,m,w,i,d,c,mid,res : longint;
	a,t : array [1..maxn] of longint;

procedure update(i,val : longint);
begin
	while i <= n do
	  begin
	  	inc(t[i],val);
	  	inc(i,i and (-i));
	  end;
end;

function get(i : longint) : longint;
	var s : longint;
begin
	s := 0;
	while i > 0 do
	  begin
	  	inc(s,t[i]);
	  	dec(i,i and (-i));
	  end;
	exit(s);
end;

function check(x : longint) : boolean;
	var i,j : longint;
		dem : int64;
begin
	fillchar(t,sizeof(t),0);
	dem := 0;
	for i := 1 to n do
	  begin
	  	j := get(i);
	  	if a[i]+j < x then
	  	  begin
	  	  	update(i,(x-a[i]-j));
	  	  	update(i+w,-(x-a[i]-j));
	  	  	dem := dem+x-a[i]-j;
	  	  end;
	  end;
	if dem <= m then exit(True)
	 else exit(false);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m,w);
	d := maxlongint;
	for i := 1 to n do
	  begin
	  	read(a[i]);
	  	d := min(d,a[i]);
	  	c := max(c,a[i]);
	  end;
	c := c+m;
	while d <= c do
	   begin
	   	  mid := (d+c) shr 1;
	   	  if check(mid) then
	   	    begin
	   	    	res := mid;
	   	    	d := mid+1;
	   	    end
	   	  else c := mid-1;
	   end;
    writeln(res);
end.
