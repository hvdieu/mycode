{$MODE OBJFPC}
const   inp = '';
        out = '';
        maxn = 100100;
Var     fi,fo   :       text;
        a       :       array [1..maxn] of longint;
        maxleft,maxright : array [1..maxn] of longint;
        n       :       longint;
        s       :       int64;
{*      *       *       *       *}
Procedure input;
Var i : longint;
BEGIN
    assign(fi,inp);reset(fi);
    readln(fi,n);
    for i:=1 to n do
      read(fi,a[i]);
    Close(fi);
END;
{*      *       *       *       *}
Procedure init;
Var i : integer;
BEGIN
    fillchar(maxleft,sizeof(maxleft),0);
    fillchar(maxright,sizeof(maxright),0);
    maxleft[1]:=a[1];
    maxright[n]:=a[n];
    s:=0;
END;
{*      *       *       *       *}
Function Min(x,y : longint) : longint;
BEGIN
    if x<y then min:=x
      else min:=y;
END;
{*      *       *       *       *}
Procedure Solve;
Var i : longint;
BEGIN
      For i:=2 to n do
           if a[i]>maxleft[i-1] then maxleft[i]:=a[i]
             else maxleft[i]:=maxleft[i-1];
      For i:=n-1 downto 1 do
         if a[i]>maxright[i+1] then maxright[i]:=a[i]
            else maxright[i]:=maxright[i+1];
      for i:=2 to n-1 do
        BEGIN
            if (a[i]>=maxleft[i-1]) or (a[i]>=maxright[i+1]) then continue
              else if (a[i]<maxleft[i-1]) and (a[i]<maxright[i+1]) then s:=s+min(maxright[i+1],maxleft[i-1])-a[i];
        END;
END;
{*      *       *       *       *}
Procedure Output;
BEGIN
    assign(fo,out);rewrite(fo);
    write(fo,s);
    close(fo);
END;
{*      *       *       *       *}
BEGIN
    input;
    init;
    solve;
    output;
END.
