Uses math;
Const
	inp = 'QMAX4.INP';
	out = 'QMAX4.OUT';

Type
	Pnode = ^Tnode;
	Tnode = record
		con,k1,k2 : longint;
		cha,left,right : Pnode;
	end;

Var
	x,y,n,sl : longint;
	nilt,root,r1,r2,r3 : pnode;
	ch,sp : char;

procedure update(i : pnode);
begin
	i^.con := (i^.left)^.con+(i^.right)^.con+1;
	i^.k2 := max((i^.left)^.k2,(i^.right)^.k2);
	i^.k2 := max(i^.k2,i^.k1);
end;

procedure cnt(i,j : pnode; ok : boolean);
begin
	j^.cha := i;
	if ok then i^.left := j else i^.right := j;
end;

procedure tao(var i : pnode);
begin
	new(i); i^.cha := nilt; i^.left := nilt; i^.right := nilt;
	i^.con := 1;
end;

procedure uptree(i : pnode);
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

procedure splay(i : pnode);
	var p,pp,j : pnode;
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
    root := i;
end;

function find(i : pnode;u : longint) : pnode;
begin
	repeat
		if (i^.left)^.con+1=u then exit(i);
		if (i^.left)^.con>=u then i := i^.left
		  else if i^.right=nilt then exit(i)
          else
          begin
		  	u := u-(i^.left)^.con-1;
		  	i := i^.right;
		  end;
	until false;
end;

procedure Cut(root : pnode; u : longint;var r1,r2 : pnode);
	var i,j : pnode;
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
	i := find(root,u);
	splay(i);
    j :=i^.right;
	j^.cha := nilt; i^.right := nilt;
	update(i);
	r1 := i; r2 := j;
end;

procedure Ups(i : pnode);
	var j : pnode;
begin
	j := i;
    while j <> nilt do
	  begin
	  	update(j);
	  	j := j^.cha;
	  end;
	splay(i);
    root := i;
end;

function Union(r1,r2 : pnode) : pnode;
begin
	if r1=nilt then exit(r2);
	while r1^.right <> nilt do r1 := r1^.right;
    splay(r1);
	cnt(r1,r2,false);
    update(r1);
	exit(r1);
end;

procedure Up(i : pnode);
begin
	while i <> nilt do
	  begin
	  	update(i);
	  	i := i^.cha;
	  end;
end;

procedure Insert(u,x : longint);
	var i,j,p : pnode;
begin
	if root=nilt then
	   begin
	   	 tao(root); root^.k1 := x; root^.k2 := x;
	   	 exit;
	   end;
	tao(j); j^.k1 := x; j^.k2 := x;
	if u=root^.con+1 then
     begin
        i := root;
        while i^.right <> nilt do i := i^.right;
        cnt(i,j,false)
     end
	 else
     begin
       i := find(root,u);
       if i^.left=nilt then cnt(i,j,true)
      else
	   begin
	   	 i := i^.left;
	   	 while i^.right <> nilt do i := i^.right;
	   	 cnt(i,j,false);
	   end;
     end;
    Ups(i);
end;

procedure Swap(u,v : longint); inline;
	var i,j : pnode;
		temp : longint;
begin
	if u=v then exit;
	i := find(root,u); j := find(root,v);
	temp := i^.k1; i^.k1 := j^.k1; j^.k1 := temp;
	Ups(i); Ups(j);
end;

procedure Delete(u : longint); inline;
	var i,j,p : pnode;
begin
	i := find(root,u);
	if (i^.left<>nilt) and (i^.right<>nilt) then
	   begin
	   	  j := i^.left;
	   	  while j^.right<>nilt do j := j^.right;
	   	  i^.k1 := j^.k1;
          i := j;
	   end;
    p := i^.cha; j := nilt;
    if i^.left <> nilt then j := i^.left
      else j := i^.right;
    cnt(p,j,p^.left=i);
    if root=i then root := j;
    if j<>nilt then Ups(j)
     else Ups(p);
end;

procedure Query(u,v : longint);
	var i,j : pnode;
begin
	Cut(root,v,r1,r2);
	Cut(r1,u-1,r1,r3);
   writeln(r3^.k2);
	r1 := Union(r1,r3);
	root := Union(r1,r2);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	new(nilt); nilt^.cha := nilt; nilt^.left := nilt; nilt^.right := nilt;
	nilt^.k1 := -maxlongint; nilt^.k2 := -maxlongint; nilt^.con := 0;
	root := nilt;
	while n > 0 do
	  begin
	  	dec(n);
	  	read(ch,sp);
	  	case ch of
	  	'I' : begin inc(sl); readln(x,y); Insert(y,x);  end;
	  	'S' : begin readln(x,y); Swap(x,y); end;
	  	'D' : begin dec(sl); readln(x); Delete(x); end;
	  	'Q' : begin readln(x,y); Query(x,y); end;
	  	end;
	  end;
end.

