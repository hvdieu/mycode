Uses math;
Const
	inp = 'four.inp';
	out = 'four.out';
	maxn = 2001;
	maxa = 1000000;

Type arr = array [1..maxn*maxn] of longint;

Var
	a,s : array [1..maxn] of longint;
	dd : array [-1000000..1000000] of longint;
	res : qword;
    n,i,m1,m2 : longint;

procedure trau;
	var i,j,k,s : longint;
begin
	dd[a[1]] := 1;
	for i := 2 to n do
    begin
	  for j := i+1 to n do
	   for k := j+1 to n do
	     begin
	     	s := a[i]+a[j]+a[k];
	     	if (s >=-maxa) and (s<=maxa) then inc(res,dd[-s]);
	     end;
      inc(dd[a[i]]);
    end;
	writeln(res);
end;

procedure swap(var xx,yy : longint);
var temp : longint;
  begin
      temp := xx; xx := yy; yy := temp;
  end;

procedure sort(l,h : longint);
var i,j,k : longint;
  begin
       if l >= h then exit;
       i := l; j := h; k := a[l+random(h-l+1)];
       repeat
         while (a[i]<k) do inc(i);
         while (a[j]>k) do dec(j);
         if i <= j then
           begin
               swap(a[i],a[j]);
               inc(i); dec(j);
           end;
       until i > j;
       sort(l,j); sort(i,h);
  end;

procedure sub1;
var i,j,m : longint;
  begin
      for i := 1 to n-3 do
        begin
            m := n-i;
            for j := i+1 to n do s[j] := a[i]+a[j];
        end;
  end;

begin
	assign(input,inp); reset(input);
	assign(output,out); rewrite(output);
	readln(n);
	for i := 1 to n do read(a[i]);
	trau;
end.
