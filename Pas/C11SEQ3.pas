Const    inp = '';
         out = '';
         maxn = 25;
Var      fi,fo  :       text;
         n,t,res      :       longint;
         a      :       array [1..maxn] of longint;
         b      :       array [0..5] of longint;
         s      :       string;
{*       *      *       *       *}
Procedure Swap( Var xx,yy : char);
Var temp : char;
BEGIN
    temp:=xx;
    xx:=yy;
    yy:=temp;
END;
{*      *       *       *       *}
Procedure Quicksort(L,H : integer;Var s : string);
Var i,j : integer;
    key : char;
BEGIN
    if l>=h then exit;
    i:=l;
    j:=h;
    key := s [ (l+h) div 2 ];
    Repeat
      BEGIN
           While s[i] < key do inc(i);
           while s[j] > key do dec(j);
           if i<=j then
             BEGIN
                 if i< j then swap(s[i],s[j]);
                 inc(i);
                 dec(j);
             END;
      END;
        Until i>j;
      Quicksort(L,j,s);
      Quicksort(i,h,s);
END;
{*      *       *       *       *}
Procedure Solve;
Var i : integer;
BEGIN
    if n<25 then
    BEGIN
    a[1]:=1;
    For i:=2 to n do
      BEGIN
          a[i]:=a[i-1]*2;
          str(a[i],s);
          Quicksort(1,length(s),s);
          val(s,t);
          a[i]:=t;
      END;
      res:=a[n];
    END
    else BEGIN
              b[0]:= 244445;
              b[1]:= 48889 ;
              b[2]:= 77789  ;
              b[3]:= 155578  ;
              b[4]:=111356   ;
              b[5]:= 122227  ;
              n:= (n-24) mod 6;
              res:=b[n];
         END;
END;
{*      *       *       *       *}
BEGIN
   Assign(fi,inp);reset(fi);
   read(fi,n);
   close(fi);
   Solve;
   Assign(fo,out);rewrite(fo);
   write(fo,res);
   close(fo);
END.