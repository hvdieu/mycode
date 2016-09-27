Program NKCABLE;
Const   inp = '';
        out = '';
        maxn = 25010;
Var     fi,fo   :      text;
        n       :      longint;
        A       :      array [1..maxn] of longint;
        l       :      array [1..maxn] of longint;
{************************}
Procedure Input;
Var i : longint;
BEGIN
    Assign(fi,inp);reset(fi);
    Readln(fi,n);
    For i:=1 to n-1 do  readln(fi,a[i]);
    Close(fi);
    l[1]:=a[1];l[2]:=a[1];
END;
{************************}
Function min(x,y : longint) : longint;
BEGIN
    If x>y then min:=y
     else min:=x;
END;
{*************************}
Procedure QHD;
Var i : longint;
BEGIN
    For i:=3 to n do
       l[i]:=min(l[i-2],l[i-1])+a[i-1];
END;
{**************************}
Procedure Output;
BEGIN
    Assign(fo,out);rewrite(fo);
    Write(fo,l[n]);
    Close(fo);
END;
{**************************}
BEGIN
    input;
    QHD;
    Output;
END.
