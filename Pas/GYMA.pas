uses math;
Const
    inp = 'a.inp';
    out = 'a.out';
    maxn = 2001;

Var
    res,l,w,x : double;
    a : array [1..maxn] of double;
    n,i,j : longint;

procedure swap(var xx,yy : double);
    var temp : double;
begin
    temp := xx; xx := yy; yy := temp;
end;

procedure sort(l,h : longint);
    var i,j : longint;
        k : double;
begin
    if l >= h then exit;
    i := l; j := h; k := a[l+random(h-l+1)];
    repeat
       while a[i] < k do inc(i);
       while a[j] > k do dec(j);
       if i <= j then
         begin
             swap(a[i],a[j]);
             inc(i); dec(j);
         end;
    until i > j;
    sort(l,j); sort(i,h);
end;

begin
  //  assign(input,inp); reset(input);
  //  assign(output,out) ;rewrite(output);
    readln(n);
    readln(L,w);
    for i := 1 to n do read(a[i]);
    sort(1,n);
    res := 0;
    res := res + min(a[1]+sqrt(a[2]*a[2]+w*w),a[2]+sqrt(a[1]*a[1]+w*w));
    res := res + min(l-a[n]+sqrt((l-a[n-1])*(l-a[n-1])+w*w),l-a[n-1]+(l-a[n])*(l-a[n])+w*w);
    for i := 3 to n-3 do
      begin
          x := a[i+1]-a[i];
          res := res + min(sqrt(x*x+w*w),x/2+sqrt(x*x/4+w*w));
      end;
    writeln(res:0:10);
end.