{$INLINE ON}
{$MODE OBJFPC}
Uses math;
Const
	inp = 'NKGSHOW.INP';
	out = 'NKGSHOW.OUT';
	maxn = 100001;

Type
	pnode = ^tnode;
	tnode = record
		key,con,tt : longint;
		cha,left,right : pnode;
	end;

Var
	n,m,u,v,i,kind,dem : longint;
	root,nilt,r1,r2,r3,x : pnode;

procedure cnt(i,j : pnode; ok : boolean); inline;
begin
	j^.cha := i;
	if ok then i^.left := j else i^.right := j;
end;

procedure tao(var i : pnode); inline;
begin
	new(i); i^.cha := nilt; i^.left := nilt; i^.right := nilt; i^.con := 1;
	i^.tt := 0;
end;

procedure update(i : pnode); inline;
begin
	i^.con := i^.left^.con+i^.right^.con+1;
end;

procedure uptree(i : pnode); inline;
	var j,p,pp : pnode;
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

procedure splay(i : pnode); inline;
	var p,pp : pnode;
begin
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

function inn(l,r : longint) : pnode;
	var mid : longint;
		i : pnode;
begin
	if l > r then exit(nilt);
	tao(i); mid := (l+r) div 2; i^.key := mid;
	cnt(i,inn(l,mid-1),true);
	cnt(i,inn(mid+1,r),false);
	update(i);
    exit(i);
end;

procedure down(i : pnode); inline;
	var l,r : pnode;
begin
	if i^.tt = 1 then
	  begin
	    l := i^.left; r := i^.right;
	    cnt(i,l,false); cnt(i,r,true);
	    i^.left^.tt := 1-i^.left^.tt;
	    i^.right^.tt := 1-i^.right^.tt;
	    i^.tt := 0;
	  end;
end;

function find(root : pnode; u : longint) : pnode; inline;
	var i : pnode;
begin
	i := root;
	repeat
		down(i);
		if i^.left^.con+1=u then exit(i);
		if i^.left^.con>=u then i := i^.left
		  else begin
		  	u := u-i^.left^.con-1;
		  	i := i^.right;
		  end;
	until false;
end;

procedure Cut(root : pnode; u : longint; var r1,r2 : pnode); inline;
	var i,j : pnode;
begin
	if u=0 then
      begin
          r1 := nilt; r2 := root; exit;
      end;
	if u=root^.con then
      begin
          r1 := root; r2 := nilt; exit;
      end;
	i := find(root,u);
	splay(i);
	j := i^.right;
	i^.right := nilt; j^.cha := nilt;
	update(i);
	r1 := i; r2 := j;
end;

function Union(r1,r2 : pnode) : pnode; inline;
	var i,j : pnode;
begin
	if r1=nilt then exit(r2);
    down(r1);
    while r1^.right <> nilt do
      begin
          r1 := r1^.right;
          down(r1);
      end;
	splay(r1);
	cnt(r1,r2,false); update(r1);
	exit(r1);
end;

procedure inn2(i : pnode);
begin
    down(i);
    if i^.left <> nilt then inn2(i^.left);
    write(i^.key,' ');
    if i^.right <> nilt then inn2(i^.right);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m);
	new(nilt); nilt^.con := 0; nilt^.cha := nilt;
	root := inn(1,n);
	while m > 0 do
	  begin
	  	 dec(m);
	  	    	read(u,v);
	  	    	if u <> v then
	  	    	   begin
	  	    	   	 Cut(root,v,r1,r3);
     	    	   	 Cut(r1,u-1,r1,r2);
	  	    	   	 r2^.tt := 1-r2^.tt;
	  	    	   	 down(r2);
	  	    	   	 r1 := Union(r1,r2);
	  	    	   	 root := Union(r1,r3);
	  	    	   end;
	  end;
	inn2(root);
end.
