{$INLINE ON}
{$MODE OBJFPC}
Uses math;
Const
	inp = 'YPKTH.INP';
	out = 'YPKTH.OUT';
	maxn = 100001;

Type
	pnode = ^tnode;
	tnode = record
		key : longint;
		left,right : pnode;
	end;

Var
	n,i,q,u,v,k,l,r : longint;
	a,id,b : array [0..maxn] of longint;
	tree : array [0..maxn] of pnode;
	nilt : pnode;


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
		while a[i] < k do inc(i);
		while a[j] > k do dec(j);
		if i <= j then
		  begin
		  	swap(a[i],a[j]);
		  	swap(id[i],id[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure cnt(i,j : pnode; ok : boolean);
begin
	if ok then i^.left := j else i^.right := j;
end;

function inn(l,r : longint) : pnode;
	var i : pnode;
		mid : longint;
begin
    new(i); i^.key := 0;
	if l=r then exit(i);
	mid := (l+r) div 2;
	cnt(i,inn(l,mid),true);
	cnt(i,inn(mid+1,r),false);
	exit(i);
end;

procedure make(t1,t2 : pnode; lo,hi,key : longint);
	var mid : longint;
		i : pnode;
begin
	if lo=hi then exit;
	mid := (lo+hi) div 2;
	if key <= mid then
	  begin
	  	cnt(t2,t1^.right,false);
	  	new(i); cnt(t2,i,true);
	  	i^.key := t1^.left^.key+1;
	  	make(t1^.left,i,lo,mid,key);
	  end
	else begin
		cnt(t2,t1^.left,true);
		new(i); cnt(t2,i,false);
		i^.key := t1^.right^.key+1;
		make(t1^.right,i,mid+1,hi,key);
	end;
end;

function get(t1,t2 : pnode; lo,hi,key : longint) : longint;
	var mid,x : longint;
begin
	if lo=hi then exit(lo);
	mid := (lo+hi) shr 1;
	x := t2^.left^.key-t1^.left^.key;
	if x >= key then get := get(t1^.left,t2^.left,lo,mid,key)
	 else get := get(t1^.right,t2^.right,mid+1,hi,key-x);
end;

procedure main;
	var i,j,dem,lo,hi,mid,u,v,k : longint;
		t1,t2 : pnode;
begin
	new(nilt);
	sort(1,n);
	for i := 1 to n do b[id[i]] := i;
	tree[0] := inn(1,n);
	for i := 1 to n do
	  begin
	  	 t1 := tree[i-1];
         new(t2);
         t2^.key := t1^.key+1;
         tree[i] := t2;
	  	 make(t1,t2,1,n,b[i]);
	  end;
	readln(q);
	while q > 0 do
	  begin
        dec(q);
	  	readln(u,v,k);
	  	writeln(a[get(tree[u-1],tree[v],1,n,k)]);
	  end;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do
	  begin
	  	 read(a[i]);
	  	 id[i] := i;
	  end;
	main;
end.
