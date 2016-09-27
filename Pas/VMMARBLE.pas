Uses math,sysutils;
Const
	inp = 'VMMARBLE.INP';
	out = 'VMMARBLE.OUT';
	maxn = 1001;
	maxh = 1000000;
	maxm = 11;
	rr=0;
	oo = 1000000000000000000;
    cantime = 2.9;
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
		state : int64;
        cost : int64;
		cha,left,right : pnode;
	end;

Var
	n,m,k,i,j,nheap : longint;
    id : array [1..50,1..3] of int64;
	a : array [1..maxn,1..maxm] of longint;
	mau,sum : array [1..maxn] of longint;
	f : array [0..maxn,0..1025] of int64;
    bound : array [1..51] of int64;
    le : array [1..51] of integer;
	hstate,hcost : array [-1..maxh] of int64;
	mu : array [0..9] of int64;
	root : array [0..50] of pnode;
	sl : array [1..9] of longint;
    nilt : pnode;
    time1,time2,time : tdatetime;
    res,base : int64;
    sltt : longint;
    ss : array [1..50] of longint;

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

procedure checktime;
begin
	time2 := now;
    time := (time2-time1)*3600*24;
	if time > cantime then
	  begin
	  	writeln(res-rr);
	  	halt;
	  end;
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
		if i^.state=u then
          begin
            splay(i);
            root := i;
            exit(i);
          end;
		if u <= i^.state then i := i^.left
		 else i := i^.right;
	until false;
end;

procedure swap(var x,y : int64);
	var temp : int64;
begin
	temp := x; x := y; y := temp;
end;

procedure add(var root : pnode;u,v : int64);
	var i,j : pnode;
begin
	new(j); j^.left := nilt; j^.right := nilt; j^.cha := nilt;
	j^.state := u; j^.cost := v;
    i := root;
    if root=nilt then
      begin
          root := j;
          exit;
      end;
	repeat
		if i^.state >= u then
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
	swap(hstate[cha],hstate[con]);
	swap(hcost[cha],hcost[con]);
end;

procedure push(i,j : int64);
	var cha,con : longint;
		x : pnode;
begin
    checktime;
	inc(nheap);
	hstate[nheap] := i; hcost[nheap] := j; con := nheap;
	repeat
		cha := con div 2;
		if (cha=0) or (hcost[cha]<=hcost[con]) then exit;
		update(cha,con);
		con := cha;
	until false;
end;

procedure pop(var i,j : int64);
	var cha,con : longint;
begin
	i := hstate[1]; j := hcost[1];
	update(1,nheap); dec(nheap);
	cha := 1;
	repeat
		con := cha*2;
		if (con<nheap) and (hcost[con]>hcost[con+1]) then inc(con);
		if (con>nheap) or (hcost[cha]<=hcost[con]) then exit;
		update(cha,con);
		cha := con;
	until false;
end;

function tinh(i,j : longint) : int64;
	var t : longint;
begin
	tinh := 0;
	for t := 1 to 3 do
	 if t<>j then tinh := tinh+(a[i,t]+1) div 2;
end;

function tinh2(i,j : longint) : int64;
	var t : longint;
begin
	tinh2 := 0;
	for t := 1 to 3 do
	 if t<>j then tinh2 := tinh2+(a[i,t]) div 2;
end;

procedure dc(var xx,yy : longint);
    var temp : longint;
begin
    temp := xx; xx := yy; yy := temp;
end;

procedure init;
	var i,j,k,t,dem,xx,sl1,sl2 : longint;
		temp : int64;
