Uses math;
Const
	inp = 'VQUERY.IN1';
	out = 'VQUERY.OUT';
	maxn = 100001;
	oo = 1000000000;

Type
	pnode = ^tnode;
	tnode = record
		left,right : pnode;
		key : longint;
	end;

Var
	n,r,q,i,a1,b1,c1,d1,kind,P,u,v,res : longint;
	L : int64;
	a : array [0..1000,0..1000] of longint;
	nilt,root : pnode;
	tree : array [0..maxn] of pnode;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sub1;
	var i,j,rr : longint;
begin
	for i := 1 to n do read(a[0,i]);
	readln(r,q);
	L := 0; P := 0;
	while q > 0 do
	  begin
	  	dec(q);
	  	readln(kind,a1,b1,c1,d1);
        for rr := 1 to r do
        begin
	  	if kind=1 then
	  	  begin
	  	  	inc(P);
	  	  	for i := 1 to n do a[P,i] := a[P-1,i];
	  	  	u := (L*a1+c1) mod n+1; v := (L*b1+d1) mod oo+1;
	  	  	a[P,u] := v;
	  	  end;
	  	if kind=2 then
	  	  begin
	  	  	u := (L*a1+c1) mod n + 1; v := (L*b1+d1) mod N + 1;
	  	  	if u > v then swap(u,v);
	  	  	res := 0;
	  	  	for i := u to v do res := max(res,a[P,i]);
	  	  	writeln(res); L := res;
	  	  end;
	  	if kind=3 then
	  	  begin
	  	  	u := (L*a1 + c1) mod (P+1);
	  	  	inc(P);
	  	  	for i := 1 to n do a[P,i] := a[u,i];
	  	  end;
        end;
	  end;
end;

procedure cnt(i,j : pnode; ok :boolean);
begin
	if ok then i^.left := j else i^.right := j;
end;

function build(lo,hi : longint) : pnode;
	var mid : longint;
        i : pnode;
begin
	if lo=hi then
	  begin
	  	 new(i); i^.key := 0;
	  	 i^.left := nilt; i^.right := nilt;
	  	 exit(i);
	  end;
	mid := (lo+hi) shr 1;
	new(i); i^.key := 0;
	cnt(i,build(lo,mid),true);
	cnt(i,build(mid+1,hi),false);
	exit(i);
end;

procedure update(i : pnode;lo,hi,u,x : longint);
	var mid : longint;
begin
	if (lo>u) or (hi<u) then exit;
	if (lo=u) and (hi=u) then
	  begin
	  	 i^.key := x;
	  	 exit;
	  end;
	mid := (lo+hi) shr 1;
	update(i^.left,lo,mid,u,x);
	update(i^.right,mid+1,hi,u,x);
	i^.key := max(i^.left^.key,i^.right^.key);
end;

function make(t : pnode;lo,hi,u,x : longint) : pnode;
	var i : pnode;
        mid : longint;
begin
	if lo > hi then exit(nilt);
	if (lo=u) and (hi=u) then
	  begin
	  	new(i); i^.key := x; i^.left := nilt; i^.right := nilt;
        exit(i);
	  end;
	mid := (lo+hi) shr 1;
	new(i); i^.key := 0;
	if u <= mid then
	  begin
	  	 cnt(i,t^.right,false);
	  	 cnt(i,make(t^.left,lo,mid,u,x),true);
	  end
	else begin
		 cnt(i,t^.left,true);
		 cnt(i,make(t^.right,mid+1,hi,u,x),false);
	  end;
	i^.key := max(i^.left^.key,i^.right^.key);
    exit(i);
end;

function get(i : pnode;lo,hi,u,v : longint) : longint;
	var mid,l,r : longint;
begin
	if (lo>v) or (hi<u) then exit(0);
	if (u<=lo) and (hi<=v) then exit(i^.key);
	mid := (lo+hi) shr 1;
	l := get(i^.left,lo,mid,u,v);
	r := get(i^.right,mid+1,hi,u,v);
	exit(max(l,r));
end;

procedure sub2;
	var i,j,x,u,v,rr : longint;
begin
	tree[0] := build(1,n);
	new(nilt); nilt^.key := 0; nilt^.left := nilt; nilt^.right := nilt;
	L := 0; P := 0;
	for i := 1 to n do
	  begin
	  	read(x);
	  	update(tree[0],1,n,i,x);
	  end;
	readln(R,Q);
	while q > 0 do
	  begin
	  	dec(q);
	  	readln(kind,a1,b1,c1,d1);
	  	for rr := 1 to r do
	  	  begin
	  	  	 if kind=1 then
	  	  	   begin
	  	  	   	 inc(P);
	  	  	   	 u := (L*a1+c1) mod n + 1; v := (L*b1+d1) mod oo + 1;
	  	  	   	 tree[P] := make(tree[P-1],1,n,u,v);
	  	  	   end;
	  	  	 if kind=2 then
	  	  	   begin
	  	  	   	 u := (L*a1+c1) mod n + 1; v := (L*b1+d1) mod N + 1;
                 if u > v then swap(u,v);
	  	  	   	 L := get(tree[P],1,n,u,v);
	  	  	   	 writeln(L);
	  	  	   end;
	  	  	 if kind=3 then
	  	  	   begin
	  	  	   	 u := (L*a1 + c1) mod (P+1);
	  	  	   	 inc(P); tree[P] := tree[u];
	  	  	   end;
	  	  end;
	  end;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
   if n <= 1000 then sub1
    else sub2;
end.

