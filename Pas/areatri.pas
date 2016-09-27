{$Coperators ON}
Uses math;
const
	inp = 'tro2d.in';
	out = 'areatri.out';
	maxn = 1001;
    eps = 0.000000001;

Type
	arr = array [1..maxn] of double;

Var
	n,i,m : longint;
	goc,a,b,x,y,x1,y1 : array [1..maxn] of double;
	a1,b1,c1 : double;
	res : extended;

function tinhgoc(x,y : double) : double;
	var o : double;
begin
	if x=0 then
	  begin
	  	 if y=0 then exit(0);
	  	 if y>0 then exit(pi/2)
	  	  else exit((3/2)*pi);
	  end;
	if y=0 then
	  begin
	  	  if x > 0 then exit(0)
	  	   else exit(pi)
	  end;
	o := abs(arctan(y/x));
	if x > 0 then
	  begin
	  	if y > 0 then exit(o)
	  	 else exit(2*pi-o)
	  end
	else begin
		if y > 0 then exit(pi-o)
		 else exit(pi+o);
	end;
end;

procedure swap(var xx,yy : double);
	var temp : double;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint;var goc,a,b : arr);
	var i,j : longint;
		k : double;
begin
	if l >= h then exit;
	i := l; j := h; k := goc[l+random(h-l+1)];
	repeat
		while goc[i]<k do inc(i);
		while goc[j]>k do dec(j);
		if i <= j then
		  begin
		  	swap(goc[i],goc[j]);
		  	swap(a[i],a[j]);
		  	swap(b[i],b[j]);
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j,goc,a,b); sort(i,h,goc,a,b);
end;

procedure xay(x1,y1,x2,y2 : double);
begin
	a1 := (y2-y1); b1 := (x1-x2); c1 := -x1*(y2-y1)+y1*(x2-x1);
end;

function cungphia(x1,y1,x2,y2 : double) : boolean;
begin
	if (a1*x1+b1*y1+c1)*(a1*x2+b1*y2+c1) > 0 then exit(true)
	 else exit(false);
end;

function distance(x,y,z : double) : double;
begin
	distance := abs(a1*x+b1*y+c1*z)/sqrt(sqr(a1)+sqr(b1));
end;

function dd(x1,y1,x2,y2 : double) : double;
begin
    dd := sqrt(sqr(x1-x2)+sqr(y1-y2));
end;

function ccw(x1,y1,x2,y2,x3,y3 : double) : integer;
    var a1,b1,a2,b2,t : double;
begin
    a1 := x2-x1;
    b1 := y2-y1;
    a2 := x3-x1;
    b2 := y3-y1;
    t := a1*b2-a2*b1;
    if abs(t) < eps then ccw := 0
     else if t > 0 then ccw := -1
      else ccw := 1;
end;

procedure main;
	var i,j,u,v : longint;
		s1x,s1y,s2x,s2y,xx,yy,l,s1z,s2z,temp,o : double;
begin
	res := 0;
    for i := 1 to n do
	  begin
	     m := 0;
	  	 for j := 1 to n do
	  	  if i<>j then
	  	    begin
	  	    	inc(m);
	  	    	xx := (x[j]-x[i]); yy := (y[j]-y[i]);
	  	    	goc[m] := tinhgoc(xx,yy);
	  	    	a[m] := x[j]; b[m] := y[j];
	  	    end;
	  	 sort(1,m,goc,a,b);
	  	 for j := 1 to m do
	  	   if goc[j] < pi then
	  	     begin
	  	     	x1[j] := a[j]; y1[j] := b[j];
	  	     end
	  	   else begin
	  	   	goc[j] -= pi; x1[j] := x[i]*2-a[j]; y1[j] := y[i]*2-b[j];
	  	   end;
	  	 sort(1,m,goc,x1,y1);
	  	 s1x := x[i]; s1y := y[i]; s2x := x[i]; s2y := y[i];
         s1z := 1; s2z := 1;
	  	 xay(x[i],y[i],x1[1],y1[1]);
         l := dd(x[i],y[i],x1[1],y1[1]);
         v := m+1; u := 1;
         for j := 1 to m do
           begin
            if ccw(x[i],y[i],x1[1],y1[1],a[j],b[j]) <= 0 then
              begin
                  s1x+=a[j]; s1y+=b[j]; s1z+=1;
              end else begin
                     s2x+=a[j]; s2y+=b[j]; s2z+=1;
                     v := min(v,j);
         	      end;
            end;
	  	 res := res+l*(distance(s1x,s1y,s1z)+distance(s2x,s2y,s2z))/2;
	  	 for j := 2 to m do
	  	   begin
                l := dd(x[i],y[i],x1[j],y1[j]);
	  	   	    xay(x[i],y[i],x1[j],y1[j]);
	  	   	    while (u<=m) and (ccw(x[i],y[i],x1[j],y1[j],a[u],b[u])=1) do
	  	   	    begin
                   s1x-=a[u]; s1y-=b[u]; s1z-=1;
                   s2x+=a[u]; s2y+=b[u]; s2z+=1;
                   inc(u);
                end;
	  	   	    while (v<=m) and (ccw(x[i],y[i],x1[j],y1[j],a[v],b[v])<>1) do
	  	   	      begin
	  	   	      	 s1x+=a[v]; s1y+=b[v]; s1z+=1;
	  	   	      	 s2x-=a[v]; s2y-=b[v]; s2z-=1;
	  	   	      	 inc(v);
	  	   	      end;
	  	   	    res += l*(distance(s1x,s1y,s1z)+distance(s2x,s2y,s2z))/2;
	  	   end;

	  end;
	writeln(res/6:0:1);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do read(x[i],y[i]);
	main;
end.
