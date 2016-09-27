Const   inp = '';
        out = '';
        maxn = 1001;
Var     fi,fo   :       text;
        n,m,i,t,sum,kq,s   :       longint;
        res     :       int64;
        p       :       array [1..maxn] of longint;
{*      *       *       *       *}
Procedure Swap( Var xx, yy : longint);
Var temp : longint;
BEGIN
temp:=xx;
xx:=yy;
yy:=temp;
END;
{*      *       *       *       *}
Procedure Quicksort( l,H : longint);
Var i,j,key : longint;
BEGIN
    if l>=h then exit;
    i:=l;
    j:=h;
    key := p [ (l+h) div 2];
    Repeat
       While p[i] < key do inc(i);
       while p[j] > key do dec(j);
       if i<=j then
          BEGIN
              if i<j then swap(p[i],p[j]);
              inc(i);
              dec(j);
          END;
            Until i>j;
    Quicksort(L,j);
    Quicksort(i,H);
END;
{*      *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n,m);
    For i:=1 to m do readln(fi,p[i]);
    close(fi);
    Quicksort(1,m);
    res:=0;
    For i:=1 to m do
      BEGIN
          t:= p[i];
          s:= m- i + 1;
          if s > n then s:=n;
          sum := t * s;
          if sum > res then
            BEGIN
             kq:=p[i];
             res:=sum;
            END;
      END;
    Assign(fo,out);rewrite(fo);
    write(fo,kq,' ',res);
    close(fo);

END.