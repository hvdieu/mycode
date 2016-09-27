Uses math;
Const 
	inp = '';
	out = '';
	maxn = 1000001;

Var
	n,l,d,i : longint;
	top1,bot1,top2,bot2 : longint;
	a,p,q : array [1..maxn] of longint;
	res : int64;

procedure main;
	var i,j : longint;
begin
	bot1 := 1; bot2 := 1;
	j := 1;
	for i := 1 to n do 
	  begin
	  	while (top1>=bot1) and (a[p[top1]]>=a[i]) do dec(top1);
	  	inc(top1); p[top1] := i;
	  	while (top2>=bot2) and (a[q[bot2]]<=a[i]) do dec(top2);
	  	inc(top2); q[top2] := i;
	  	repeat
	  		if a[q[bot2]]-a[p[bot1]] > d then 
	  		  begin
	  		    while (top1>=bot1) and (p[bot1]<=j) do inc(bot1);
	  		    while (top2>=bot2) and (q[bot2]<=j) do inc(bot2);
	  		    inc(j);
	  		  end
	  		else break;
	  	until false;
	  	if i-j+1 >= l then res := res + i-j+1-l+1;
	  end;
	writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,l,d); inc(l);
	for i := 1 to n do read(a[i]);
	main;
end.
