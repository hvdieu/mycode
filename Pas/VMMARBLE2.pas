Uses math;
Const
	inp = 'VMMARBLE.INP';
	out = 'VMMARBLE2.OUT';
	maxn = 1001;
	maxh = 1000000;
	maxm = 11;
	oo = 1000000000000000000;
	dir : array [1..9] of array [1..9] of integer =
	 ((0,3,2,0,6,5,7,8,9),
	  (3,0,1,4,5,6,0,9,8),
	  (2,1,0,0,6,5,0,9,8),
	  (0,3,2,0,6,5,7,8,9),
	  (1,2,3,6,0,4,9,0,7),
	  (0,3,2,5,4,0,9,0,7),
	  (3,0,1,4,5,6,0,9,8),
	  (1,2,3,6,0,4,9,0,7),
	  (3,0,1,6,0,4,8,7,0));
	cp : array [1..9] of array [1..9] of integer =
	 ((2,1,2,2,1,2,1,1,1),
	  (1,2,2,1,1,1,2,1,2),
	  (2,2,3,2,1,2,2,1,2),
	  (2,1,2,2,1,2,1,1,1),
	  (1,1,1,1,2,2,1,2,2),
	  (2,1,2,2,2,3,1,2,2),
	  (1,2,2,1,1,1,2,1,2),
	  (1,1,1,1,2,2,1,2,2),
	  (1,2,2,1,2,2,2,2,3));


Type
	pnode = ^tnode;
	tnode = record
		pos : longint;
		key : int64;
		cha,left,right : pnode;
	end;

Var
	n,m,k,i,j,nheap : longint;
	a : array [1..maxn,1..maxm] of longint;
	sum : array [1..maxn] of longint;
	f : array [0..maxn,0..1025] of int64;
	hi,hj : array [-1..maxh] of longint;
	ht,hgt : array [-1..maxh] of int64;
	mu : array [0..9] of int64;
	root : array [0..50,0..7] of pnode;
	sl : array [1..9] of longint;
    nilt : pnode;


procedure sub1;
	var i,j,tt,x : longint;
begin
	for i := 1 to n do
	  for j := 1 to m do inc(sum[i],a[i,j]);
	for i := 0 to n do
	 for j := 0 to 1 shl m-1 do f[i,j] := oo;
	f[0,0] := 0;
	for i := 1 to n do
	 for tt := 1 to 1 shl m-1 do
	  for j := 1 to m do
	   if (tt shr (j-1)) and 1 = 1 then
	    begin
	    	x := tt and (not (1 shl (j-1)));
	    	f[i,tt] := min(f[i,tt],min(f[i-1,tt],f[i-1,x])+sum[i]-a[i,j]);
	    end;
	writeln(f[n,1 shl m-1]);
end;

procedure cnt(i,j : pnode; ok : boolean);
begin
	j^.cha := i;
	if ok then i^.left := j else i^.right := j;
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

function find(var root : pnode;u : int64) : pnode;
    var i : pnode;
begin
    i := root;
	repeat
		if i=nilt then exit(i);
		if i^.key=u then
          begin
            splay(i);
            root := i;
            exit(i);
          end;
		if u <= i^.key then i := i^.left
		 else i := i^.right;
	until false;
end;

procedure swap(var x,y : longint);
	var temp : longint;
begin
	temp := x; x := y; y := temp;
end;

procedure dc(var x,y : int64);
	var temp : int64;
begin
	temp := x; x := y; y := temp;
end;

procedure add(var root : pnode;u : int64; v : longint);
	var i,j : pnode;
begin
	new(j); j^.left := nilt; j^.right := nilt; j^.cha := nilt;
	j^.key := u; j^.pos := v;
    i := root;
    if root=nilt then
      begin
          root := j;
          exit;
      end;
	repeat
		if i^.key >= u then
          begin
              if i^.left=nilt then
                begin
                    cnt(i,j,true);
                    splay(j);
                    root := j;
                    exit;
                end;
              i := i^.left;
          end
		 else begin
             if i^.right=nilt then
               begin
                   cnt(i,j,false);
                   splay(j);
                   root := j;
                   exit;
               end;
             i := i^.right;
         end;
	until false;

end;

procedure update(cha,con : longint);
	var x : pnode;
begin
	swap(hi[cha],hi[con]); swap(hj[cha],hj[con]);
	dc(ht[cha],ht[con]); dc(hgt[cha],hgt[con]);
	x := find(root[hi[cha],hj[cha]],ht[cha]);
	x^.pos := cha;
	x := find(root[hi[con],hj[con]],ht[con]);
	x^.pos := con;
end;

procedure upheap(i,j : longint;t,gt : int64);
	var cha,con : longint;
		x : pnode;
begin
	x := find(root[i,j],t);
	con := x^.pos;
	if con = 0 then
	  begin
	  	inc(nheap); hi[nheap] := i; hj[nheap] := j;
	  	ht[nheap] := t; hgt[nheap] := gt;
	  	con := nheap;
        add(root[i,j],t,nheap);
	  end
	else hgt[con] := gt;
	repeat
		cha := con div 2;
		if (cha=0) or (hgt[cha]<=hgt[con]) then exit;
		update(cha,con);
		con := cha;
	until false;
