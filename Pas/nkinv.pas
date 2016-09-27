Uses math;
Const
	inp = 'nkinv.inp';
	out = 'nkinv.out';
	maxn = 60001;

Var
	n,i : longint;
	a,b : array [1..maxn] of longint;
	res : int64;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,r : longint);
	var i,j,mid,k : longint;
begin
	if l=r then exit;
	mid := (l+r) shr 1;
	sort(l,mid); sort(mid+1,r);
	i := l; j := mid+1;
    k := 0;
    repeat
       if (i>mid) and (j>r) then break;
       if (i>mid) or ((i<=mid) and (j<=r) and (a[i]>a[j])) then
         begin
             inc(k); b[k] := a[j]; inc(j);
         end
       else
         begin
             inc(k); b[k] := a[i]; inc(i);
             res := res+j-mid-1;
         end;
    until false;
    for i := l to r do a[i] := b[i-l+1];
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do read(a[i]);
	sort(1,n);
	writeln(res);
end.

