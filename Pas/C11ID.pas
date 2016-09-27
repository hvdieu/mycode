Const   inp = '';
        out = '';
        maxn = 100001;
Var     fi,fo   :       text;
        n,i,k       :       longint;
        res     :   int64
        a       :       array [1..maxn] of longint;
{*      *       *       *       *}
Procedure Swap( Var xx,yy : longint);
Var temp : longint;
BEGIN
    temp:=xx;
    xx:=yy;
    yy:=temp;
END;
{*      *       *       *       *}
Procedure Quicksort(L,h : longint);
Var i,j,key : longint;
BEGIN
    if l>=h then exit;
    i:=l;
    j:=h;
    key := a[ (l+h) div 2];
    Repeat
        While a[i] < key do inc(i);
        while a[j] > key do dec(j);
        if i<=j then
          BEGIN
              if i < j then Swap(a[i],a[j]);
              inc(i);
              dec(j);
          END;
                until i > j;
    Quicksort(l,j);
    Quicksort(i,h);
END;
{*      *       *       *       *}
BEGIN
    assign(fi,inp);reset(fi);
    readln(fi,n);
    for i:=1 to n do
     readln(fi,a[i]);
    close(fi);
    Quicksort(1,n);
    k:= 1000000007;
    res:=a[1];
    For i:=2 to n do
       res := (res * (a[i] - i +1)) mod k;
    Assign(fo,out);rewrite(fo);
    write(fo,res);
    close(fo);
END.
