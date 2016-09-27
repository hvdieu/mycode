program NKSGAME;
Const    inp = 'nksgame.inp';
         out = '';
         maxn = 100050;
Type     arr    =       array [1..maxn] of longint;
Var      fi,fo  :       text;
         n      :       longint;
         b,c    :       arr;
         min    :       longint;
{*      *       *       *       *      }
Procedure Input;
Var i : longint;
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n);
    For i:=1 to n do read(fi,b[i]);
    readln(fi);
    for i:=1 to n do read(fi,c[i]);
    Close(fi);
END;
{*      *       *       *       *       *}
Procedure Swap(Var x,y : longint);
Var temp : longint;
BEGIN
    temp:=x;
    x:=y;
    y:=temp;
END;
{*      *       *       *       *       *}
Procedure Quicksort(L,h : longint; Var k : arr);
Var i,j,key : longint;
BEGIN
    if l>=h then exit;
    i:=l;j:=h;
    key:=k[ (l+h) div 2];
    Repeat
      BEGIN
          While k[i]<key do Inc(i);
          While k[j]>key do Dec(j);
          If i<=j then
            BEGIN
                if i<j then Swap(k[i],k[j]);
                Inc(i);
                Dec(j);
            END;
      END;
          until i>j;
      Quicksort(L,j,k);
      Quicksort(i,H,k);
END;
{*      *       *       *       *       *}
Procedure Optimize;
Var i,j   :   longint;
    tmp   :   int64;
BEGIN
    Quicksort(1,n,b);Quicksort(1,n,c);
    i:=1;j:=n;
    min:=maxlongint;
    While (i<=n) and (j>=1) do
      BEGIN
          tmp:=abs(b[i]+c[j]);
          if tmp=0 then BEGIN
                            min:=tmp;
                            exit;
                        END;
          If min>tmp then min:=tmp;
          if b[i]+c[j]>0 then Dec(j)
           else inc(i);
      END;
END;
{*      *       *       *       *       *}
Procedure Output;
BEGIN
    Assign(fo,out);rewrite(fo);
    Write(fo,min);
    Close(fo);

END;
{*      *       *       *       *       *}
BEGIN
    input;
    optimize;
    output;
END.
