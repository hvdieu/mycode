Const   maxn = 500001;
Type    arr = array [1..4*maxn] of longint;
Var     n,res       :       longint;
        a,b,c   :       array [1..maxn] of longint;
        t1,t2   :       arr;

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
                         swap(b[i],b[j]);
                         swap(c[i],c[j]);
                       end;
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j,k); sort(i,h,k);
        end;

procedure main;
var i,j,x,y : longint;
        begin
              for i := 1 to n do
                begin
                    x := truyvan(1,1,n,1,b[i]-1,t1);
                    y := truyvan(1,1,n,1,c[i]-1
                end;
        end;


begin
      assign(input,'team.inp'); reset(input);
      assign(output,'team.out'); rewrite(output);
      readln(n);
      for i := 1 to n do read(a[i]);
      for i := 1 to n do read(b[i]);
      for i := 1 to n do read(c[i]);
      sort(1,n,a);
end.