{$MODE OBJFPC}
Uses math;
Const
	inp = '';
	out = '';
	maxn = 100001;

Type
	pnode = ^tnode;
	tnode = record
		cha,left,right : pnode;
		key : longint;
		k2,k1 : int64;
	end;

Var
	n,m,i,u,v,j,x : longint;
	t : array [1..maxn] of pnode;
	kind : char;
	nilt : pnode;

procedure init;

	var i,j : longint;
begin
    new(nilt); nilt^.k1 := 0; nilt^.k2 := 0;
    for i := 1 to n do t[i] := nilt;
end;

procedure tao(var i : pnode);
begin
	new(i); i^.left := nilt; i^.right := nilt; i^.cha := nilt;
end;

procedure cnt(i,j : pnode; ok : boolean);
begin
	j^.cha := i;
	if ok then i^.left := j else i^.right := j;
end;

procedure update(i : pnode);
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
	update(p); update(i);
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

function find(root : pnode; u : longint) : pnode;
	var i : pnode;
begin
	i := root;
	repeat
		if i^.key=u then exit(i);
		if i^.key>u then
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
           update(i);
           i := i^.cha;
         end;
      end
    else begin
        inc(i^.k1,x);
        j := i;
        while i^.cha <> nilt do
         begin
           update(i);
           i := i^.cha;
         end;
    end;
    splay(j);
	root := j;
end;

procedure update1(i,j,x : longint);
begin
	while i <= n do
	  begin
	  	 Insert(t[i],j,x);
	  	 inc(i,i and (-i));
	  end;
end;

function sum(var root : pnode;u : longint) : int64;
	var i,j : pnode;
		s : int64;
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


function Get(i,u,v : longint) : int64;
	var s : int64;
		r1,r2,r3 : pnode;
begin
	s := 0;
	while i > 0 do
	  begin
	  	 s := s + sum(t[i],v)-sum(t[i],u-1);
	  	 dec(i,i and (-i));
	  end;
	exit(s);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m);
	init;
	while m > 0 do
	  begin
         dec(m);
	  	 read(kind);
	  	 if kind = 'S' then
	  	   begin
	  	   	 readln(u,v,x);
	  	   	 update1(u,v,x);
	  	   end
	  	else begin
	  		readln(u,v,i,j);
            writeln(get(i,v,j)-get(u-1,v,j));
	  	end;
	  end;
end.

