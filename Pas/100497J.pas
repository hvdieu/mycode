uses math;
const
	inp = 'gym.inp';
	out = 'gym.out';
	maxn = 30001;

Var
	n,q,t,count,i,j,k,cnt : longint;
	s : string;
	d,d1 : array [0..maxn*30,'a'..'z'] of longint;
	stt,f : array [0..maxn*30] of longint;
	s1,s2,s3 : array [1..maxn] of string;
	kq,vt,b,id : array [0..maxn] of longint;
	res : int64;
    ok : boolean;

procedure sort(l,h : longint);
	var i,j,t2 : longint;
		k,t1 : string;
begin
	if l >= h then exit;
	i := l; j := h; k := s3[l+random(h-l+1)];
	repeat
		while s3[i] < k do inc(i);
		while s3[j] > k do dec(j);
		if i <= j then
		  begin
		  	t1 := s3[i]; s3[i] := s3[j]; s3[j] := t1;
		  	t2 := id[i]; id[i] := id[j]; id[j] := t2;
		  	inc(i); dec(j);
		  end;
	until i>j;
	sort(l,j); sort(i,h);
end;

procedure sort2(l,h : longint);
	var i,j,k,t2 : longint;
		t1 : string;
begin
	if l >= h then exit;
	i := l; j := h; k := kq[l+random(h-l+1)];
	repeat
		while kq[i] < k do inc(i);
		while kq[j] > k do dec(j);
		if i <= j then
		  begin
		  	 t1 := s2[i]; s2[i] := s2[j]; s2[j] := t1;
		  	 t2 := kq[i]; kq[i] := kq[j]; kq[j] := t2;
		  	 t2 := vt[i]; vt[i] := vt[j]; vt[j] := t2;
		  	 inc(i); dec(j);
		  end;
	until i>j;
	sort2(l,j); sort2(i,h);
end;

procedure push(s : string);
	var i,t : longint;
begin
	t := 0;
	for i := 1 to length(s) do
	  begin
	  	if d[t,s[i]] = 0 then
	  	  begin
	  	  	inc(count); d[t,s[i]] := count;
	  	  	t := count; inc(f[t]);
	  	  end
	  	else begin
	  	  t := d[t,s[i]]; inc(f[t]);
		 end;
	  end;
end;

procedure push1(j : longint;s : string);
	var i,t : longint;
begin
	t := 0;
	for i := 1 to length(s) do
	  begin
	  	if d1[t,s[i]] = 0 then
	  	  begin
	  	  	inc(cnt); d1[t,s[i]] := cnt;
	  	  	t := cnt;
	  	  end
	  	else begin
	  	  t := d1[t,s[i]];
		 end;
	  end;
	stt[t] := j;
end;

function find(s : string) : longint;
	var d,c,mid,i,t : longint;
begin
	t := 0;
	for i := 1 to length(s) do
	  begin
	  	if d1[t][s[i]] = 0 then exit(n);
	  	t := d1[t][s[i]];
	  end;
    exit(stt[t]);
end;

begin
   // assign(input,inp) ;reset(input);
   // assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do readln(s1[i]);
	for i := 1 to n do
	  begin
	  	//s3[i] := s1[i];
	  	id[i] := i;
        push1(i,s1[i]);
	  end;
   //sort(1,n);
	readln(q);
	for i := 1 to q do
	  begin
	    readln(s2[i]);
	    j := find(s2[i]);
	    kq[i] := j; vt[i] := i;
	  end;
	sort2(1,q);
	j := 1;
	for i := 1 to q do
	  begin
	    b[vt[i]] := kq[i];
	  	while (j<=kq[i]) do
	  	  begin
	  	  	push(s1[j]);
			inc(j);
	  	  end;
	  	t := 0;
	    s := s2[i];
	  	for k := 1 to length(s) do
	  	  begin
	  	  	if d[t][s[k]]=0 then break;
	  	  	t := d[t][s[k]];
	  	  	b[vt[i]] := b[vt[i]]+f[t];
	  	  end;
	  end;
	for i := 1 to q do writeln(b[i]);
end.
