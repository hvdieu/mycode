Const   inp = '';
        out = '';
        maxm = 2001;
Type    arr = array [1..maxm] of integer;
Var     fi,fo   :       text;
        a     :       arr;
        b     :       array [1..maxm] of integer ;
        j,m,k :       integer;
        c       :     array [1..150] of longint;
        q,st,max,maxtong,kq,q1,sum,right,dem,i       :       longint;
        l       :       array [0..150001] of boolean;
        r       :       array [0..150001] of longint;
{*      *       *       *       *       *}
procedure swap(var xx,yy : integer);
Var temp : integer;
BEGIN
    temp:=xx;
    xx:=yy;
    yy:=temp;
END;
{*      *       *       *       *       *}
procedure Quicksort(d,c : integer;var x : arr);
Var i,j,key : integer;
BEGIN
    if d>=c then exit;
    i:=d;
    j:=c;
    key := x[( d+c ) div 2];
    Repeat
      BEGIN
          While x[i] > key do inc(i);
          While x[j] < key do dec(j);
          if i<=j then
            BEGIN
                if i<j then swap(x[i],x[j]);
                inc(i);
                dec(j);
            END;
      END;
        Until i>j;
      Quicksort(d,j,x);
      Quicksort(i,c,x);
END;
{*      *       *       *       *       *}
procedure sort(d,c : integer;var x : arr);
Var i,j,key : integer;
BEGIN
    if d>=c then exit;
    i:=d;
    j:=c;
    key := x[( d+c ) div 2];
    Repeat
      BEGIN
          While x[i] < key do inc(i);
          While x[j] > key do dec(j);
          if i<=j then
            BEGIN
                if i<j then swap(x[i],x[j]);
                inc(i);
                dec(j);
            END;
      END;
        Until i>j;
      sort(d,j,x);
      sort(i,c,x);
END;
{*      *       *       *       *       *}
{*      *       *       *       *       *}
Procedure thamlam;
Var i : integer;
    s : longint;
BEGIN
    kq:= q - sum;
    Quicksort(1,k,b);
    i:=0;
    j:=0;
    While (i<k) and (kq <> 0) do
    BEGIN
         inc(i);
         if b[i] >= kq then
           BEGIN
               kq:=0;
               inc(j);

           END
         else
           BEGIN
               inc(j);
               kq:=kq - b[i];
           END;
    END;
   write(fo,q-j);
   exit;
END;
{*      *       *       *       *       *}
Procedure DP;
Var i,j : longint;
BEGIN
   if sum < q then thamlam
    else if sum=q then
       BEGIN
          write(fo,q);
          exit;
       END
    else
   BEGIN
   q1:=q;
   fillchar(l,sizeof(l),false);
   l[0]:=true;
   For i:=1 to 150 do
     BEGIN
         if c[i]=0 then continue;
         for j:=1 to q do
         BEGIN
         r[j]:=0;
         if j < i then continue;
         if not l[j] and l[j-i] then
         if r[j-i] < c[i] then
           BEGIN
               r[j]:=r[j-i] +1;
               l[j]:=true;
           END;
         END;
     END;
     if l[q] then
       BEGIN
           write(fo,q);
           exit;
       END
         else
           BEGIN
               write(fo,q-1);
               exit;
           END;
     END;
END;
{*      *       *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    Assign(fo,out);rewrite(fo);
    readln(fi,q,m,k);
    For i:=1 to m do
     BEGIN
       read(fi,a[i]);
       sum:=sum + a[i];
       inc(c[ a[i]]);
     END;
    For j:=1 to k do read(fi,b[j]);
    close(fi);
    DP;
    close(fo);
END.

