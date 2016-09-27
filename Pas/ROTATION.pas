Const   inp = '';
        out = '';
        maxn = 1001;
Var     fi,fo   :       text;
        s,d,c   :       array [1..maxn] of integer;
        n,res       :       integer;
{*      *       *       *       *}
Procedure Input;
Var i : integer;
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n);
    For i:=1 to n-1 do
      readln(fi,s[i],d[i],c[i]);
    close(fi);
END;
{*      *       *       *       *}
procedure Swap ( var xx, yy : integer);
Var temp : integer;
BEGIN
    temp:=xx;
    xx:=yy;
    yy:=temp;
END;
{*      *       *       *       *}
procedure Quicksort(L,H : integer);
Var i,j,key : integer;
BEGIN
    if l>=h then exit;
    i:=l;
    j:=h;
    key := s [ (l+h) div 2 ];
    Repeat
       BEGIN
           While s[i] < key do inc(i);
           While s[j] > key do dec(j);
           If i<=j then
             BEGIN
                 if i< j then
                   BEGIN
                       Swap(s[i],s[j]);
                       Swap(d[i],s[j]);
                       Swap(c[i],c[j]);
                   END;
                   inc(i);
                   dec(j);

             END;
       END;
         Until i>j;
       Quicksort(L,j);
       Quicksort(i,h);
END;
{*      *       *       *       *}
Procedure output;
Var i : integer;
BEGIN
   res:=0;
   Quicksort(1,n-1);
   For i:=1 to n-1 do
     BEGIN
         if c[i] = 1 then
           BEGIN
               if res=1 then res:=0
                 else res:=1;
           END;
     END;
   Assign(fo,out);rewrite(fo);
   write(fo,res);
   close(fo);
END;
{*      *       *       *       *}
BEGIN
    input;
    output;
END.
