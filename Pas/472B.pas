Uses math;
Const
    inp = 'as.inp';
    out = 'asd.out';
    maxn = 2001;

type arr = array [1..maxn] of longint;

Var
    a : array [1..maxn] of longint;
    n,k,i,j,t,res,temp : longint;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,key : longint;
        begin
            if l >= h then exit;
            i := l; j := h; key := a[l+random(h-l+1)];
            repeat
               while a[i] > key do inc(i);
               while a[j] < key do dec(j);
               if i <= j then
                 begin
                     if i < j then swap(a[i],a[j]);
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j); sort(i,h);
        end;

begin
   // assign(input,inp); reset(input);
   // assign(output,out); rewrite(output);
    readln(n,k);
    for i := 1 to n do read(a[i]);
    sort(1,n);
    i := 1;
    while i <= n do
      begin
          j := min(i+k-1,n);
          temp := 0;
          for t := i to j do temp := max(temp,a[t]);
          res := res + 2*(temp-1);
          i := j+1;
      end;
    writeln(res);
    readln;
end.