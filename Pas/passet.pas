Uses math;
const
	inp = 'PASSET.INP';
	out = 'PASSET.OUT';

Type
	pnode = ^tnode;
	tnode = record
		cha,left,right : pnode;
		key : longint;
	end;

Var
	kind,x,dem,n : longint;
	nilt,root : pnode;
    rong : tnode;

procedure cnt(i,j : pnode;ok : boolean);
begin
	j^.cha := i;
	if ok then i^.left := j
	  else i^.right := j;
end;

function find(x : longint) : pnode;
	var i : pnode;
begin
	i := root;
	repeat
		if i=nilt then exit(nilt);
		if x=i^.key then exit(i);
		if x < i^.key then i := i^.left
		 else i := i^.right;
	until false;
end;

procedure tao(var i : pnode);
begin
	new(i); i^.cha := nilt; i^.left := nilt; i^.right := nilt;
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
end;

procedure splay(i : pnode);
	var p,pp : pnode;
begin
	while i^.cha <> nilt do
	   begin
	   	  p := i^.cha; pp := p^.cha;
	   	  if pp <> nilt then
	   	    begin
	   	    	if ((pp^.left=p)=(p^.left=i)) then uptree(p)
	   	    	  else uptree(i);
	   	    end;
	   	  uptree(i);
	   end;
    root := i;
end;

procedure add(x : longint);
	var i,j : pnode;
begin
	if root = nilt then
	   begin
          inc(n);
	   	  tao(root); root^.key := x; exit;
	   end;
    i := find(x);
    if i<>nilt then exit;
    inc(n);
	i := root; tao(j); j^.key := x;
	repeat
		if i^.key >= x then
		  begin
		  	 if i^.left=nilt then
		  	   begin
		  	     cnt(i,j,true);
		  	     splay(j);
                 exit;
		  	   end else i := i^.left;
		  end
		else begin
			if i^.right=nilt then
			   begin
			     cnt(i,j,false);
			     splay(j);
                 exit;
			   end else i := i^.right;
		end;
	until false;
end;

function ml(i : pnode) : pnode;
begin
	while i^.left <> nilt do
      i := i^.left;
	exit(i);
end;

function mr(i : pnode) : pnode;
begin
	while i^.right <> nilt do i := i^.right;
	exit(i);
end;

procedure delete(x : longint);
	var i,j,p : pnode;
begin
    if root=nilt then exit;
	i := find(x);
	if i=nilt then exit;
    dec(n);
	if (i^.left<>nilt) and (i^.right<>nilt) then
	  begin
	  	j := mr(i^.left);
        p := j^.cha;
	  	i^.key := j^.key;
        j := nilt;
        splay(i);
	  end
	else begin
        j := nilt;
		if i^.left <> nilt then j := i^.left;
		if i^.right <> nilt then j := i^.right;
		p := i^.cha;
		cnt(p,j,p^.left=i);
		if root=i then root := j;
        i := nilt;
        if j <> nilt then splay(j);
	end;
end;

procedure Succ(x : longint);
	var i : pnode;
		res : longint;
begin
	res := maxlongint;
	i := root;
	repeat
		if i=nilt then break;
		if i^.key > x then
		  begin
		  	 res := min(res,i^.key);
		  	 i := i^.left;
		  end
		else i := i^.right;
	until false;
	if res=maxlongint then writeln('no') else writeln(res);
end;

procedure Succ2(x : longint);
	var i : pnode;
		res : longint;
begin
	i := find(x);
	if i <> nilt then writeln(x)
	 else Succ(x);
end;

procedure Pred(x : longint);
	var i : pnode;
		res : longint;
begin
	res := -maxlongint;
	i := root;
	repeat
		if i=nilt then break;
		if i^.key < x then
		  begin
		  	res := max(res,i^.key);
		  	i := i^.right;
		  end
		else i := i^.left;
	until false;
	if res = -maxlongint then writeln('no') else writeln(res);
end;

procedure Pred2(x : longint);
	var i : pnode;
begin
	i := find(x);
	if i <> nilt then writeln(x)
	  else Pred(x);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	tao(nilt); nilt^.key := -maxlongint;
    root := nilt;
	repeat
		read(kind); inc(dem);
		case kind of
		0 : exit;
		1 : begin read(x); add(x); end;
		2 : begin read(x); delete(x); end;
		3 : if root=nilt then writeln('empty') else writeln(ml(root)^.key);
		4 : if root=nilt then writeln('empty') else writeln(mr(root)^.key);
		5 : begin read(x); if root=nilt then writeln('empty') else Succ(x); end;
		6 : begin read(x); if root=nilt then writeln('empty') else Succ2(x); end;
		7 : begin read(x); if root=nilt then writeln('empty') else Pred(x); end;
		8 : begin read(x); if root=nilt then writeln('empty') else Pred2(x); end;
		end;
	until false;
end.
