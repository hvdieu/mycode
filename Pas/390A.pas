Const   inp = '';
        out = '';
        maxn = 100001;

Type    arr = array [1..maxn] of longint;

Var     n,res,dem,i       :       longint;
        x,y     :       arr;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint; var x,y : arr);
var i,j,key : longint;
        begin
            if l >= h then exit;
            i := l; j := h; key := x[l+random(h-l+1)];
            repeat
               while x[i] < key do inc(i);
               while x[j] > key do dec(j);
               if i <= j then
                 begin
                     if i < j then
                      begin
                        swap(x[i],x[j]);
                        swap(y[i],y[j]);
                      end;
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j,x,y); sort(i,h,x,y);
        end;
begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(n);
     for i := 1 to n do
       begin
           read(x[i],y[i]);
       end;
     sort(1,n,x,y);
     res := 1;
     for i := 2 to n do
      if x[i]<>x[i-1] then inc(res);
     sort(1,n,y,x);
     dem:=1;
     for i := 2 to n do
      if y[i]<>y[i-1] then inc(dem);
     if dem<res then res :=dem;
     writeln(res);
end.