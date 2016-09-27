Uses math;
Const
	inp = 'VMWTREE.INP';
	out = 'VMWTREE.OUT';
	maxn = 1;

Type
	pnode = ^tnode;
	tnode = record
		cha,left,right : pnode;
		key,con,tt,k1,k2 : longint;
	end;

Var
	n,ntest,i,vmax,dem1,dem2,u,v,m,lmax,lmin,sum,top1,top2,top : longint;
	a,num,thoat,cha,head,dd,con,q,pos,start,b,c,d,st : array [1..maxn] of longint;
	x1,y1,x2,y2 : array [0..100] of longint;
	t1,t2 : array [0..100] of pnode;
	ke,next : array [-maxn..maxn] of longint;
	f : array [1..maxn,0..20] of longint;
	nilt,root,root1 : pnode;

procedure dfs(u : longint);
	var j,v : longint;
begin
	inc(dem1); num[u] := dem1; con[u] := 1;
	for j := 1 to vmax do f[u,j] := f[f[u,j-1],j-1];
	j := head[u];
	while j <> 0 do
	  begin
	  	v := ke[j];
	  	if num[v]=0 then
	  	  begin
	  	  	cha[v] := u; f[v,0] := u;
            d[v] := d[u]+1;
	  	  	dfs(v);
	  	  	con[u] := con[u]+con[v];
	  	  	if (dd[u]=0) or (con[dd[u]]<con[v]) then dd[u] := v;
	  	  end;
	  	j := next[j];
	  end;
	inc(dem2); thoat[u] := dem2;
end;

function check(u,v : longint) : boolean;
begin
	if (num[u]<=num[v]) and (thoat[u]>=thoat[v]) then exit(true)
	 else exit(false);
end;

function lca(u,v : longint) : longint;
	var j : longint;
begin
	if check(u,v) then exit(u);
	if check(v,u) then exit(v);
	for j := vmax downto 0 do
	  if check(f[u,j],v)=false then u := f[u,j];
	exit(cha[u]);
end;

procedure HeavyLight;
	var i,j : longint;
begin
	vmax := trunc(ln(n)/ln(2)); cha[1] := 1; f[1,0] := 1;
    dem1 := 0; dem2 := 0;
	dfs(1); m := 0;
	for i := 1 to n do
	  if dd[cha[i]]<>i then
	    begin
	    	u := i;
	    	inc(m); q[m] := u; start[u] := u; pos[u] := m;
            c[m] := a[u];
	    	while dd[u]<>0 do
	    	  begin
	    	  	u := dd[u];
	    	  	inc(m); q[m] := u; start[u] := i; pos[u] := m;
                c[m] := a[u];
	    	  end;
	    end;
end;

procedure tao(var i : pnode);
begin
	new(i); i^.key := 0; i^.left := nilt; i^.right := nilt; i^.cha := nilt; i^.tt := 0; i^.con := 1;
    i^.k1 := 0; i^.k2 := maxlongint;
end;

procedure cnt(i,j : pnode; ok :boolean);
begin
	j^.cha := i;
	if ok then i^.left := j
	 else i^.right := j;
end;

procedure down(i : pnode);
	var l,r : pnode;
begin
	if (i^.tt=1) then
	  begin
	  	l := i^.left; r := i^.right;
	  	cnt(i,r,true); cnt(i,l,false);
	  	i^.left^.tt := 1-i^.left^.tt; i^.right^.tt := 1-i^.right^.tt;
	  	i^.tt := 0;
	  end;
    nilt^.tt := 0;
end;

procedure update(i : pnode);
begin
    down(i); down(i^.left); down(i^.right);
	i^.con := i^.left^.con+i^.right^.con+1;
	i^.k1 := max(max(i^.left^.k1,i^.right^.k1),i^.key);
	i^.k2 := min(min(i^.left^.k2,i^.right^.k2),i^.key);
end;

procedure inn2(i : pnode);
begin
    down(i);
    if i^.left <> nilt then inn2(i^.left);
    inc(n); b[n] := i^.key;
    if i^.right <> nilt then inn2(i^.right);
end;

function Init(l,r : longint) : pnode;
	var mid : longint;
		i : pnode;
begin
	if l>r then exit(nilt);
	mid := (l+r) shr 1;
	tao(i); i^.key := a[q[mid]];
	i^.k1 := a[q[mid]]; i^.k2 := a[q[mid]];
	cnt(i,Init(l,mid-1),true);
	cnt(i,Init(mid+1,r),false);
	update(i);
	exit(i);
end;

procedure InitTree;
	var i,j : longint;
begin
	new(nilt); nilt^.con := 0; nilt^.key := 0; nilt^.left := nilt; nilt^.right := nilt; nilt^.cha := nilt;
	nilt^.k1 := 0; nilt^.k2 := maxlongint; nilt^.tt := 0;
	root := Init(1,n);
