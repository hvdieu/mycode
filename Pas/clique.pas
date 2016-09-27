Uses math;
Const
	inp = 'clique.inp';
	out = 'clique.out';
	maxn = 610;

Var
	n,m,k,ntest,u,v,i : longint;
	ke : array [1..maxn] of int64;
	deg : array [1..maxn] of longint;
    a : array [1..maxn,1..maxn] of longint;
	found : boolean;

procedure duyet(i : longint; w : int64);
	var j,dem : longint;
begin
	if found then exit;
	if i > k then
	  begin
	  	found := true;
	  	for j := 0 to n-1 do
	  	 if (w shr j) and 1 = 1 then write(j+1,' ');
	  	 writeln;
	  	exit;
	  end;
    dem := 0;
	for j := 0 to n-1 do
     begin
	  if (w shr j) and 1 = 0 then
       begin
         if deg[j+1] >= k-1 then
	     if ke[j+1] and w = w then duyet(i+1,w or (int64(1) shl j));
       end;
     end;
end;

procedure sub2;
    var i,j : longint;
        dd : array [1..maxn] of boolean;
begin
    fillchar(dd,sizeof(dd),true);
    for i := 1 to n do
     for j := 1 to i-1 do
      if (a[i][j] = 0) and dd[i] and dd[j] then
        begin
            dd[i] := false; dd[j] := false;
        end;
    for i := 1 to n do
      begin
          if k = 0 then break;
          if dd[i] then
            begin
                write(i,' ');
                dec(k);
            end;
      end;
    writeln;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(ntest);
	while ntest > 0 do
	   begin
	   	  dec(ntest);
	   	  fillchar(ke,sizeof(ke),0);
	   	  fillchar(deg,sizeof(deg),0);
          fillchar(a,sizeof(a),0);
	   	  found := false;
	   	  read(n,m,k);
	   	  for i := 1 to m do
	   	    begin
	   	    	readln(u,v);
                a[u][v] := 1; a[v][u] := 1;
	   	    	if (n <= 60) then
                begin
                  ke[u] := ke[u] or int64(1) shl (v-1);
	   	    	  inc(deg[u]); inc(deg[v]);
	   	    	  ke[v] := ke[v] or int64(1) shl (u-1);
                end;
 	   	    end;
 	   	  if n <= 60 then
            begin
              duyet(1,0);
 	   	      if found = false then writeln(-1);
            end
          else sub2;
	   end;
end.
