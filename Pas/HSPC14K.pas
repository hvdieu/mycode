Uses math;
Const
	inp = '';
	out = '';
	maxn = 1001;

Var
	t,s : array [1..4,1..maxn,1..maxn] of int64;
	m,n,ntest,x1,x2,y1,y2,kind : longint;
	w : int64;

procedure update(tt,i,j : longint; val : int64);
	var jj : longint;
begin
	while i <= m do
	  begin
	  	jj := j;
	  	while jj <= n do
	  	  begin
	  	  	inc(t[tt,i,jj],val);
	  	  	inc(jj,jj and (-jj));
	  	  end;
	  	inc(i,i and (-i));
	  end;
end;

function get(tt,i,j : longint) : int64;
	var jj : longint; s : int64;
begin
	s := 0;
	while i > 0 do
	  begin
	  	jj := j;
	  	while jj > 0 do
	  	  begin
	  	  	inc(s,t[tt,i,jj]);
	  	  	dec(jj,jj and (-jj));
	  	  end;
	  	dec(i,i and (-i));
	  end;
	get := s;
end;

procedure tang(tt,x1,y1,x2,y2 : longint; x : int64);
begin
	inc(s[tt,x1,y1],x); inc(s[tt,x1,y2+1],-x);
	inc(s[tt,x2+1,y1],-x); inc(s[tt,x2+1,y2+1],x);
end;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure update1(x1,y1,x2,y2 : longint;x : int64);
	var k : longint;
begin
	for k := 1 to 4 do
	  begin
	  	s[k,x1,y1] := 0; s[k,x1,y2+1] := 0; s[k,x2+1,y1] := 0; s[k,x2+1,y2+1] := 0;
	  end;
	tang(1,x1,y1,x2,y2,x); tang(2,x1,y1,x2,y2,-x*(y1-1));
	tang(3,x1,y1,x2,y2,-x*(x1-1)); tang(4,x1,y1,x2,y2,x*(x1-1)*(y1-1));
	tang(2,x1,y2+1,x2,n,x*(y2-y1+1)); tang(4,x1,y2+1,x2,n,-x*(y2-y1+1)*(x1-1));
	tang(3,x2+1,y1,m,y2,x*(x2-x1+1)); tang(4,x2+1,y1,m,y2,-x*(x2-x1+1)*(y1-1));
	tang(4,x2+1,y2+1,m,n,x*(x2-x1+1)*(y2-y1+1));
	for k := 1 to 4 do
	  begin
	  	update(k,x1,y1,s[k,x1,y1]); update(k,x1,y2+1,s[k,x1,y2+1]);
	  	update(k,x2+1,y1,s[k,x2+1,y1]); update(k,x2+1,y2+1,s[k,x2+1,y2+1]);
	  end;
end;

function sum(i,j : longint) : int64;
    var s1,s2,s3,s4 : int64;
begin
    s1 := get(1,i,j);
    s2 := get(2,i,j);
    s3 := get(3,i,j);
    s4 := get(4,i,j);
	sum := s1*i*j+s2*i+s3*j+s4;
end;

function get1(x1,y1,x2,y2 : longint) : int64;
    var s1,s2,s3,s4 : int64;
begin
    s1 := sum(x2,y2);
    s2 := sum(x1-1,y2);
    s3 := sum(x2,y1-1);
    s4 := sum(x1-1,y1-1);
	get1 := s1-s2-s3+s4;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(m,n,ntest);
	while ntest > 0 do
	  begin
	  	 dec(ntest);
	  	 read(kind);
	  	 if kind=1 then
	  	   begin
	  	   	 readln(x1,y1,x2,y2,w);
	  	   	 if x1 > x2 then swap(x1,x2);
	  	   	 if y1 > y2 then swap(y1,y2);
	  	   	 update1(x1,y1,x2,y2,w);
	  	   end
	  	else begin
	  		readln(x1,y1,x2,y2);
	  		if x1 > x2 then swap(x1,x2);
	  	   	if y1 > y2 then swap(y1,y2);
	  		writeln(get1(x1,y1,x2,y2));
	  	end;
	  end;
end.

