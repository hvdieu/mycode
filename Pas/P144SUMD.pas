Uses math;
Const
	inp = 'asd.inp';
	out = 'asd.out';
	maxn = 4001;

Var
	n,i,res,kq : longint;
	a,b,id : array [1..maxn] of longint;
	dd : array [1..maxn,1..maxn] of boolean;

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
	k1 := b[k]; k2 := id[k];
	repeat
		while (b[i]<k1) or ((b[i]=k1) and (id[i]<k2)) do inc(i);
		while (b[j]>k1) or ((b[j]=k1) and (id[j]>k2)) do dec(j);
		if i <= j then
		  begin
		  	swap(b[i],b[j]);
		  	swap(id[i],id[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

function find(d,c,k1,k2 : longint) : longint;
	var mid,ans : longint;
begin
	ans := 0;
	while d <= c do
	   begin
	   	 mid := (d+c) shr 1;
	   	 if (b[mid]=k1) then
	   	   begin
	   	      if id[mid]>k2 then
	   	        begin
	   	        	ans := id[mid]; c := mid-1;
	   	        end
	   	      else d := mid+1;
	   	   end
	   	 else if b[mid]>k1 then c := mid-1
	   	  else d := mid+1;
	   end;
	exit(ans);
end;

procedure main;
	var i,j,x,v,u : longint;
		t : integer;
begin
	for i := 1 to n do
	   begin
	   	 b[i] := a[i];
	   	 id[i] := i;
	   end;
	sort(1,n);
	for i := 1 to n-1 do
	  for j := i+1 to n do
	   if dd[i,j]=false then
	     begin
            dd[i,j] := true;
	     	x := a[j]-a[i]; kq := 2;
	     	v := j; t := -1;
	     	repeat
	     		u := find(1,n,a[v]+t*x,v);
	     		if u=0 then break;
	     		dd[v,u] := true;
	     		inc(kq); t := -1*t; v := u;
	     	until false;
	     	res := max(res,kq);
	     end;
    writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do read(a[i]);
	main;
end.

