Uses math;
const
	inp = 'SEQ.INP';
	out = 'SEQ.OUT';
	maxn = 1000001;

Type
	bb = record
		key,u,v : longint;
	end;

Var
	n,i,nheap : longint;
	a,pos,id : array [1..maxn] of longint;
	heap : array [1..maxn] of bb;
	res : int64;

procedure swap(var xx,yy : bb);
	var temp : bb;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure upheap(i : longint);
	var cha,con : longint;
begin
	con := i;
	repeat
		cha := con div 2;
		if (cha=0) or (heap[cha].key<=heap[con].key) then break;
		swap(heap[cha],heap[con]);
		pos[heap[cha].u] := cha; pos[heap[con].u] := con;
		id[heap[cha].v] := cha; id[heap[con].v] := con;
		con := cha;
	until false;
end;

procedure downheap(i : longint);
	var cha,con : longint;
begin
	cha := i;
	repeat
		con := cha*2;
		if (con<nheap) and (heap[con].key>heap[con+1].key) then inc(con);
		if (con>nheap) or (heap[cha].key<=heap[con].key) then break;
		swap(heap[cha],heap[con]);
		pos[heap[cha].u] := cha; pos[heap[con].u] := con;
		id[heap[cha].v] := cha; id[heap[con].v] := con;
		cha := con;
	until false;
end;

procedure push(x,i,j : longint);
begin
	inc(nheap); pos[i] := nheap; id[j] := nheap;
	with heap[nheap] do
	  begin
	  	key := x; u := i; v := j;
	  end;
	upheap(nheap);
end;

function pop(i : longint) : bb;
begin
	pop := heap[i]; pos[heap[i].u] := 0; id[heap[i].v] := 0;
	heap[i] := heap[nheap]; pos[heap[i].u] := i; id[heap[i].v] := i;
	dec(nheap);
	downheap(i);
	upheap(i);
end;

procedure main;
	var i,j : longint;
		x,y : bb;
begin
	for i := 1 to n-1 do push(max(a[i],a[i+1]),i,i+1);
	repeat
		x := heap[1]; heap[1] := heap[nheap]; pos[heap[1].u] := 1; dec(nheap);
        pos[x.u] := 0; id[x.v] := 0;
		downheap(1);
		res := res + x.key;
		if nheap > 0 then
		  begin
		  	if (x.key=a[x.u]) and (pos[x.v]<>0) then
		  	   begin
		  	   	 y := pop(pos[x.v]);
		  	   	 y.key := max(a[x.u],a[y.v]);
		  	   	 y.u := x.u;
		  	   	 push(y.key,y.u,y.v);
		  	   end
		  	else if (x.key=a[x.v]) and (id[x.u]<>0) then begin
		  		y := pop(id[x.u]);
		  		y.key := max(a[x.v],a[y.u]);
		  		y.v := x.v;
		  		push(y.key,y.u,y.v);
		  	end;
		  end;
	until nheap=0;
    writeln(res);
end;

procedure trau;
    var i,j,temp,u,t1 : longint;
begin
    repeat
       temp := maxlongint;
       for i := 1 to n-1 do
         if max(a[i],a[i+1]) < temp then
           begin
               temp := max(a[i],a[i+1]);
               t1 := min(a[i],a[i+1]);
               if temp=a[i] then u := i+1
                else u := i;
           end
         else if max(a[i],a[i+1])=temp then
           begin
               if t1 < min(a[i],a[i+1]) then
                 begin
                     t1 := min(a[i],a[i+1]);
                     if temp=a[i] then u := i+1
                      else u := i;
                 end;
           end;
       res := res+temp;
       for i := u to n-1 do a[i] := a[i+1];
       dec(n);
    until n=1;
    writeln(res);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do read(a[i]);
    if n <= 2000 then trau
     else main;
end.
