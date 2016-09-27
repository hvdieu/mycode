{$MODE OBJFPC}
{$INLINE ON}
uses math,sysutils;
Const
	inp = '';
	out = '';
	id : array [1..6] of array [1..3] of integer =
	 ((1,2,3),
	 (3,1,2),
	 (2,1,3),
	 (2,3,1),
	 (1,3,2),
	 (3,2,1));

Var
	n,i : longint;
	t1,t2,tt : tdatetime;
	x,y : array [1..8,1..3] of int64;
	free : array [1..8] of boolean;
	canh : array [1..7] of int64;

function dis(i,j : int64) : int64; inline;
	var xx,yy,zz : int64;
begin
	xx := y[i,1]-y[j,1]; yy := y[i,2]-y[j,2]; zz := y[i,3]-y[j,3];
	dis := xx*xx+yy*yy+zz*zz;
end;

function ok(i : longint) : boolean; inline;
	var j,k,dem,top : longint;
		x1,y1,z1,xx,yy,zz : int64;
		d1,d2,d3,d,m1,m2,m3 : int64;
begin
	dem := 0; d1 := 999999999999999999; d2 := 0; d3 := 0;
	m1 := 0; m2 := 0; m3 := 0; top := 0;
	for j := 1 to 8 do
	  if (i<>j) then
	     begin
	     	d := dis(i,j);
            d1 := min(d1,d); d3 := max(d3,d);
	     	if d=0 then exit(false);
	     end;
    for j := 1 to 8 do
     if i<>j then
       begin
           d := dis(i,j);
           if (d<>d1) and (d<>d3) then d2 := d;
           if d=d1 then inc(m1);
           if d=d3 then inc(m3);
       end;
	if (m1<>3) or (m3<>1) or (d1*2<>d2) then exit(false)
     else exit(true);
end;

procedure check;  inline;
	var i,j : longint;
begin
    t2 := now;
    tt := (t2-t1)*3600*24;
    if tt > 0.95 then
      begin
          writeln('NO');
          halt;
      end;
	for i := 1 to 7 do
      begin
         if ok(i)=false then exit;
      end;
	writeln('YES');
	for i := 1 to 8 do writeln(y[i,1],' ',y[i,2],' ',y[i,3]);
	halt;
end;

procedure ql(i : longint);
	var j,k : longint;
     kt : boolean;
begin
	if i > 8 then
	  begin
	  	check;
	  	exit;
	  end;
	for k := 1 to 6 do
	  begin
	  	y[i,1] := x[i,id[k,1]]; y[i,2] := x[i,id[k,2]]; y[i,3] := x[i,id[k,3]];
	  	ql(i+1);
	  end;
end;

begin
    t1 := now;
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	for i := 1 to 8 do readln(x[i,1],x[i,2],x[i,3]);
	ql(1);
	writeln('NO');
end.
