Uses math;
const
	inp = 'cstars.inp';
	out = 'cstars.out';
	maxn = 16;

Var
	b,st : array [1..maxn] of longint;
	a,ni,nj : array [0..maxn,0..maxn] of longint;
	free : array [1..maxn] of boolean;
	res : int64;
    i,j : longint;

procedure swap(var xx,yy : longint);
    var temp : longint;
begin
    temp := xx; xx := yy; yy := temp;
end;

procedure init;
    var i,j,k,t : longint;
begin
	ni[1,5] := 3; nj[1,5] := 7;
	ni[2,2] := 2; nj[2,2] := 4; ni[2,4] := 2; nj[2,4] := 6;
	ni[2,6] := 2; nj[2,6] := 8; ni[2,8] := 1; nj[2,8] := 5;
	ni[3,7] := 4; nj[3,7] := 8; ni[4,8] := 3; nj[4,8] := 3;
	ni[3,3] := 4; nj[3,3] := 2; ni[4,2] := 4; nj[4,2] := 4;
	ni[4,4] := 4; nj[4,4] := 6; ni[4,6] := 5; nj[4,6] := 5;
	ni[5,5] := 5; nj[5,5] := 9;
	for i := 0 to 6 do
	 for j := 0 to 10 do a[i,j] := -1;
	a[1,5] := 0; a[2,2] := 0; a[2,4] := 0; a[2,6] := 0; a[2,8] := 0;
	a[3,3] := 0; a[3,7] := 0; a[4,2] := 0; a[4,4] := 0; a[4,6] :=0;
	a[4,8] := 0; a[5,5] := 0;
	fillchar(free,sizeof(free),true);
end;

function check : boolean;
	var i,j,top,sum,x : longint;
begin
    sum := -1;
	if (a[1,5]<>0) and (a[2,4]<>0) and (a[3,3]<>0) and (a[4,2]<>0) then
	  begin
	  	 x := a[1,5]+a[2,4]+a[3,3]+a[4,2];
         sum := x;
	  end;
	if (a[2,2]<>0) and (a[2,4]<>0) and (a[2,6]<>0) and (a[2,8]<>0) then
	  begin
	  	 x := a[2,2]+a[2,4]+a[2,6]+a[2,8];
         if sum=-1 then sum := x
          else if x <> sum then exit(false);
	  end;
	if (a[1,5]<>0) and (a[2,6]<>0) and (a[3,7]<>0) and (a[4,8]<>0) then
	  begin
	  	 x := a[1,5]+a[2,6]+a[3,7]+a[4,8];
         if sum=-1 then sum := x
          else if x <> sum then exit(false);
	  end;
	if (a[4,2]<>0) and (a[4,4]<>0) and (a[4,6]<>0) and (a[4,8]<>0) then
	  begin
	  	 x := a[4,2]+a[4,4]+a[4,6]+a[4,8];
         if sum=-1 then sum := x
          else if x <> sum then exit(false);
	  end;
	if (a[2,2]<>0) and (a[3,3]<>0) and (a[4,4]<>0) and (a[5,5]<>0) then
	  begin
	  	 x := a[2,2]+a[3,3]+a[4,4]+a[5,5];
         if sum=-1 then sum := x
          else if x <> sum then exit(false);
	  end;
	if (a[2,8]<>0) and (a[3,7]<>0) and (a[4,6]<>0) and (a[5,5]<>0) then
	  begin
	  	 x := a[2,8]+a[3,7]+a[4,6]+a[5,5];
         if sum=-1 then sum := x
          else if x <> sum then exit(false);
	  end;
	exit(true);
end;

procedure duyet(i,j : longint);
	var k,ii,jj : longint;
begin
	if (i=5) and (j=9) then
	  begin
	  	inc(Res);
       { for ii := 1 to 5 do
         for jj := 1 to 9 do
          if a[ii,jj]>0 then write(a[ii,jj],' ');
         writeln; }
	  	exit;
	  end;
	for k := 1 to 12 do
	 if free[k] then
	   begin
	   	  free[k] := false; a[i,j] := b[k];
	   	  if check then
            duyet(ni[i,j],nj[i,j]);
	   	  free[k] := true; a[i,j] := 0;
	   end;
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	for i := 1 to 12 do read(b[i]);
    init;
	duyet(2,2);
	writeln(res div 12);
end.
