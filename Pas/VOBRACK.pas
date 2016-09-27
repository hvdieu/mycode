{$H+}
Uses math;
const
	inp = 'VOBRACK.INP';
	out = 'VOBRACK.OUT';
	maxn = 1001;
	maxm = 10001;
    oo = 999999;

Var
	n,m,bound,top : longint;
	s : array [1..maxn] of string;
	a,b,c : array [1..maxn] of longint;
    //s1 : array [1..maxn] of string;
	st : array [1..maxm] of string;
	f : array [0..1,0..maxm] of longint;
	res : longint;

procedure nhap;
	var i,j : longint;
begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do readln(s[i]);
end;

procedure init;
	var i,j : longint;
		ss : string;
begin
	for i := 1 to n do
		begin
			top := 0;
			for j := 1 to length(s[i]) do
				begin
					if s[i][j]='(' then
						begin
							inc(top); st[top] := s[i][j];
						end
					else if (top>=1) and (st[top]='(') then dec(top)
						else begin inc(top); st[top] := s[i][j] end;
				end;
            if top=0 then res := res + length(s[i])
				else
				begin
					inc(m); a[m] := length(s[i]); ss := '';
 				for j := 1 to top do if st[j]='(' then inc(b[m]);
					c[m] := top-b[m];
                if c[m]=0 then c[m] := -oo;
                if b[m]=0 then b[m] := -oo;
            //    for j := 1 to top do ss := ss+st[j];
            //        s1[m] := ss;
				end;
		end;
end;

procedure swap(var xx,yy : longint);
	var temp : longint;
begin
	temp := xx; xx := yy; yy := temp;
end;

procedure dc(var xx,yy : string);
    var temp : string;
begin
    temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint);
	var i,j,k,key : longint;
begin
	if l >= h then exit;
	i := l; j := h; k := l+random(h-l+1); key := c[k]-b[k];
	repeat
		while c[i]-b[i]<key do inc(i);
		while c[j]-b[j]>key do dec(j);
		if i <= j then
			begin
				swap(a[i],a[j]);
				swap(b[i],b[j]);
				swap(c[i],c[j]);
               // dc(s1[i],s1[j]);
				inc(i); dec(j);
			end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure main();
	var i,j,t,jj,tg : longint;
begin
	sort(1,m);
	t := 1; bound := 0;
    for i := 1 to m do
      begin
          if b[i]=-oo then b[i] := 0;
          if c[i]=-oo then c[i] := 0;
      end;
	for i := 1 to m do
	  begin
        tg := 0;
        for j := 0 to bound do f[t,j] := f[1-t,j];
		for j := c[i] to bound do
		  if (j=0) or ((j<>0) and (f[1-t,j]<>0)) then
		    begin
		    	jj := j-c[i]+b[i];
                tg := max(tg,jj);
		    	f[t,jj] := max(f[t,jj],f[1-t,j]+a[i]);
		    end;
        bound := max(bound,tg);
		t := 1-t;
	  end;
    t := 1-t;
	res := res + f[t,0];
	writeln(res);
end;

begin
	nhap;
	init;
	main;
end.
