Program NKREZ;
Const    inp = '';
         out = '';
         maxn = 10015;
Var      fi,fo  :       text;
         a,b,c    :       array [1..maxn] of longint;
         f      :       array [1..maxn] of longint;
         n,max      :       longint;
{*****************************}
Procedure Input;
Var i : longint;
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n);
    For i:=1 to n do readln(fi,a[i],b[i]);
    Close(fi);

END;
{******************************}
Procedure Swap(Var x,y  :  longint);
Var temp : longint;
BEGIN
    temp:=x;
    x:=y;
    y:=temp;
END;
{******************************}
Procedure Quicksort(L,H : longint);
Var i,j,key : longint;
BEGIN
    if l>=h then exit;
    i:=l;j:=h;
    key:=a[ (l+h) div 2 ];
    Repeat
       BEGIN
             While a[i]<key do Inc(i);
             While a[j]>key do Dec(j);
             If i<=j then
                BEGIN
                    If i<j then
                      BEGIN
                          Swap(a[i],a[j]);
                          Swap(b[i],b[j]);
                      END;
                    Inc(i);
                    Dec(j);
                END;
       END;
          Until i>j;
          Quicksort(L,j);
          Quicksort(i,H);
END;
{******************************}
Procedure QHD;
Var i,j : longint;
BEGIN
    Quicksort(1,n);
    For i:=1 to n do
      BEGIN
       f[i]:=b[i]-a[i];
       c[i]:=b[i] - a[i];
      END;
    For i:=1 to n do
       For j:=1 to i-1 do
         If (a[i]>=b[j]) and (f[i]<f[j]+c[i]) then f[i]:=f[j]+c[i];

END;
{*******************************}
Procedure output;
Var i : longint;
BEGIN
    Assign(fo,out);rewrite(fo);
    max:=f[1];
    For i:=2 to n do
     if max < f[i] then max:=f[i];
    Write(fo,max);
    Close(fo);
END;
{*******************************}
BEGIN
    Input;
    QHD;
    Output;
END.