end;

procedure pop(var i,t1 : longint; var t2,val : int64);
	var cha,con : longint;
begin
	i := hi[1]; t1 := hj[1]; t2 := ht[1]; val := hgt[1];
	update(1,nheap); dec(nheap);
	cha := 1;
	repeat
		con := cha*2;
		if (con<nheap) and (hgt[con]>hgt[con+1]) then inc(con);
		if (con>nheap) or (hgt[cha]<=hgt[con]) then exit;
		update(cha,con);
		cha := con;
	until false;
end;

procedure sub2;
	var i,j,t1,j1,j2,dd,dem,d1 : longint;
		t2,val,t3,w : int64;
		x : pnode;
		ok1,ok2 : boolean;
begin
	new(nilt); nilt^.pos := 0; nilt^.key := 0;
	nilt^.cha := nilt; nilt^.left := nilt; nilt^.right := nilt;
    hgt[0] := oo; hgt[-1] := -oo;
	for i := 0 to n do
	 for j := 0 to 7 do root[i,j] := nilt;
	mu[1] := 1;
	for i := 2 to 9 do mu[i] := mu[i-1]*100;
	upheap(0,0,oo,0);
	repeat
		pop(i,t1,t2,val);
        x := find(root[i,t1],t2);
        x^.pos := -1;
		if (i=n) and (t1=7) and (t2=oo) then
		  begin
		  	writeln(val);
		  	exit;
		  end;
		t3 := t2;
        d1 := 0;
		for j := 1 to 9 do
		  begin
		  	sl[j] := t3 mod 100;
            if sl[j] > 0 then inc(d1);
		  	t3 := t3 div 100;
		  end;
		if (i=n) and (t1=7) then
		  begin
		  	w := 0;
		  	for j := 1 to 9 do
		  	  begin
		  	  	w := w+(sl[j] div 2)*cp[j,j];
		  	  	if sl[j] mod 2=1 then
		  	  	 if j mod 3=0 then inc(w,2)
		  	  	  else inc(w);
		  	  end;
		  	x := find(root[n,7],oo);
		  	if hgt[x^.pos] > val+w then upheap(n,7,oo,val+w);
		  end;
        if (d1>1) and ((i=n) and (t1=7)) then
		for j1 := 1 to 9 do
         if j1 mod
		 for j2 := 1 to 9 do
		  if (j1<>j2) and (sl[j1]>0) and (sl[j2]>0) then
		    begin
		    	dd := dir[j1,j2];
		    	t3 := t2-mu[j1]-mu[j2]+mu[dd];
		    	x := find(root[i,t1],t3);
		    	if hgt[x^.pos] > val+cp[j1,j2] then upheap(i,t1,t3,val+cp[j1,j2]);
		    end;
		if i < n then
		  begin
		  	for j := 1 to 3 do
		  	  begin
		  	  	w := 0; ok1 := false; ok2 := false;
		  	  	dem := 0;
		  	  	for j1 := 1 to 3 do
		  	  	 if j1<>j then
		  	  	  begin
		  	  	  	inc(dem);
		  	  	    w := w+a[i+1,j1] div 2;
		  	  	    if a[i+1,j1] mod 2=1 then
		  	  	     if dem=1 then ok1 := true else ok2 := true;
		  	  	  end;
		  	  	dd := 0;
		  	  	if j=1 then
		  	  	  begin
		  	  	  	if ok1 and ok2 then dd := 3
		  	  	  	 else if ok1 then dd := 2 else
                      if ok2 then dd := 1;
		  	  	  end
		  	  	else if j=2 then
		  	  	  begin
	  	  	  	if ok1 and ok2 then dd := 6
		  	  	  	  else if ok1 then dd := 5 else
                       if ok2 then dd := 4;
		  	  	  end
		  	  	else begin
		  	  		if ok1 and ok2 then dd := 9
		  	  		 else if ok1 then dd := 8 else
                      if ok2 then dd := 7;
		  	  	end;
		  	  	t3 := t2+mu[dd];
                if (i+1<>n) or ((i+1=n) and (t1 or (1 shl j-1)=7)) then
                 begin
                  x := find(root[i+1,t1 or (1 shl (j-1))],t3);
		  	  	  if hgt[x^.pos] > val+w then upheap(i+1,t1 or (1 shl (j-1)),t3,val+w);
                 end;
		  	  end;
		  end;
	until false;
end;

procedure sub3;
    var i,j : longint;
        res,temp : int64;
begin
    res := oo;
    for i := 1 to n do
     for j := 1 to n do
      if i <> j then
        begin
           temp := (a[i,2]+1) div 2+(a[j,1]+1) div 2;
           for k := 1 to n do
            if (k<>i) and (k<>j) then temp := temp+min((a[k,1]+1) div 2,(a[k,2]+1) div 2);
            res := min(res,temp);
        end;
    writeln(res);
end;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
	readln(n,m,k);
	for i := 1 to n do
	  for j := 1 to m do read(a[i,j]);
	if (k=1) then sub1
	 else if m=3 then sub2
      else if m=2 then sub3
       else writeln(0);
end.



