Uses math;
Const
	inp = 'CARDS.INP';
	out = 'CARDS.OUT';
	maxn = 100001;

Type
	PNode = ^TNode;
	TNode = record
		key,con : longint;
		cha,left,right : PNode;
	end;

Var
	root,nilT : PNode;
	rong : TNode;
	n,ntest : longint;

procedure cnt(i,j : PNode; ok : boolean);
begin
	if j<> nilt then j^.cha := i;
	if ok then i^.left := j
	 else i^.right := j;
end;

procedure tao(var j : PNode);
begin
	new(j); j^.con := 1; j^.left := nilt; j^.right := nilt;
	j^.cha := nilt;
end;

procedure update(i : Pnode);
	var j : Pnode;
begin
	i^.con := (i^.left)^.con + (i^.right)^.con + 1;
end;

function inn(l,r : longint) : pnode;
	var mid : longint;
		i,j : PNode;
begin
    if l>r then exit(nilt);
    mid := (l+r) div 2;
    tao(i); i^.key := mid;
    j := inn(l,mid-1);
    cnt(i,j,true);
    j := inn(mid+1,r);
    cnt(i,j,false);
    update(i);
    exit(i);
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
	update(p); update(i);
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

function find(root : pnode; u : longint) : pnode;
	var x : pnode;
begin
	x := root;
	repeat
		if (x^.left)^.con + 1 = u then exit(x);
		if (x^.left)^.con+1>u then x := x^.left
		 else begin
		 	u := u-(x^.left)^.con-1;
		 	x := x^.right;
		 	if u=0 then exit(x);
		 end;
	until false;
end;

procedure Cut(root : pnode; u : longint; var r1,r2 : pnode);
	var i,j : longint;
		x : pnode;
begin
	if u=0 then
	  begin
	  	r1 := nilt; r2 := root;
	  	exit;
	  end;
	if u=root^.con then
	  begin
	  	r1 := root; r2 := nilt;
	  	exit;
	  end;
	x := find(root,u);
	splay(x);
	r1 := x; r2 := r1^.right;
	r1^.right := nilt; r2^.cha := nilt;
	update(r1);
end;

procedure Ups(i : Pnode);
	var j : Pnode;
begin
    j := i;
	while (i<>nilt) do
	  begin
	  	update(i);
	  	i := i^.cha;
	  end;
	splay(j);
end;

function Union(r1,r2 : Pnode) : pnode;
	var i,j : longint;
begin
	if r1=nilt then exit(r2);
	while r1^.right <> nilt do r1 := r1^.right;
	cnt(r1,r2,false);
	ups(r1);
	exit(r1);
end;

procedure inn2(i : Pnode);
begin
	if i^.left<>nilt then inn2(i^.left);
	write(i^.key,' ');
	if i^.right<>nilt then inn2(i^.right);
end;

procedure main;
	var i,j,m,u,v : longint;
		r1,r2,r3 : Pnode;
begin
    nilt := @rong;
    nilt^.key := 0; nilt^.con := 0;
	root := inn(1,n);
	while ntest > 0 do
	  begin
        dec(ntest);
	  	readln(i,m,j);
	  	u := i; v := i+m-1;
	  	Cut(root,v,r1,r3);
	  	Cut(r1,u-1,r1,r2);
	  	r1 := Union(r1,r3);
	  	Cut(r1,j-1,r1,r3);
	  	r1 := Union(r1,r2);
	  	root := Union(r1,r3);
	  end;
    inn2(root);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,ntest);
	main;
end.
