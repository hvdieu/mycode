Uses math;
Const
	inp = '';
	out = '';
	maxn = 501;
	maxm = 10001;
	oo = 1000000000;

Var
	m,n,i,u,v,l1,l2,nheap,bb : longint;
	head : array [1..maxn] of longint;
	ke,next,s,t : array [1..maxm] of longint;
	d,pos : array [1..101,0..100001] of longint;
	heapi,heapj : array [1..10000000] of longint;
	free : array [1..101,0..100001] of boolean;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure update(cha,con : longint);
        begin
            swap(heapi[cha],heapi[con]);
            swap(heapj[cha],heapj[con]);
            pos[heapi[cha],heapj[cha]] := cha;
            pos[heapi[con],heapj[con]] := con;
        end;

procedure upheap(i,j : longint);
var cha,con : longint;
        begin
             con := pos[i,j];
             if con = 0 then
              begin
                  inc(nheap); heapi[nheap] := i; heapj[nheap] := j;
                  pos[i,j] := nheap; con := nheap;
              end;
             repeat
                  cha := con div 2;
                  if (cha=0) or (d[heapi[cha],heapj[cha]] <= d[heapi[con],heapj[con]]) then break;
                  swap(heapi[cha],heapi[con]);
                  swap(heapj[cha],heapj[con]);
                  pos[heapi[cha],heapj[cha]] := cha;
                  pos[heapi[con],heapj[con]] := con;
                  con := cha;
             until false;
        end;

procedure downheap(i,j : longint);
var cha,con : longint;
        begin
            cha := pos[i,j];
            repeat
             con := cha*2;
             if (con<nheap) and (d[heapi[con],heapj[con]] > d[heapi[con+1],heapj[con+1]]) then inc(con);
             if (con>nheap) or (d[heapi[cha],heapj[cha]] <= d[heapi[con],heapj[con]]) then break;
             swap(heapi[cha],heapi[con]);
             swap(heapj[cha],heapj[con]);
             pos[heapi[cha],heapj[cha]] := cha;
             pos[heapi[con],heapj[con]] := con;
             cha := con;
            until false;
        end;

procedure pop(var u,ti : longint);
        begin
            u := heapi[1]; ti := heapj[1];
            heapi[1] := heapi[nheap]; heapj[1] := heapj[nheap];
            pos[heapi[1],heapj[1]] := 1;
            dec(nheap);
            downheap(heapi[1],heapj[1]);
        end;

procedure main;
	var i,j,u,ti,v : longint;
		res : double;
begin
	for i := 1 to n do
	 for j := 0 to bb do
	   begin
	   	 d[i,j] := oo; free[i,j] := true;
	   end;
	d[1,0] := 0; upheap(1,0);
	repeat
		if nheap=0 then break;
		pop(u,ti);
		free[u,ti] := false;
		j := head[u];
		while j <> 0 do
		  begin
		  	v := ke[j];
		  	if free[v,ti+t[j]] and (d[v,ti+t[j]]>d[u,ti]+s[j]) then
		  	  begin
		  	  	d[v,ti+t[j]] := d[u,ti]+s[j];
		  	  	upheap(v,ti+t[j]);
		  	  end;
            j := next[j];
		  end;
	until false;
	res := oo;
	for j := 1 to bb do
	 if (d[n,j]<>oo) and (d[n,j]/j<res) then res := d[n,j]/j;
	if res <> oo then writeln(res:0:6) else writeln(-1);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m);
	for i := 1 to m do
	  begin
	  	 readln(u,v,l1,l2);
	  	 ke[i] := v; next[i] := head[u]; head[u] := i; s[i] := l1; t[i] := l2;
	  	 inc(bb,l2);
	  end;
	main;
end.