begin
	res := oo;
	new(nilt); nilt^.cost := oo; nilt^.state := 0;
	nilt^.cha := nilt; nilt^.left := nilt; nilt^.right := nilt;
	for i := 0 to n do root[i] := nilt;
    for i := 1 to n do
      begin
          if (a[i,1] = a[i,2]) and (a[i,2]=a[i,3]) then ss[i] := 3
           else if (a[i,1]=a[i,2]) or (a[i,2]=a[i,3]) or (a[i,1]=a[i,3]) then ss[i] := 2
            else ss[i] := 1;
      end;
    for i := 1 to n do
     for j := i+1 to n do
      if ss[i] < ss[j] then
        begin
            dc(a[i,1],a[j,1]);
            dc(a[i,2],a[j,2]);
            dc(a[i,3],a[j,3]);
            dc(ss[i],ss[j]);
        end;
	mu[1] := 1;
	for i := 2 to 9 do mu[i] := mu[i-1]*100;
	for i := n downto 1 do
    begin
     bound[i] := bound[i+1]+min(min(tinh2(i,1),tinh2(i,2)),tinh2(i,3));
     dem := 0;
     if a[i,1] mod 2=0 then inc(dem);
     if a[i,2] mod 2=0 then inc(dem);
     if a[i,3] mod 2=0 then inc(dem);
     if dem>=2 then le[i] := le[i+1]
      else le[i] := le[i+1]+1;
    end;
	for i := 1 to n do
	 for j := 1 to n do
	  for k := 1 to n do
	   if (i<>j) and (j<>k) and (i<>k) then
	    begin
	    	temp := tinh(i,1)+tinh(j,2)+tinh(k,3);
            sl1 := 0; sl2 := 0;
	    	for t := 1 to n do
	    	 if (t<>i) and (t<>j) and (t<>k) then
               begin
                 xx := max(max(a[t,1],a[t,2]),a[t,3]);
                 if xx=a[t,1] then
                   begin
                   temp := temp+tinh(t,1);
                     if (a[t,2] mod 2=1) and (a[t,3] mod 2=1) then inc(sl2)
                      else if (a[t,2] mod 2=1) or (a[t,3] mod 2=1) then inc(sl1);
                   end
                 else if xx=a[t,2] then
                   begin
                      temp := temp+tinh(t,2);
                     if (a[t,1] mod 2=1) and (a[t,3] mod 2=1) then inc(sl2)
                      else if (a[t,1] mod 2=1) or (a[t,3] mod 2=1) then inc(sl1);
                   end
                 else
                   begin
                     temp := temp+tinh(t,3);
                     if (a[t,1] mod 2=1) and (a[t,2] mod 2=1) then inc(sl2)
                      else if (a[t,2] mod 2=1) or (a[t,1] mod 2=1) then inc(sl1);
                   end;
               end;
	    	res := min(res,temp-min(sl1,sl2));
	    end;
    base := res;
end;

procedure cal(i,j : longint;var state,state2 : int64; var cost : longint);
	var j1,w,dem,dd : longint;
		ok1,ok2 : boolean;
begin
	w := 0; ok1 := false; ok2 := false;
	dem := 0;
	for j1 := 1 to 3 do
	   if j1<>j then
		  begin
		  	  inc(dem);
		  	  w := w+a[i,j1] div 2;
		  	  if a[i,j1] mod 2=1 then
		  	  	if dem=1 then ok1 := true else ok2 := true;
		  end;
	   dd := 0;
		  if j=1 then
		  	 begin
		  	  	if ok1 and ok2 then dd := 3
		  	  	  else if ok1 then dd := 2 else if ok2 then dd := 1;
		  	 end
		  else if j=2 then
		  	 begin
	  	  	  	if ok1 and ok2 then dd := 6
		  	  	  else if ok1 then dd := 5 else if ok2 then dd := 4;
		  	 end
		  else begin
		  	    if ok1 and ok2 then dd := 9
		  	      else if ok1 then dd := 8 else if ok2 then dd := 7;
		  end;
	state2 := state+mu[dd];
	cost := w;
end;

procedure Dij(u,base : int64);
	var state2,state,val,t3,w : int64;
		d1,dd,j,j1,j2,d2,d3,d4,d5 : longint;
		x,y : pnode;
