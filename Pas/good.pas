Uses math;
Const
	inp = 'good.inp';
	out = 'good.out';

Var
	n,k,res,i,t1,t2 : longint;
	f : array [1..10,0..1,0..1,0..9,0..10000] of longint;
	check : array [1..10,0..1,0..1,0..9,0..10000] of boolean;
	mu : array [0..9] of longint;
	s : string;

function kt(k : longint) : boolean;
	var i,j : longint;
        ok : boolean;
		s : string;
begin
	str(k,s);
    ok := true;
	if length(s)=1 then exit(false);
	j := 1;
	while (j<length(s)) and (s[j]<=s[j+1]) do inc(j);
	if j=length(s) then
     begin
       inc(t1); ok := false;
     end;
	j := 1;
	while (j<length(s)) and (s[j]>=s[j+1]) do inc(j);
	if j=length(s) then
    begin
      inc(t2); ok := false;
    end;
	exit(ok);
end;

procedure trau;
	var i,j,kk : longint;
	    s : string;
begin
	kk := k;
	while kk < n do
	  begin
	  	 if kt(kk) then inc(res);
	  	 kk := kk+k;
	  end;
	writeln(res);
end;

function tinh(i,ok1,ok2,cs,du : longint) : longint;
	var j,d,c,o1,o2,res,d1,cs1 : longint;
begin
	if i > length(s) then
	  begin
	  	if (ok1=1) and (du=0) then exit(1)
	  	 else exit(0);
	  end;
	if check[i,ok1,ok2,cs,du] then exit(f[i,ok1,ok2,cs,du]);
    if ok2 = 1 then c := 9
     else val(s[i],c);
    val(s[i],cs1);
	res := 0;
	for j := cs to c do
	  begin
	  	 if (ok1=1) or (j<>0) then o1 := 1
	  	  else o1 := 0;
	  	 if (j<cs1) or (ok2=1) then o2 := 1
	  	  else o2 := 0;
	  	 res := res + tinh(i+1,o1,o2,j,(du*10+j) mod k);
	  end;
	f[i,ok1,ok2,cs,du] := res;
	check[i,ok1,ok2,cs,du] := true;
	exit(res);
end;

function tinh1(i,ok1,ok2,cs,du : longint) : longint;
	var j,d,c,o1,o2,res,d1,cs1 : longint;
begin
	if i > length(s) then
	  begin
	  	if (ok1=1) and (du=0) then exit(1)
	  	 else exit(0);
	  end;
	if check[i,ok1,ok2,cs,du] then exit(f[i,ok1,ok2,cs,du]);
	if ok2=1 then c := cs
	 else
       begin
           val(s[i],c);
           c := min(c,cs);
       end;
	res := 0; val(s[i],cs1);
	for j := 0 to c do
	  begin
	  	 if (ok1=1) or (j<>0) then o1 := 1
	  	  else o1 := 0;
	  	 if (j<cs1) or (ok2=1) then o2 := 1
	  	  else o2 := 0;
	  	 if o1=0 then res := res + tinh1(i+1,o1,o2,9,du)
          else res := res + tinh1(i+1,o1,o2,j,(du*10+j) mod k);
	  end;
	f[i,ok1,ok2,cs,du] := res;
	check[i,ok1,ok2,cs,du] := true;
	exit(res);
end;

procedure main;
	var i,j,tg1,tg2,tg3,num,jj,tong : longint;
begin
	str(n-1,s);
	tg1 := tinh(1,0,0,0,0);
    for i := 1 to 9 do if i mod k = 0 then dec(tg1);
	fillchar(check,sizeof(check),false);
	tg2 := tinh1(1,0,0,9,0);
    for i := 1 to 9 do if i mod k = 0 then dec(tg2);
    tg3 := 0;
	for i := 2 to length(s) do
	  begin
	  	 for j := 1 to 9 do
 			begin
 				num := 0;
 				for jj := 1 to i do num := num*10+j;
 				if (num mod k=0) and (num<n) then inc(tg3);
 			end;
	  end;
    tong := (n-1) div k;
    for i := 1 to 9 do if i mod k = 0 then dec(tong);
	writeln(tong-tg1-tg2+tg3);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,k);
	res := 0;
	mu[0] := 1;
    for i := 1 to 9 do mu[i] := mu[i-1]*10;
     if (k >= 10000) or (n<=100000) then trau else
    main;
end.
