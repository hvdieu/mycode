Uses math;
Const
	inp = 'VOSEXP.INP';
	out = 'VOSEXP.OUT';
	maxn = 20010;

Var
	n,a,b,c,oo,i : longint;
	t : array [1..maxn] of qword;
	d,base,res : qword;

function mu(a,b : qword) : longint;
	var temp : qword;
begin
	if (b=0) then
	 begin
	  	if a=0 then exit(0);
	  	exit(1);
	 end;
	if (b=1) then exit(a mod oo);
	temp := mu(a,b div 2);
	temp := (temp*temp) mod oo;
	if b mod 2=0 then exit(temp)
	 else exit((temp*a) mod oo);
end;

procedure sub1();
	var i,j : longint;
begin
	res := 0;
	for i := 1 to n do
	 res := (res+mu(base,t[i])) mod oo;
	writeln(res);
end;

procedure swap(var xx,yy : qword);
	var temp : qword;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint);
	var i,j : longint;
		k : qword;
begin
	if l >= h then exit;
	i := l; j := h; k := t[l+random(h-l+1)];
	repeat
		while t[i] < k do inc(i);
		while t[j] > k do dec(j);
		if i <= j then
		 begin
		 	swap(t[i],t[j]);
		 	inc(i); dec(j);
		 end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure sub2;
	var i,j : longint;
		sum,x : qword;
begin
	sort(1,n);
	res := 0;
	i := n;
	sum := 0;
	while i > 0 do
	  begin
	  	j := i;
	  	while (j>0) and (t[j-1]=t[i]) do dec(j);
	  	x := mu(base,t[i]-t[j-1]);
	  	sum := (x*(sum+i-j+1)) mod oo;
	  	i := j-1;
 	  end;
 	writeln(sum);
end;

begin
	assign(input,inp) ;reset(input);
	assign(output,out); rewrite(output);
	readln(n,base,a,b,c,d,oo);
	t[1] := a;
	base := base mod oo;
	for i := 2 to n do t[i] := (t[i-1]*b+c) mod d;
	//if n <= 100000 then sub1;
    sub2;
end.