begin
	nheap := 0;
    x := find(root[n],u);
    y := find(root[n],oo);
    if (x<>nilt) and (y<>nilt) and (y^.cost-x^.cost+base>res) then exit;
	push(u,base);
	repeat
        if nheap=0 then exit;
		checktime;
		pop(state,val);
		x := find(root[n],state);
		if x^.cost <> val then continue;
		if state=oo then
		  begin
		  	res := min(res,val);
		  	exit;
		  end;
		t3 := state;
		d1 := 0; d2 := 0; d3 := 0; w := 0; d4 := 0;
		for j := 1 to 9 do
		  begin
		  	sl[j] := t3 mod 100;
            if sl[j] > 0 then inc(d1);
		  	t3 := t3 div 100;
            w := w+(sl[j] div 2)*cp[j,j];
		  	 if sl[j] mod 2=1 then
		  	  if j mod 3=0 then inc(w,2)
		  	   else inc(w);
             if (j mod 3=0) and (sl[j]=0) then inc(d2);
             if (j mod 3=1) then inc(d3,sl[j]);
             inc(d4,sl[j]);
		  end;
		if d2=0 then
		  begin
		  	x := find(root[n],oo);
		  	if x^.cost > val+d3 then
		  	  begin
		  	    res := val+d3;
		  	  	if x=nilt then add(root[n],oo,val+d3)
		  	  	 else x^.cost := val+d3;
		  	  	exit;
		  	  end;
		  end;
        if d3>=0 then
        begin
		x := find(root[n],oo);
		if (x^.cost > val+w) and (val+w<res) then
		  begin
		  	if x=nilt then add(root[n],oo,val+w)
		  	 else x^.cost := val+w;
		  	res := val+w;
		  	push(oo,val+w);
		  end;
        end;
		if d1 > 1 then
		  begin
		  	j1 := 3;
            while j1 <= 9 do
            begin
			 for j2 := 1 to 9 do
		  	  if (j1<>j2) and (sl[j1]>0) and (sl[j2]>0) and
              (dir[j1,j2]<>j2) then
		        begin
		    	   dd := dir[j1,j2];
		    	   state2 := state-mu[j1]-mu[j2]+mu[dd];
                   if dd=0 then d5 := d4-2
                    else d5 := d4-1;
		    	   if (val+cp[j1,j2]+d5<=res) then
		  			begin
                        x := find(root[n],state2);
                        if x^.cost > val+cp[j1,j2] then
                        begin
		  				if x=nilt then add(root[n],state2,val+cp[j1,j2])
		  				 else x^.cost := val+cp[j1,j2];
		  				push(state2,val+cp[j1,j2]);
                        end;
		  			end;
		        end;
              inc(j1,3);
             end;
		  end;
	until false;
end;

procedure duyet(i,tt,count : longint;state,val : int64);
	var j,color,w : longint;
		state2 : int64;
		x : pnode;
begin
	checktime;
	if i > n then
	  begin
	  	 if tt=7 then
         begin
           base := min(base,val);
           Dij(state,val);
         end;
         inc(sltt);
	  	 exit;
	  end;
	for j := 1 to 3 do
      if ((tt shr (j-1)) and 1=0) then
	  begin
	  	color := j;
	  	cal(i,color,state,state2,w);
	  	if state2-state<>0 then inc(count);
	  	if (val+w+bound[i+1]+count+le[i+1]<=res) then
	  	  begin
            x := find(root[i],state2);
            if x^.cost > val+w then
            begin
	  	   if x=nilt then add(root[i],state2,val+w)
	  	    else x^.cost := val+w;
	  	  	duyet(i+1,tt or (1 shl (color-1)),count,state2,val+w);
            end;
	  	  end;
	  	if state2-state<>0 then dec(count);
	  end;
    for j := 1 to 3 do
      if ((tt shr (j-1)) and 1=1) and (a[i,j]=max(max(a[i,1],a[i,2]),a[i,3])) then
      begin
        color := j;
	  	cal(i,color,state,state2,w);
	  	if state2-state<>0 then inc(count);
	  	if (val+w+bound[i+1]+count+le[i+1]<=res) then
	  	  begin
            x := find(root[i],state2);
            if x^.cost > val+w then
            begin
	  	   if x=nilt then add(root[i],state2,val+w)
	  	    else x^.cost := val+w;
	  	  	duyet(i+1,tt or (1 shl (color-1)),count,state2,val+w);
            end;
	  	  end;
	  	if state2-state<>0 then dec(count);
      end;
end;

procedure sub2;
	var i,j,t1,j1,j2,dd,dem,d1 : longint;
		t2,val,t3,w : int64;
		x : pnode;
		ok1,ok2 : boolean;
begin
	init;
	duyet(1,0,0,oo,0);
    writeln(res);
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
	time1 := now;
  //  assign(input,inp); reset(input);
  //  assign(output,out); rewrite(output);
	readln(n,m,k);
	for i := 1 to n do
	  for j := 1 to m do read(a[i,j]);
	if (k=1) then sub1
	 else if m=3 then sub2
      else if m=2 then sub3
       else writeln(0);
   // writeln(sltt);
end.