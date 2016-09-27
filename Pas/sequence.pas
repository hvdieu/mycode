Uses math;
Const
	inp = 'sequence.inp';
	out = 'sequence.out';
	maxn = 301;

Var
	f : array [1..maxn,1..maxn,0..maxn] of qword;
	check : array [1..maxn,1..maxn,0..maxn] of boolean;
	n,i,j,jj,k : longint;
	s,a : array [0..maxn] of longint;

function max(x,y : qword) : qword;
begin
    if x > y then exit(X) else exit(y);
end;

function tinh(i,j,k : longint) : longint;
	var ii,jj,t,kk,da,db,d : longint;
		cp : qword;
begin
	if check[i,j,k] then exit(f[i,j,k]);
	if k=1 then exit(0);
	for t := i to j-1 do
       begin
         	da := t-i+1; db := j-t; cp := (s[t]-s[i-1])*(s[j]-s[t]);
            if k-db < 1 then d := 1 else d := k-db;
         	for kk := d to min(da,k-1) do
         	 f[i,j,k] := max(f[i,j,k],cp+tinh(i,t,kk)+tinh(t+1,j,k-kk));
       end;
    check[i,j,k] := true;
    exit(f[i,j,k]);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n,k);
	for i := 1 to n do
	  begin
	  	read(a[i]);
	  	s[i] := s[i-1]+a[i];
	  end;
	writeln(tinh(1,n,k+1));
end.
