Program VCOWFLIX;
Const   inp = '';
        out = '';
        maxn = 20;
Var     fi,fo   :       text;
        n,c,max     :       longint;
        w,x       :       array [1..maxn] of longint;
        d       :       array [1..maxn] of boolean;
{*      *       *       *       *}
Procedure Input;
Var i : integer;
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,c,n);
    For i:=1 to n do readln(fi,w[i]);
    Close(fi);
    fillchar(d,sizeof(d),true);
    max:=0;
END;
{*      *       *       *       *}
procedure Try ( s : longint);
Var j : integer;
BEGIN
    For j:=1 to n do
      If (s+w[j]<=c) and d[j] then
        BEGIN
            d[j]:=false;
            If w[j]+s>max then max:=w[j]+s;
            Try(s+w[j]);
            d[j]:=true;
        END;
END;
{*       *       *       *       *}
Procedure Output;
BEGIN
    Assign(fo,out);rewrite(fo);
    Write(fo,max);
    Close(fo);
END;
{*      *       *       *       * }
BEGIN
     input;
     Try(0);
     Output;
END.