{$MODE OBJFPC}
{$INLINE ON}
Uses math;
Const
	inp = 'SHUFFLEK.INP';
	out = 'SHUFFLEK.OUT';
	maxn = 200010;

Type
	pnode = ^tnode;
	tnode = record
	key,con,c1 : longint;
	cha,left,right : pnode;
	end;

Var
	n,ntest,k,m,res,top : longint;
	root,nilt,r1,r2,r3 : pnode;
	a,b,id,t,c : array [0..maxn] of longint;

procedure cnt(i,j : pnode;ok : boolean); inline;
begin
	j^.cha := i;
	if ok then i^.left := j else i^.right := j;
end;

procedure tao(var i : pnode); inline;
begin
	new(i); i^.left := nilt; i^.right := nilt; i^.cha := nilt;
end;

procedure update(i : pnode); inline;
begin
	i^.con := i^.left^.con+i^.right^.con+i^.c1;
end;

procedure uptree(i : pnode); inline;
	var j,p,pp : pnode;
begin
	p := i^.cha; pp := p^.cha;
	if p^.left=i then
	   begin
	   	  j := i^.right;
	   	  cnt(i,p,false);
	   	  cnt(p,j,true)
	   end
	else begin
		j := i^.left;
		cnt(i,p,true);
		cnt(p,j,false);
	end;
	cnt(pp,i,pp^.left=p);
	update(p); update(i);
end;

procedure splay(i : pnode); inline;
	var p,pp : pnode;
begin
	while i^.cha <> nilt do
	   begin
	   	  p := i^.cha; pp := p^.cha;
	   	  if pp <> nilt then
	   	    begin
	   	    	if (p^.left=i)=(pp^.left=p) then uptree(p)
	   	    	  else uptree(i);
	   	    end;
	   	  uptree(i);
	   end;
end;

procedure ups(i : pnode); inline;
	var j : pnode;
begin
	j := i;
	while j <> nilt do
	  begin
	  	update(j);
	  	j := j^.cha;
	  end;
	splay(i);
end;

function find(root : pnode; var u : longint) : pnode; inline;
	var i : pnode;
begin
	i := root;
	repeat
		if i^.left^.con+i^.c1=u then
         begin
           u := 0;
           exit(i);
         end;
		if (i^.left^.con < u) and (i^.left^.con+i^.c1>u) then
         begin
           u := u-i^.left^.con;
           exit(i);
         end;
		if i^.left^.con >= u then i := i^.left
		 else begin
		 	u := u-i^.left^.con-i^.c1;
		 	i := i^.right;
		 end;
	until false;
end;

procedure Cut(root : pnode; v : longint; var r1,r2 : pnode); inline;
	var i,j,p : pnode;
        x : longint;
begin
	i := find(root,v);
	if v>0 then
	   begin
	   	  tao(j); j^.c1 := v;j^.key := i^.key-i^.c1+j^.c1;
	   	  update(j);
	   	  i^.c1 := i^.c1-j^.c1; update(i);
	   	  if i^.left=nilt then cnt(i,j,true)
	   	   else begin
	   	   	   i := i^.left;
	   	   	   while i^.right <> nilt do i := i^.right;
	   	   	   cnt(i,j,false);
	   	   end;
	   	  i := j;
	   end;
	Ups(i);
	j := i^.right;
	i^.right := nilt; j^.cha := nilt;
	update(i);
	r1 := i; r2 := j;
end;

function Union(r1,r2 : pnode) : pnode; inline;
begin
	while r1^.right <> nilt do r1 := r1^.right;
	splay(r1);
	cnt(r1,r2,false);
	update(r1);
	exit(r1);
end;

procedure Query(k : longint); inline;
	var i,j : pnode;
		u,v : longint;
begin
	if (abs(k)=n div 2) or (k=0) then exit;
	u := n div 2-abs(k)+1;
	v := n div 2+abs(k);
	Cut(root,v,r1,r3);
	Cut(r1,u-1,r1,r2);
	r1 := Union(r1,r3);
	if k > 0 then root := Union(r2,r1)
	 else root := Union(r1,r2);
end;

procedure inn2(i : pnode);
begin
	if i^.left <> nilt then inn2(i^.left);
	inc(m); a[m] := i^.key; b[m] := i^.c1;
	if i^.right <> nilt then inn2(i^.right);
end;

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
		while (a[i]<k) do inc(i);
		while (a[j]>k) do dec(j);
		if i <= j then
		  begin
		  	swap(a[i],a[j]);
		  	swap(id[i],id[j]);
		  	inc(i); dec(j);
		  end;
	until i > j;
	sort(l,j); sort(i,h);
end;

procedure up(i,val : longint); inline;
begin
	while i <= m do
	  begin
	  	t[i] := max(t[i],val);
	  	inc(i,i and (-i));
	  end;
end;

function get(i : longint) : longint; inline;
	var s : longint;
begin
	s := 0;
	while i > 0 do
	   begin
	   	  s := max(t[i],s);
	   	  dec(i,i and (-i));
	   end;
	exit(s);
end;

procedure main; inline;
	var i,j,res,x : longint;
begin
	inn2(root);
	for i := 1 to m do id[i] := i;
	sort(1,m);
	for i := 1 to m do c[id[i]] := i;
	res := 0;
	for i := 1 to m do
	  begin
	  	 x := get(c[i])+b[i];
	  	 res := max(res,x);
	  	 up(c[i],x);
	  end;
	writeln(n-res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,ntest);
	n := n*2;
	new(nilt); nilt^.con := 0;
	tao(root); root^.key := n; root^.con := n; root^.c1 := n;
	while ntest > 0 do
	  begin
	  	dec(ntest);
	  	read(k);
	  	Query(k);
      {  m := 0;
        inn2(root); }
	  end;
	main;
end.
