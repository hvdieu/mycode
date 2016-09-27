Uses math;
Const
    inp = 'roirac.inp';
    out = 'roirac.out';
    maxn = 20;

Type
    arr = array [0..maxn] of longint;

Var
    i,j : longint;
    n,dem : longint;
    a,b,id : array [0..maxn] of longint;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint; var k : arr);
var i,j,key : longint;
        begin
            if l >= h then exit;
            i := l; j := h; key := k[l+random(h-l+1)];
            repeat
               while k[i] < key do inc(i);
               while k[j] > key do dec(j);
               if i <= j then
                 begin
                     if i < j then
                       begin
                         swap(k[i],k[j]);
                         swap(id[i],id[j]);
                       end;
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j,k); sort(i,h,k);
        end;



begin
    assign(input,inp); reset(input);
    assign(output,out) ;rewrite(output);
    readln(n);
    for i := 1 to n do read(a[i]);
    for i := 1 to n do id[i] := i;
    sort(1,n,a);
    dem := 0;
    for i := 1 to n do
     begin
         if a[i]<>a[i-1] then inc(dem);
         b[id[i]] := dem;
     end;
    for i := 1 to n do write(b[i],' ');
end.