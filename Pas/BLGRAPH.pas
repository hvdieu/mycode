Uses math;
Const
	inp = 'as.inp';
	out = 'asd.out';
	maxn = 1001;

Var
	n,m,col,u,v,temp,top,sl,i,k : longint;
	head,mau,st : array [1..maxn] of longint;
	ke,next : array [-maxn*maxn..maxn*maxn] of longint;

function find(col : longint) : longint;
	var i,j,u,v,temp,x : longint;
		ok : boolean;
begin
		temp := -1; u := 0;
		for i := 1 to n do
		  if mau[i]=0 then
		    begin
		    	j := head[i]; x := 0;
		    	ok := true;
		    	while j <> 0 do
		    	  begin
		    	  	v := ke[j];
		    	  	if mau[v]=0 then inc(x)
		    	  	 else if mau[v]=col then ok := false;
		    	  	j := next[j];
		    	  end;
		    	if (x > temp) and ok then
		    	  begin
		    	  	temp := i; u := i;
		    	  end;
		    end;
		exit(u);
end;

procedure main;
	var i,j,u,v,temp : longint;
begin
	sl := n;
	repeat
		inc(col);
		repeat
			u := find(col);
			if u = 0 then break;
			mau[u] := col; dec(sl);
		until false;
	until sl=0;
    if col <= k then for i := 1 to n do write(mau[i],' ')
     else writeln(-1);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,m,k);
	for i := 1 to m do
	  begin
	  	readln(u,v);
	  	ke[i] := v; next[i] := head[u]; head[u] := i;
	  	ke[-i] := u; next[-i] := head[v]; head[v] := -i;
	  end;
	main;
end.
