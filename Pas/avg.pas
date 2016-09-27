Uses math;
Const
	inp = 'test.out';
	out = 'avg.out';
	maxn = 1001;

Var
	ntest,n,res,i : longint;
	a,b : array [1..maxn] of longint;

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
		while (a[i]<k1) or ((a[i]=k1) and (b[i]<k2)) do inc(i);
		while (a[j]>k1) or ((a[j]=k1) and (b[j]>k2)) do dec(j);
		if i <= j then
		   begin
		   	   swap(a[i],a[j]); swap(b[i],b[j]);
		   	   inc(i); dec(j);
		   end;
	until i > j;
	sort(l,j); sort(i,h);
end;

function find1(d,c,k1,k2 : longint) : longint;
	var mid,ans : longint;
begin
	ans := 0;
	while d <= c do
	   begin
	   	   mid := (d+c) shr 1;
	   	   if a[mid]=k1 then
	   	     begin
	   	     	if b[mid] < k2 then
	   	     	  begin
	   	     	  	ans := mid; d := mid+1
	   	     	  end
	   	     	else c := mid-1;
	   	     end
	   	   else if a[mid] > k1 then c := mid-1
	   	    else d := mid+1;
	   end;
	exit(ans);
end;

function find2(d,c,k1 : longint) : longint;
	var mid,ans : longint;
begin
	ans := 0;
	while d <= c do
	   begin
	   	   mid := (d+c) shr 1;
	   	   if a[mid]=k1 then
	   	     begin
	   	     	ans := mid; c := mid-1;
	   	     end
	   	   else if a[mid] < k1 then d := mid+1
	   	    else c := mid-1;
	   end;
	exit(ans);
end;

function find3(d,c,k1,k2 : longint) : longint;
	var mid,ans : longint;
begin
	ans := 0;
	while d <= c do
	  begin
	  	mid := (d+c) shr 1;
	  	if a[mid]=k1 then
	  	  begin
	  	  	if b[mid]>k2 then
	  	  	  begin
	  	  	  	ans := mid; c := mid-1
	  	  	  end
	  	  	else d := mid+1;
	  	  end
	  	else if a[mid]<k1 then d := mid+1
	  	 else c := mid-1;
	  end;
	exit(ans);
end;

function find4(d,c,k1 : longint) : longint;
	var mid,ans : longint;
begin
	ans := 0;
	while d <= c do
	   begin
	   	   mid := (d+c) shr 1;
	   	   if (a[mid]=k1) then
	   	     begin
	   	     	ans := mid; d := mid+1;
	   	     end
	   	   else if a[mid] < k1 then d := mid+1
	   	    else c := mid-1;
	   end;
	exit(ans);
end;

procedure main;
	var i,j,x,k,u,v : longint;
begin
	sort(1,n); res := 0;
	for k := 2 to n-1 do
	  for j := k+1 to n do
	   if (2*a[k] >= a[j]) then
	   begin
	   	   x := 2*a[k]-a[j];
	   	   if (b[j] > b[k]) then
	   	     begin
	   	  		v := find1(1,k-1,x,b[k]);
	   	  		u := find2(1,k-1,x);
	   	  		if (u<>0) and (v<>0) then res := res + v-u+1;
	   	     end
	   	   else begin
	   	   		u := find3(1,k-1,x,b[k]);
	   	   		v := find4(1,k-1,x);
	   	   		if (u<>0) and (v<>0) then res := res + v-u+1;
	   	   end;
	   end;
	writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
   //readln(ntest);
    ntest := 1; n := 20;
	while ntest > 0 do
	   begin
          dec(ntest);
	   	//  readln(n);
	   	  for i := 1 to n do
	   	    begin
	   	       read(a[i]);
	   	       b[i] := i;
	   	    end;
	   	  main;
	   end;
end.
