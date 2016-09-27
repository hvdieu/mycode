Uses math;
Const
	inp = 'VMSINCOS.INP';
	out = 'VMSINCOS.OUT';
	maxn = 50001;

Type
	arr = array [0..16] of double;
	pnode = ^tnode;
	tnode = record
		cha,left,right : pnode;
		con : longint;
		tt : boolean;
		key,f : double;
		s : arr;
	end;

Var
	n,q,i,u,v : longint;
	a,b : array [1..maxn] of double;
	nilt,root,r1,r2,r3 : pnode;
	c1,c2,c3 : char;
	x,res : double;
	pow : array [0..16] of double;
    ok : boolean;

procedure cnt(i,j : pnode; ok : boolean);
begin
	j^.cha := i;
	if ok then i^.left := j
	  else i^.right := j;
end;

procedure down(i : pnode);
	var l,r : pnode;
		j : longint;
		x : double;
begin
    if i=nilt then exit;
	if i^.tt then
	  begin
	     l := i^.left; r := i^.right;
	     cnt(i,l,false); cnt(i,r,true);
	  	 i^.left^.tt := not i^.left^.tt;
	  	 i^.right^.tt := not i^.right^.tt;
	  	 i^.tt := false;
	  end;
	if i^.f <> 1 then
	  begin
         i^.key := i^.key*i^.f;
         x := 1;
         for j := 0 to 16 do
           begin
               i^.s[j] := i^.s[j]*x;
               x := x*i^.f;
           end;
	  	 i^.left^.f := i^.left^.f*i^.f;
		 i^.right^.f := i^.right^.f*i^.f;
		 i^.f := 1;
	  end;
end;

procedure update(i : pnode);
	var j : longint;
		x : double;
begin
    down(i); down(i^.left); down(i^.right);
	i^.con := i^.left^.con+i^.right^.con+1;
	x := 1;
	for j := 0 to 16 do
	   begin
	   	  i^.s[j] := i^.left^.s[j]+i^.right^.s[j]+x;
	   	  x := x*i^.key;
	   end;
end;

procedure tao(var i : pnode);
begin
	new(i); i^.cha := nilt; i^.left := nilt; i^.right := nilt; i^.con := 1;
	i^.tt := false; i^.f := 1;
end;

procedure uptree(i : pnode);
	var p,pp,j : pnode;
begin
	p := i^.cha; pp := p^.cha;
    down(i); down(i^.left); down(i^.right);
	if p^.left=i then
	   begin
	   	  j := i^.right;
          down(j);
	   	  cnt(i,p,false);
	   	  cnt(p,j,true);
	   end
	else begin
		j := i^.left;
        down(j);
		cnt(i,p,true);
		cnt(p,j,false);
	end;
	cnt(pp,i,pp^.left=p);
	update(p); update(i);
end;

procedure splay(i : pnode);
	var p,pp : pnode;
begin
	while i^.cha <> nilt do
	   begin
	   	  p := i^.cha; pp := p^.cha;
	   	  if pp <> nilt then
	   	    begin
	   	    	if (pp^.left=p)=(p^.left=i) then uptree(p)
	   	    	  else uptree(i);
	   	    end;
	   	  uptree(i);
	   end;
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

function inn(l,r : longint) : pnode;
	var mid : longint;
		i : pnode;
begin
	if l > r then exit(nilt);
	mid := (l+r) shr 1;
	tao(i); i^.key := a[mid];
	cnt(i,inn(l,mid-1),true);
	cnt(i,inn(mid+1,r),false);
	update(i);
	exit(i);
end;

function find(root : pnode; u : longint) : pnode;
    var i : pnode;
begin
	i := root;
	repeat
		down(i);
		if i^.left^.con+1=u then exit(i)
		 else if i^.left^.con >= u then i := i^.left
		  else begin
		  	u := u-i^.left^.con-1;
		  	i := i^.right;
		  end;
	until false;
end;

procedure Cut(root : pnode;u : longint;var r1,r2 : pnode);
	var i,j : pnode;
begin
	if u=0 then
	  begin
	  	r1 := nilt; r2 := root; down(r2); exit;
	  end;
	if u=root^.con then
	  begin
	  	r1 := root; down(r1); r2 := nilt; exit;
	  end;
	i := find(root,u);
	splay(i);
    down(i);
	j := i^.right;
	i^.right := nilt; j^.cha := nilt;
	update(i); down(j);
	r1 := i; r2 := j;
