uses math;
const
	inp = 'lstar.inp';
	out = 'lstar.out';
	maxn = 9;
    h : array [1..3] of integer = (0,-1,1);
    c : array [1..3] of integer = (-1,-1,1);

Var
	a,ni,nj : array [0..10,0..10] of integer;
	free : array [1..12] of boolean;
	i,j,dem : longint;
	ch : char;

function check(i,j : longint) : boolean;
    var k,u,v,s,t : longint;
        ok : boolean;
begin
    u := i; v := j;
    ok := true;
    while (a[u+1,v+1]<>-1) do
      begin
          inc(u); inc(v);
      end;
    s := 0;
    for t := 1 to 4 do
      begin
        if a[u,v]<=0 then
         begin
           s := -1;
           break;
         end;
        s := s+a[u,v]; dec(u); dec(v);
      end;
    if (s <> -1) and (s<>26) then exit(false);
    u := i; v := j; s := 0;
    while (a[u,v-2]<>-1) do v := v-2;
    for t := 1 to 4 do
      begin
          if a[u,v]<=0 then
            begin
                s := -1;
                break;
            end;
          s := s+a[u,v]; v := v+2;
      end;
    if (s <>-1) and (s<>26) then exit(false);
    u := i; v := j;
    while (a[u+1,v-1]<>-1) do
      begin
          inc(u); dec(v);
      end;
      s := 0;
      for t := 1 to 4 do
       begin
           if a[u,v]<=0 then
             begin
                 s := -1;
                 break;
             end;
           inc(s,a[u,v]); dec(u); inc(v);
       end;
    if (s<>-1) and (s<>26) then exit(false);
    exit(true);

end;

procedure duyet(i,j : longint);
	var k,ii,jj : longint;
begin
	if (i=5) and (j=9) then
	  begin
	  	 for ii := 1 to 5 do
	  	  begin
	  	   for jj := 1 to 9 do
	  	    begin
	  	    	if a[ii,jj]=-1 then write('.')
	  	    	 else write(chr(ord('A')+a[ii,jj]-1));
	  	    end;
	  	   writeln;
	  	  end;
	  	halt;
	  end;
    if a[i,j]<>0 then duyet(ni[i,j],nj[i,j])
    else
	for k := 1 to 12 do
	 if free[k] then
	   begin
	   	 a[i,j] := k;
	   	 free[k] := false;
	   	 if check(i,j) then
           duyet(ni[i,j],nj[i,j]);
	   	 a[i,j] := 0;
	   	 free[k] := true;
	   end;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	fillchar(free,sizeof(free),true);
    for i := 0 to 6 do
     for j := 0 to 10 do a[i,j] := -1;
	for i := 1 to 5 do
	  begin
	  	for j := 1 to 9 do
	  	  begin
	  	  	read(ch);
	  	  	if ch<>'.' then
	  	  	  begin
	  	  	  	if ch='x' then a[i,j] := 0
	  	  	  	 else
	  	  	  	  begin
	  	  	  	    a[i,j] := ord(ch)-ord('A')+1;
	  	  	  	    free[a[i,j]] := false;
	  	  	  	  end
	  	  	  end
	  	  	else a[i,j] := -1;
	  	  end;
	  	readln;
	  end;

	ni[1,5] := 2; ni[2,2] := 2; ni[2,4] := 2; ni[2,6] := 2; ni[2,8] := 3;
	ni[3,3] := 3; ni[3,7] := 4; ni[4,2] := 4; ni[4,4] := 4; ni[4,6] := 4;
	ni[4,8] := 5; ni[5,5] := 5;
	nj[1,5] := 2; nj[2,2] := 4; nj[2,4] := 6; nj[2,6] := 8; nj[2,8] := 3;
    nj[3,3] := 7;
	nj[3,7] := 2; nj[4,2] := 4; nj[4,4] := 6; nj[4,6] := 8;
	nj[4,8] := 5; nj[5,5] := 9;
	for i := 1 to 5 do
	  for j := 1 to 9 do
	    if a[i,j]=0 then duyet(i,j);

	for i := 1 to 5 do
	 begin
	 for j := 1 to 9 do
	   begin
	  	   if a[i,j]=-1 then write('.')
	  	     else write(chr(ord('A')+a[i,j]-1));
	   end;
	  writeln;
	 end;
end.
