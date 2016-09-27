Uses math;
Const
	inp = '';
	out = '';
	maxn = 1000001;

Var
	n,i,x,top : longint;
	a,b,kq,id,p,res : array [1..maxn] of longint;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint);
	var i,j,k,k1,k2 : longint;
begin
	if l >= h then exit;
	i := l; j := h; k := l+random(h-l+1);
	k1 := a[k]; k2 := b[k];
	repeat
		while (a[i]<k1) do inc(i);
		while (a[j]>k1) do dec(j);
		if i <= j then
		  begin
		  	swap(b[i],b[j]);
		  	swap(a[i],a[j]);
		  	swap(id[i],id[j]);
            swap(kq[i],kq[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,x);
	for i := 1 to n do
	  begin
	  	readln(a[i],b[i]);
	  	id[i] := i;
	  	if b[i]=0 then kq[i] := a[i]
	  	 else kq[i] := x-a[i];
	  end;
	sort(1,n);
	for i := 1 to n do
	 if b[i]=0 then
      begin
          inc(top);
          res[id[top]] := kq[i];
      end;
	for i := 1 to n do
	 if b[i]=1 then
       begin
           inc(top);
           res[id[top]] := kq[i];
       end;
    for i := 1 to n do writeln(res[i]);
end.