end;

procedure Uptree(i : pnode);
	var j,p,pp : pnode;
begin
	p := i^.cha; pp := p^.cha;
    update(i);
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

procedure Splay(i : pnode);
	var p,pp : pnode;
begin
	while i^.cha <> nilt do
	   begin
	   	  p := i^.cha; pp := p^.cha;
	   	  if pp <> nilt then
           begin
	   	    if (pp^.left=p) = (p^.left=i) then Uptree(p)
	   	      else Uptree(i);
           end;
	   	  Uptree(i);
	   end;
end;

function find(root : pnode;u : longint) : pnode;
	var i : pnode;
begin
	i := root;
	repeat
		down(i);
		if i^.left^.con+1=u then exit(i);
		if i^.left^.con>=u then i := i^.left
		  else begin
		  	dec(u,i^.left^.con+1);
		  	i := i^.right;
		  end;
	until false;
end;

procedure Cut(root : pnode;u : longint;var r1,r2 : pnode);
	var i : pnode;
begin
	if u=0 then
	  begin
	  	r1 := nilt; r2 := root; down(r2); exit;
	  end;
	if u=root^.con then
	  begin
	  	r1 := root; r2 := nilt; down(r1); exit;
	  end;
	i := find(root,u);
	Splay(i);
	down(i);
	r1 := i; r2 := i^.right;
	r1^.right := nilt; r2^.cha := nilt;
	update(r1); update(r2);
end;

function Union(r1,r2 : pnode) : pnode;
	var i : pnode;
begin
	down(r1); down(r2);
	if r1=nilt then exit(r2);
	down(r1);
	while r1^.right <> nilt do
	  begin
	    r1 := r1^.right;
	    down(r1);
	  end;
	splay(r1);
    down(r1);
	cnt(r1,r2,false);
	update(r1);
	exit(r1);
end;

procedure Qr(u,v : longint);
	var r1,r2,r3 : pnode;
begin
	Cut(root,v,r1,r3);
	Cut(r1,u-1,r1,r2);
	lmin := min(lmin,r2^.k2);
	lmax := max(lmax,r2^.k1);
	r1 := Union(r1,r2);
	root := Union(r1,r3);
end;

procedure Query(u,v : longint);
	var i,r1,r2 : pnode;
		uu,vv : longint;
begin
	repeat
		if check(start[u],v) then
	      begin
	      	 Qr(pos[v],pos[u]);
	      	 exit;
		  end
		else begin
			 Qr(pos[start[u]],pos[u]);
			 u := cha[start[u]];
		end;
	until false;
end;

procedure Get(k,u,v : longint);
	var pp : longint;
begin
	lmax := 0; lmin := maxlongint;
	if check(u,v) then Query(v,u)
	 else if check(v,u) then Query(u,v)
	  else begin
	  	pp := lca(u,v);
	  	Query(u,pp);
        Query(v,pp);
	  end;
	if k=1 then writeln(lmin)
	 else writeln(lmax);
end;

procedure swap(var x,y : longint);
	var temp : longint;
begin
	temp := x; x:= y ; y:= temp;
end;

procedure push1(u,v : longint);
	var j : longint;
		r1,r2,r3 : pnode;
begin
	inc(top1); x1[top1] := u; y1[top1] := v;
	for j := 1 to top1-1 do
	  if x1[top1] > x1[j] then
	    begin
	    	dec(u,y1[j]-x1[j]+1);
	    	dec(v,y1[j]-x1[j]+1);
	    end;
	Cut(root,v,r1,r3);
	Cut(r1,u-1,r1,r2);
	t1[top1] := r2;
	root := Union(r1,r3);
end;

procedure push2(u,v : longint);
	var j,uu,vv : longint;
		r1,r2,r3 : pnode;
begin
	inc(top2); x2[top2] := u; y2[top2] := v;
	for j := 1 to top1 do
	  if x2[top2] > x1[j] then
	    begin
	    	dec(u,y1[j]-x1[j]+1);
	    	dec(v,y1[j]-x1[j]+1);
	    end;
	for j := 1 to top2-1 do
	  if x2[top2] > x2[j] then
	    begin
	    	dec(u,y2[j]-x2[j]+1);
	    	dec(v,y2[j]-x2[j]+1);
	    end;
	Cut(root,v,r1,r3);
	Cut(r1,u-1,r1,r2);
	t2[top2] := r2;
	root := Union(r1,r3);
end;

procedure Reserve(u,v : longint);
	var i,j,pp,temp,sum,xx,yy,uu,vv,x : longint;
		r1,r2,r3,r4,r5 : pnode;