end;

function Union(r1,r2 : pnode) : pnode;
	var i,j,p : pnode;
begin
	if r1=nilt then exit(r2);
	i := r1; down(i);
	while i^.right <> nilt do
	  begin
	  	i := i^.right;
        down(i);
	  end;
	splay(i);
	cnt(i,r2,false); update(i);
	exit(i);
end;

procedure Mul(u,v : longint; x : double);
begin
	Cut(root,v,r1,r3);
	Cut(r1,u-1,r1,r2);
	r2^.f := r2^.f*x;
	down(r2);
	r1 := Union(r1,r2);
	root := Union(r1,r3);
end;


procedure Modify(u : longint; x : double);
    var i : pnode;
begin
	i := find(root,u);
	i^.key := x;
	Ups(i);
end;

procedure Reverse(u,v : longint);
begin
    if u=v then exit;
	Cut(root,v,r1,r3);
	Cut(r1,u-1,r1,r2);
	r2^.tt := not r2^.tt;
	down(r2);
	r1 := Union(r1,r2);
	root := Union(r1,r3);
end;

procedure Query(kind,u,v : longint;x : double);
	var res,ssin,scos : double;
		k : longint;
		a1,a2 : double;
begin
	Cut(root,v,r1,r3);
	Cut(r1,u-1,r1,r2);
    down(r2);
	ssin := 0; scos := 0;
	a1 := 1; a2 := 1;
	for k := 0 to 16 do
	   begin
	   	  if k mod 2=1 then
	   	     begin
	   	     	ssin := ssin+a1*r2^.s[k]/pow[k];
	   	     	a1 := a1*-1;
	   	     end
	   	  else begin
	   	  	scos := scos+a2*r2^.s[k]/pow[k];
	   	  	a2 := a2*-1;
	   	  end;
	   end;
	if kind=0 then res := ssin*cos(x)-scos*sin(x)
	 else res := scos*cos(x)+ssin*sin(x);
    r1 := union(r1,r2);
    root := union(r1,r3);
    writeln(res:0:9);
end;

procedure inn2(i : pnode);
begin
    down(i);
    if i^.left <> nilt then inn2(i^.left);
    inc(n); b[n] := i^.key;
    if i^.right <> nilt then inn2(i^.right);
end;

procedure swap(var xx,yy : double);
    var temp : double;
begin
    temp := xx; xx := yy; yy := temp;
end;

procedure check;
begin
          n := 0;
          inn2(root);
          ok := true;
          for i := 1 to n do
           if a[i] <> b[i] then ok := false;
          if ok then writeln('DUNG') else writeln('SAI');
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do read(a[i]);
	new(nilt);
	for i := 0 to 16 do nilt^.s[i] := 0; nilt^.con := 0;
	root := inn(1,n);
	pow[0] := 1;
	for i := 1 to 16 do pow[i] := pow[i-1]*i;
	readln(q);
	while q > 0 do
	   begin
	   	  dec(q);
	   	  read(c1,c2,c3);
	   	  while c3 <> ' ' do read(c3);
	   	  if (c1='M') and (c2='u') then
	   	     begin
	   	     	readln(u,v,x);
               // if n <= 5000 then for i := u to v do a[i] := a[i]*x;
	   	     	Mul(u,v,x);
               // check;
	   	     end;
	   	  if (c1='M') and (c2='o') then
	   	     begin
	   	     	readln(u,x);
	   	     	Modify(u,x);
               // a[u] := x;
	   	     end;
	   	  if (c1='R') and (c2='e') then
	   	     begin
	   	     	readln(u,v);
	   	     	Reverse(u,v);
                if n <= 5000 then
                while u < v do
                  begin
                      swap(a[u],a[v]);
                      inc(u); dec(v);
                  end;
	   	     end;
	   	  if (c1='S') and (c2='i') then
	   	     begin
	   	     	readln(u,v,x);
	   	     	Query(0,u,v,x);
	   	     end;
	   	  if (c1='C') and (c2='o') then
	   	     begin
	   	     	readln(u,v,x);
	   	     	Query(1,u,v,x);
	   	     end;
	   end;
    //check;
end.

