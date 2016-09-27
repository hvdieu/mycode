Uses math;
Const
	inp = 'fourpos.inp';
	out = 'fourpos.out';
	maxn = 1001;

Type
	pnode = ^tnode;
	tnode = record
		 cha,left,right : pnode;
		 key,k1,k2 : longint;
	end;

Var
	a,b,c,d,b1,c1,d1,pos : array [1..maxn] of longint;
	t : array [1..maxn] of pnode;
	n,i : longint;
	res : int64;
	nilt : pnode;

procedure swap(var xx,yy : longint);
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
		while a[i]<k do inc(i);
		while a[j]>k do dec(j);
		if i <= j then
		  begin
		  	swap(a[i],a[j]); swap(b[i],b[j]); swap(c[i],c[j]); swap(d[i],d[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure cnt(i,j : pnode; ok : boolean);
begin
	j^.cha := i;
	if ok then i^.left := j
	  else i^.right := j;
end;

procedure tao(var i : pnode);
begin
	new(i); i^.cha := nilt; i^.left := nilt; i^.right := nilt;
	i^.k1 := 0;
	i^.k2 := 0;
end;

procedure cc(i : pnode);
begin
	i^.k2 := i^.left^.k2+i^.right^.k2+i^.k1;
end;

procedure uptree(i : pnode);
	var p,pp,j : pnode;
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
	cc(p); cc(i);
end;

procedure splay(i : pnode);
	var p,pp : pnode;
begin
    if i=nilt then exit;
	while i^.cha <> nilt do
	  begin
	  	 p := i^.cha; pp := p^.cha;
	  	 if pp <> nilt then
	  	   begin
	  	   	  if (pp^.left=p) = (p^.left=i) then uptree(p)
	  	   	   else uptree(i);
	  	   end;
	  	 uptree(i);
	  end;
end;

procedure khoitao(i : longint);
begin
	while i <= n do
	  begin
	  	t[i] := nilt;
	  	inc(i,i and (-i));
	  end;
end;

procedure khoitao2(i : longint);
begin
	while i > 0 do
	  begin
	  	t[i] := nilt;
	  	dec(i,i and (-i));
	  end;
end;

procedure merge(l,r : longint);
	var k,i,j,mid : longint;
begin
	mid := (l+r) shr 1;
	i := l; j := mid+1; k := 0;
	repeat
		if (i>mid) and (j>r) then break;
		if (j>r) or ((i<=mid) and (j<=r) and (b[i]<b[j])) then
		  begin
		  	inc(k); b1[k] := b[i]; c1[k] := c[i]; d1[k] := d[i];
            inc(i);
		  end
		else begin
			inc(k); b1[k] := b[j]; c1[k] := c[j]; d1[k] := d[j];
            inc(j);
		end;
	until false;
	for i := l to r do
	  begin
	     b[i] := b1[i-l+1]; c[i] := c1[i-l+1]; d[i] := d1[i-l+1];
	  end;
end;

function find(root : pnode; u : longint) : pnode;
	var i : pnode;
begin
	i := root;
	repeat
		if i^.key=u then exit(i);
		if i^.key > u then
		  begin
		  	if i^.left=nilt then exit(i)
		  	 else i := i^.left;
		  end
		else begin
			if i^.right=nilt then exit(i)
			 else i := i^.right;
		end;
	until false;
end;

procedure Insert(var root : pnode; u,x : longint);
	var i,j : pnode;
begin
	if root=nilt then
	  begin
	  	tao(root); root^.k1 := x; root^.k2 := x;
        root^.key := u; exit;
	  end;
	i := find(root,u);
    if i^.key<>u then
      begin
         tao(j); j^.key := u; j^.k1 := x; j^.k2 := x;
         if i^.key > j^.key then cnt(i,j,true)
          else cnt(i,j,false);
         while i^.cha <> nilt do
         begin
           cc(i);
           i := i^.cha;
         end;
      end
    else begin
        inc(i^.k1,x);
        j := i;
        while i^.cha <> nilt do
         begin
           cc(i);
           i := i^.cha;
         end;
    end;
    splay(j);
	root := j;
end;

procedure update(i,j,val : longint);
	var jj : longint;
begin
	while i <= n do
	  begin
	  	Insert(t[i],j,val);
	  	inc(i,i and (-i));
	  end;
end;

function sum(var root : pnode;u : longint) : longint;
	var i,j : pnode;
		s : longint;
begin
	i := root; s := 0; j := nilt;
	repeat
		if i=nilt then break;
		if i^.key <= u then s := s+i^.k1;
		if i^.key <= u then
		  begin
		  	s := s+i^.left^.k2;
		  	j := i; i := i^.right;
		  end
		else
		 begin
		   j := i;
		   i := i^.left;
		 end;
	until false;
	splay(j); root := j;
	exit(s);
end;

function get(i,j : longint) : longint;
	var s : longint;
begin
	s := 0;
	while (i>0) do
	  begin
	  	s := s+sum(t[i],j);
	  	dec(i,i and (-i));
	  end;
	exit(s);
end;

procedure xep(l,r : longint);
	var i,j,mid,k : longint;
begin
	if l=r then exit;
	mid := (l+r) shr 1;
	xep(l,mid); xep(mid+1,r);
	for i := l to mid do khoitao(c[i]);
	for i := mid+1 to r do khoitao2(c[i]);
	i := l; j := mid+1;
	repeat
		if (j>r) then break;
		if ((i<=mid) and (j<=r) and (b[i]<b[j])) then
		  begin
		  	 update(c[i],d[i],1);
		  	 inc(i);
		  end
		else begin
			res := res+get(c[j],d[j]);
			inc(j);
		end;
	until false;
	merge(l,r);
end;

procedure init;
	var i,j : longint;
begin
	new(nilt); nilt^.key := 0; nilt^.k1 := 0;
    nilt^.k2 := 0;
    for i := 1 to n div 2 do
	  begin
	  	swap(b[i],b[n-i+1]);
	  	swap(d[i],d[n-i+1]);
	  end;
    for i := 1 to n do pos[b[i]] := i;
    for i := 1 to n do b[i] := pos[a[i]];
    for i := 1 to n do pos[c[i]] := i;
    for i := 1 to n do c[i] := pos[a[i]];
    for i := 1 to n do pos[d[i]] := i;
    for i := 1 to n do d[i] := pos[a[i]];

end;

procedure main;
	var i,j : longint;
begin
	init;
//	sort(1,n);
	xep(1,n);
    writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do read(a[i]);
	for i := 1 to n do read(b[i]);
	for i := 1 to n do read(c[i]);
	for i := 1 to n do read(d[i]);
	main;
end.