begin
    if u=v then exit;
	if check(u,v) then
	  begin
	  	temp := u; u := v; v := temp;
	  end;
	pp := lca(u,v);
	top1 := 0; top2 := 0;
	t1[0] := nilt; t2[0] := nilt;
	i := u;
	repeat
		if check(start[i],pp) then
		  begin
		  	push1(pos[pp],pos[i]);
		  	break;
		  end;
		push1(pos[start[i]],pos[i]);
		i := cha[start[i]];
	until false;
	if pp<>v then
	  begin
	  	pp := v;
	  	for j := vmax downto 0 do
	  	 if check(f[pp,j],u)=false then pp := f[pp,j];
	  	i := v;
	  	repeat
		  if check(start[i],pp) then
		    begin
		      push2(pos[pp],pos[i]);
		  	  break;
		    end;
		  push2(pos[start[i]],pos[i]);
		  i := cha[start[i]];
		until false;
	  end;
	root1 := nilt;
    //n := 0;
   // inn2(root);
	for i := 1 to top1 do
	  begin
	  	t1[i]^.tt := 1-t1[i]^.tt;
	  	root1 := Union(root1,t1[i]);
	  end;
	for i := top2 downto 1 do
	  begin
	  	root1 := Union(root1,t2[i]);
	  end;
	root1^.tt := 1-root1^.tt;
    //n := 0; inn2(root1);
	for i := 1 to top1 do
	  begin
	  	uu := x1[i];
	  	for j := i+1 to top1 do
	  	 if x1[i]>x1[j] then
	  	   begin
	  	   	 x := y1[j]-x1[j]+1;
	  	   	 dec(uu,x);
	  	   end;
	  	for j := 1 to top2 do
	  	  if x1[i]>x2[j] then
	  	    begin
	  	    	x := y2[j]-x2[j]+1;
	  	    	dec(uu,x);
	  	    end;
	  	Cut(root1,y1[i]-x1[i]+1,r2,r1);
        root1 := r1;
	  	r2^.tt := 1-r2^.tt;
        //n := 0; inn2(r2);
	  	Cut(root,uu-1,r1,r3);
	  	r1 := Union(r1,r2);
       // n := 0; inn2(r1);
        root := Union(r1,r3);
       // n := 0;
       // inn2(root);
	  end;
	for i := top2 downto 1 do
	  begin
	  	uu := x2[i];
	  	for j := 1 to i-1 do
	  	 if x2[i]>x2[j] then
	  	   begin
	  	   	x := y2[j]-x2[j]+1;
	  	   	dec(uu,x);
	  	   end;
	  	Cut(root1,y2[i]-x2[i]+1,r2,r1);
        root1 := r1;
	  	Cut(root,uu-1,r1,r3);
	  	r1 := Union(r1,r2);
        root := Union(r1,r3);
       // n := 0;
      //  inn2(root);
	  end;
end;

procedure trauReserve(u,v : longint);
    var i,j,temp,pp,right : longint;
begin
	if u=v then exit;
	if check(u,v) then swap(u,v);
	top := 0;
	if check(v,u) then
	  begin
	    while u<>v do
	      begin
	  	     inc(top); st[top] := u;
	  	     u := cha[u];
	  	  end;
	  	  inc(top); st[top] := v;
	  end
	else begin
		i := u;
		while check(i,v)=false do
		  begin
		  	inc(top); st[top] := i;
		  	i := cha[i];
		  end;
		pp := i; inc(top); st[top] := pp;
		right := d[v]+d[u]-2*d[pp]+2;
		i := v;
		while check(i,u)=false do
		  begin
		  	dec(right); st[right] := i;
		  	i := cha[i];
		  end;
		top := d[v]+d[u]-2*d[pp]+1;
	end;
	for i := 1 to top div 2 do swap(a[st[i]],a[st[top-i+1]]);
    m := 0;
	for i := 1 to n do
	  if dd[cha[i]]<>i then
	    begin
	    	u := i;
	    	inc(m); q[m] := u; start[u] := u; pos[u] := m;
            c[m] := a[u];
	    	while dd[u]<>0 do
	    	  begin
	    	  	u := dd[u];
	    	  	inc(m); q[m] := u; start[u] := i; pos[u] := m;
                c[m] := a[u];
	    	  end;
	    end;
end;

procedure main;
	var i,j,u,k,v,sl : longint;
begin
	HeavyLight;
	InitTree;
    sl := 0;
    n := 0;
    inn2(root);
	while ntest > 0 do
	  begin
	  	dec(ntest);
	  	readln(k,u,v);
	  	if k<=2 then
         begin
           inc(sl);
           Get(k,u,v);
         end
	  	 else
          begin
            Reserve(u,v);
            {trauReserve(u,v);
            n := 0;
	        inn2(root);}
          end;
	  end;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,ntest);
	for i := 1 to n do read(a[i]);
	for i := 1 to n-1 do
	  begin
	  	readln(u,v);
	  	ke[i] := v; next[i] := head[u]; head[u] := i;
	  	ke[-i] := u; next[-i] := head[v]; head[v] := -i;
	  end;
	main;
end.
