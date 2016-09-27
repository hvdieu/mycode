Const    inp = '';
         out = '';
         maxn = 100001;
Var      fi,fo  :       text;
         n,i,j       :       longint;
         s       :       array [1..maxn] of string;
         dem     :       longint;
{*       *       *       *      *       *}
Procedure Swap(Var xx,yy : string);
Var temp : string;
BEGIN
    temp:=xx;
    xx:=yy;
    yy:=temp;
END;
{*      *       *       *       *       *}
procedure quicksort(l,h : longint);
Var i,j : longint;
    key : string;
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
                 if i<j then swap(s[i],s[j]);
                 inc(i);
                 dec(j);
             END;
      END;
        Until i>j;
      Quicksort(L,j);
      Quicksort(i,H);
END;
{*      *       *       *       *       *}
BEGIN
    assign(fi,inp);reset(fi);
    Assign(fo,out);rewrite(fo);
    readln(fi,n);
    For i:=1 to n do
     readln(fi,s[i]);
    close(fi);
    if n=1 then
     BEGIN
         write(fo,s[1]);
         close(fo);
         halt;
     END;
    quicksort(1,n);
    i:=1;
    dem:=1;
    While i<=n do
    BEGIN
    While s[i]=s[i+1] do
      BEGIN
          inc(dem);
          inc(i);
      END;
      if dem mod 2 = 1 then
        BEGIN

            write(fo,s[i]);
            close(fo);
            halt;
        END
         else
          BEGIN
           inc(i);
           dem:=1;
          END;
    END;
   write(fo,-1);
   close(fo);
END.
