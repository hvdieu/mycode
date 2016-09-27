{$INLINE ON}
{$MODE OBJFPC}
Uses math;
Const
	inp = '';
	out = '';
	maxn = 100001;

Var
	n,i,q,u,v,k,l,r : longint;
	a,id,b : array [1..maxn] of longint;
	t : array [1..20,1..maxn] of longint;

procedure swap(var xx,yy : longint); inline;
    var temp : longint;
begin
    temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint);
	var i,j,k : longint;
begin
	if l >= h then exit;
	i := l; j := h; k := a[l+random(h-l+1)];
	repeat
		while a[i] < k do inc(i);
		while a[j] > k do dec(j);
		if i <= j then
		  begin
		  	swap(a[i],a[j]);
		  	swap(id[i],id[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure merge(k,l,r : longint);
	var i,j,mid,dem : longint;
begin
	mid := (l+r) div 2; dem := l-1;
	i := l; j := mid+1;
	repeat
		inc(dem);
		if (i>mid) and (j>r) then break;
		if (i > mid) or ((j<=r) and (t[k+1,j]<t[k+1,i])) then
		  begin
		    t[k,dem] := t[k+1,j];
		    inc(j);
		  end
		else
		  begin
		   	t[k,dem] := t[k+1,i];
		   	inc(i);
		   end;
	until false;
end;

procedure init(i,l,r : longint);
	var mid : longint;
begin
	if l=r then
	  begin
	  	t[i,l] := id[l];
	  	exit;
	  end;
	mid := (l+r) div 2;
	init(i+1,l,mid); init(i+1,mid+1,r);
	merge(i,l,r);
end;

function find(i,d,c,key : longint) : longint; inline;
	var mid,ans,dd : longint;
begin
	ans := d-1; dd := d;
	while d <= c do
	  begin
	  	mid := (d+c) div 2;
	  	if t[i,mid] <= key then
	  	  begin
	  	  	ans := mid; d := mid+1
	  	  end
	  	else c := mid-1;
	  end;
    exit(ans-dd+1);
end;

function get(i,l,r,u,v,k : longint) : longint;
	var mid,x : longint;
begin
	if l=r then exit(id[l]);
	mid := (l+r) div 2;
	x := find(i+1,l,mid,v)-find(i+1,l,mid,u-1);
	if x>=k then exit(get(i+1,l,mid,u,v,k))
	 else exit(get(i+1,mid+1,r,u,v,k-x));
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do
    begin
      read(a[i]);
      id[i] := i;
      b[i] := a[i];
    end;
	sort(1,n);
	init(1,1,n);
	readln(q);
	while q > 0 do
	   begin
         dec(q);
	   	 readln(l,r,k);
         u := get(1,1,n,l,r,k);
	   	 writeln(b[u]);
	   end;
end.


