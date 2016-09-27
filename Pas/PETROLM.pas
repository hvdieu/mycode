Uses math;
Const
	inp = 'PETROLM.INP';
	out = 'PETROLM.OUT';
	maxn = 4001;
	oo = 1000000000000000000;

Type
	arr = array [0..maxn] of longint;

Var
	n,m : longint;
	a,b,id,kq,vt1,vt2 : arr;
    s : array [0..maxn] of int64;
	f,g : array [0..maxn,0..maxn] of int64;
	res : int64;

procedure nhap;
	var i,j : longint;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do
     begin
       read(a[i]);
       vt1[i] := i;
     end;
	readln(m);
	for i := 1 to m do
     begin
       read(b[i]);
       vt2[i] := i;
     end;
end;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint;var a,vt : arr);
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
            swap(vt[i],vt[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j,a,vt); sort(i,h,a,vt);
end;

procedure main;
	var i,j,x,jj,u : longint;
begin
	sort(1,n,a,vt1); sort(1,m,b,vt2);
	for i := 1 to n do
	  begin
	  	x := maxlongint;
	  	for j := 1 to m do
         if abs(a[i]-b[j]) < x then
           begin
               id[i] := vt2[j];
               x := abs(a[i]-b[j]);
           end;
	  	s[i] := s[i-1]+x;
	  end;
	for i := 0 to m do
	 for j := 0 to n do
      begin
        f[i,j] := oo; g[i,j] := oo;
      end;
	f[0,0] := 0; g[0,0] := 0;
	for j := 1 to n do g[0,j] := 0;
	for i := 1 to m do
	  for j := i to n-m+i do
	   begin
	   	 f[i,j] := g[i-1,j-1]+abs(b[i]-a[j])+s[j-1];
	   	 g[i,j] := min(g[i,j-1],f[i,j]-s[j]);
	   end;
	res := oo;
	for j := 1 to n do
     begin
	   if res > f[m,j]+s[n]-s[j] then
        begin
            u := j;
            res := f[m,j]+s[n]-s[j];
        end;
     end;
	writeln(res);
    for i := n downto u+1 do kq[vt1[i]] := id[i];
    i := m;
    repeat
        if u=0 then break;
        kq[vt1[u]] := vt2[i];
        for j := u-1 downto 0 do
         if f[i,u]=f[i-1,j]+abs(b[i]-a[u])+s[u-1]-s[j] then
          begin
             for jj := j+1 to u-1 do kq[vt1[jj]] := id[jj];
             u := j; dec(i); break;
          end;
    until false;
    for i := 1 to n do write(kq[i],' ');
end;

begin
	nhap;
	main;
end.
