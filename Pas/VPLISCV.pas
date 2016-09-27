Uses math;
Const
	inp = 'VPLISCV.INP';
	out = 'VPLISCV.OU1';
	maxn = 5001;
	oo = 1000000007;

Type
	pnode = ^tnode;
	tnode = record
		 key : longint;
		 left,right,cha : pnode;
	end;

Var
	ntest,n,i,m,maxlength : longint;
	a,f,id,b : array [1..maxn] of longint;
    ll : array [1..maxn,0..maxn] of longint;
	dd,check : array [1..maxn,1..maxn] of boolean;
    g : array [1..maxn,1..maxn] of longint;
	root : array [1..maxn,1..maxn] of pnode;
	nilt : pnode;
	kq : longint;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint);
	var i,j,k : longint;
begin
	if l >= h then exit;
	i := l; j := h; k := b[l+random(h-l+1)];
	repeat
		while b[i] < k do inc(i);
		while b[j] > k do dec(j);
		if i <= j then
		  begin
		  	swap(b[i],b[j]);
		  	swap(id[i],id[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure cnt(i,j : pnode; ok : boolean);
begin
	j^.cha := i;
	if ok then i^.left := j else i^.right := j;
end;

procedure uptree(i : PNode);
	var p,pp,j : PNode;
begin
	p := i^.cha; pp := p^.cha;
	if p^.left=i then
	  begin
	    j := i^.right;
	  	cnt(i,p,false);
	  	cnt(p,j,true);
	  end
	else begin
		j := i^.left;
		cnt(i,p,true);
		cnt(p,j,false);
	end;
	cnt(pp,i,pp^.left=p);
end;

procedure splay(i : Pnode);
	var p,pp : pnode;
begin
	while i^.cha <> nilt do
	  begin
	  	 p := i^.cha; pp := p^.cha;
	  	 if pp<>nilt then
	  	   begin
	  	   	 if (pp^.left=p) = (p^.left=i) then uptree(p)
	  	   	  else uptree(i);
	  	   end;
	  	 uptree(i);
	  end;
end;

procedure add(var root : pnode;u : longint);
	var j,i : pnode;
begin
	new(j); j^.key := u; j^.left := nilt; j^.right := nilt; j^.cha := nilt;
	if root=nilt then
	  begin
	  	root := j;
	  	exit;
	  end;
	i := root;
	repeat
		if i^.key = u then exit;
		if i^.key > u then
		  begin
		  	if i^.left=nilt then
		  	  begin
		  	  	cnt(i,j,true);
                splay(j); root := j;
                exit;
		  	  end;
		  	i := i^.left;
		  end
		else begin
			if i^.right = nilt then
			  begin
			  	cnt(i,j,false);
                splay(j); root := j;
                exit;
			  end;
			i := i^.right;
		end;
	until false;
end;

function find(var root : pnode; u : longint) : boolean;
	var i : pnode;
begin
	i := root;
	repeat
		if i=nilt then exit(false);
		if i^.key=u then
          begin
              splay(i); root := i;
              exit(true);
          end;
		if i^.key > u then i := i^.left
		 else i := i^.right;
	until false;
end;

procedure init;
	var i,j,dem : longint;
begin
	sort(1,n);
	m := 1; maxlength := 0;
	a[id[1]] := 1;
	for i := 2 to n do
	  begin
	  	if b[i] <> b[i-1] then inc(m);
	  	a[id[i]] := m;
	  end;
    for i := 1 to n do ll[i,0] := 0;
	for i := 1 to m do
	 for j := 1 to i-1 do root[j,i] := nilt;
	for i := 1 to n do
	  begin
	  	f[i] := 1;
	  	for j := 1 to i-1 do
	  	 if a[j]<a[i] then f[i] := max(f[i],f[j]+1);
	  	for j := 1 to i-1 do
	  	 if (a[j]<a[i]) and (f[j]+1=f[i]) then
           add(root[a[j],a[i]],f[i]);
	  	maxlength := max(maxlength,f[i]);
        inc(ll[f[i],0]);
        ll[f[i],ll[f[i],0]] := a[i];
	  end;
	fillchar(check,sizeof(check),false);
end;

function tinh(i,j : longint) : longint;
	var ii : longint;
        res : int64;
     ok : boolean;
begin
	if check[i,j] then exit(g[i,j]);
	if j=1 then
	  begin
	  	g[i,j] := 1; check[i,j] := true; exit(1);
	  end;
	res := 0;
	for ii := 1 to ll[j-1,0] do
    if (ll[j-1,ii]<i) and find(root[ll[j-1,ii],i],j) then
      begin
	   	  res := (res+tinh(ll[j-1,ii],j-1)) mod oo;
      end;
	check[i,j] := true;
	g[i,j] := res;
	exit(res);
end;

procedure main;
    var i,j : longint;
begin
    kq := 0;
	for i := ll[maxlength,0] downto 1 do
	  if (check[ll[maxlength,i],maxlength]=false) then
	   kq := (kq+tinh(a[i],f[i])) mod oo;
	writeln(kq);
end;

procedure doc;
    var i,j : longint;
begin
    readln(n);
    for i := 1 to n do
      begin
          read(b[i]); id[i] := i;
      end;
end;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
	readln(ntest);
	new(nilt); nilt^.key := 0; nilt^.cha := nilt; nilt^.left := nilt; nilt^.right := nilt;
	while ntest > 0 do
	  begin
	  	dec(ntest);
        doc;
	  	init;
        main;
	  end;
end.

