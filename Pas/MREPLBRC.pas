Uses math;
Const
	inp = 'zapis.in.10';
	out = 'asd.out';
	maxn = 201;
	oo = 100000;

Var
	n,kq,i : longint;
	s : string;
	f : array [1..maxn,1..maxn] of longint;
	a : array [1..200] of integer;
	check : array [1..maxn,1..maxn] of boolean;
	ok : boolean;

function tinh(i,j : longint) : longint;
	var k,res : longint;
        x,y : int64;
begin
    if i=j then exit(0);
	if j+1=i then exit(1);
    if i+1=j then
      begin
       if ((a[i]>0) and (a[j]>0) and (a[j]-a[i]=1)) or
	     ((a[i]=0) and ((a[j]>0) and (a[j] mod 2=0))) or
	     ((a[i] mod 2=1) and (a[j]=0)) then exit(1)
          else if (a[i]=0) and (a[j]=0) then exit(3)
          else exit(0);
      end;
    if (j-i+1) mod 2=1 then exit(0);
	if ((a[i]>0) and (a[i] mod 2=0)) or ((a[j]>0) and (a[j] mod 2=1)) then exit(0);
    if check[i,j] then exit(f[i,j]);
	res := 0;
	for k := i+1 to j do
	  if ((a[i]>0) and (a[k]>0) and (a[k]-a[i]=1)) or
	     ((a[i]=0) and ((a[k]>0) and (a[k] mod 2=0))) or
	     ((a[i] mod 2=1) and (a[k]=0)) then
	   begin
       x := tinh(i+1,k-1); y := tinh(k+1,j);
       x := x*y;
       if x >= oo then ok := true;
       x := x mod oo;
       res := res + x;
       if res >= oo then
         begin
         	ok := true;
         	res := res mod oo;
         end;
       end
      else if (a[i]=0) and (a[k]=0) then
        begin
             x := tinh(i+1,k-1);
             y := tinh(k+1,j);
             x := x*y*3;
             if x >= oo then ok := true;
             x := x mod oo;
            res := res + x;
            if res >= oo then
              begin
                  ok := true;
                  res := res mod oo;
              end;
        end;
    check[i,j] := true;
    f[i,j] := res;
    exit(f[i,j]);
end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	readln(s);
	for i := 1 to n do
	  	case s[i] of
	  	'(' : a[i] := 1;
	  	')' : a[i] := 2;
		'{' : a[i] := 3;
		'}' : a[i] := 4;
		'[' : a[i] := 5;
		']' : a[i] := 6;
		'?' : a[i] := 0;
	    end;
	kq := tinh(1,n);
	if ok=false then write(kq)
	 else begin
	 	str(kq,s);
	 	while length(s) < 5 do s := '0'+s;
	 	writeln(s);
	 end;
end.
