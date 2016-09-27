{$MODE OBJFPC}
Const   inp = '';
        out = '';
        maxn = 25001;
Type    arr     =       array [1..maxn] of longint;
Var     fi,fo   :       text;
        a,b     :       arr;
        res     :       qword;
        x,y,n   :       longint;

Procedure swap(var xx,yy : longint);
Var temp : longint;
        BEGIN
             temp := xx; xx := yy; yy := temp;
        END;

Procedure sort(l,h : longint;Var a : arr);
Var i,j,key : longint;
        BEGIN
              if l >= h then exit;
              i := l; j := h; key := a[(l+h) div 2];
              Repeat
                 While a[i] < key do inc(i);
                 While a[j] > key do dec(j);
                 if i <= j then
                   BEGIN
                         swap(a[i],a[j]);
                         inc(i); dec(j);
                   END;
              Until i > j;
              sort(l,j,a); sort(i,h,a);
        END;

Procedure main;
Var i,j : longint;
        BEGIN
              res := 0;
              assign(fi,inp); reset(fi);
              readln(fi,n,x,y);
              for i := 1 to n do readln(fi,a[i],b[i]);
              close(fi);
              sort(1,n,a); sort(1,n,b);
              For i := 1 to n do
                BEGIN
                      if a[i] < b[i] then res := res + (b[i] - a[i]) * x
                        else res := res + (a[i] - b[i]) * y;
                END;
              assign(fo,out); rewrite(fo);
              write(fo,res);
              close(fo);
        END;

BEGIN
      main;
END.