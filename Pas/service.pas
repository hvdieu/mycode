Uses math;
const
	inp = '';
	out = '';
	maxn = 501;
	maxm = 10001;
	oo = 9999999999999999;

Var
	n,m,ntest,u,v,l,i,x,y,z,j : longint;
	head : array [1..maxn] of longint;
	a,dir : array [1..maxn,1..maxn] of qword;
	ke,next,w : array [-maxm..maxm] of longint;
	dd : array [1..maxm] of boolean;

procedure init;
	var i,j,k,u,v,t,vt : longint;
         res : qword;
begin
  for k := 1 to n do
	for i := 1 to n do
	  for j := 1 to n do
	      if a[i,j] > a[i,k]+a[k,j] then a[i,j] := a[i,k]+a[k,j];
  for t := 1 to n do
   for u := 1 to n do
    begin
       j := head[u]; res := oo; vt := 0;
       while j <> 0 do
         begin
            v := ke[j];
            if (a[v,t]+w[j]=a[u,t]) and (res>w[j]) then
              begin
                 res := w[j]; vt := j;
              end;
            j := next[j];
         end;
       dir[u,t] := abs(vt);
    end;
end;

function min(x,y : qword) : qword;
begin
    if x < y then exit(x) else exit(y);
end;

procedure main;
	var i,j,u,vt : longint;
		res : qword;
        temp,tt : qword;
begin
    res := oo; tt := 0;
	for u := 1 to n do
	   begin
         temp := min(a[u,x],a[u,y]);
         temp := min(temp,a[u,z]);
         res := oo; vt := 0;
         if (a[u,x]=temp) and (w[dir[u,x]]<res) then
           begin
               res := w[dir[u,x]]; vt := dir[u,x];
           end;
         if (a[u,z]=temp) and (w[dir[u,z]]<res) then
           begin
               res := w[dir[u,z]]; vt := dir[u,z];
           end;
         if (a[u,y]=temp) and (w[dir[u,y]]<res) then
           begin
               res := w[dir[u,y]]; vt := dir[u,y];
           end;
         if vt <> 0 then tt := tt + w[abs(vt)];
	   end;
    writeln(tt*100);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m,ntest);
	for i := 1 to n do
	  for j := 1 to n do
	    if i=j then a[i,j] := 0 else a[i,j] := oo;
	for i := 1 to m do
	   begin
	   	  readln(u,v,l);
	   	  a[u,v] := l; a[v,u] := l;
	   	  ke[i] := v; next[i] := head[u]; w[i] := l; head[u] := i;
	   	  ke[-i] := u; next[-i] := head[v]; w[-i] := l; head[v] := -i;
	   end;
	init;
	while ntest > 0 do
	   begin
          dec(ntest);
	   	  readln(x,y,z);
	   	  main;
	   end;
end.
