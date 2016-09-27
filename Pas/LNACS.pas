Program LNACS;
Const   inp = '';
        out = '';
        maxn = 1050;
Var     fi,fo   :       text;
        m,n,dem     :       longint;
        a,b,qa,qb     :       array [1..maxn] of longint;
        l       :       array [0..maxn,0..maxn] of longint;
{*      *       *       *       *}
Procedure Input;
Var i,j : longint;
BEGIN
    assign(fi,inp);reset(fi);
    readln(fi,m,n);
    for i:=1 to m do readln(fi,a[i]);
    for j:=1 to n do readln(fi,b[j]);
    close(fi);
    for i:=1 to m do
      l[i,0]:=0;
    for j:=1 to n do
      l[0,j]:=0;
END;
{*      *       *       *       *}
Function max(x,y : longint) : longint;
Var tmp : longint;
BEGIN
    tmp:=x;
    if tmp<y then tmp:=y;
    max:=tmp;
END;
{*      *       *       *       *}
Procedure QHD;
Var i,j,right,left,k : longint;
BEGIN
    right:=0;left:=0;dem:=0;
    For i:=1 to m do
      For j:=1 to n do
        if a[i]=b[j] then
        BEGIN
           l[i,j]:=l[i-2,j-2]+1;
           inc(right);
           qa[right]:=i;
           qb[right]:=j;
        END
          else  l[i,j]:=max(l[i-1,j],l[i,j-1]);
        While left<right do
          BEGIN
              Inc(left);
              If (qa[left]<qa[left+1]-1) and (qb[left]<qb[left+1]-1) then inc(dem)
                else BEGIN
                         Inc(dem);
                         Inc(left);
                     END;
          END;
END;
{*      *       *       *       *}
Procedure Output;
BEGIN
    assign(fo,out);rewrite(fo);
    Write(fo,l[m,n]);
    Close(fo);
END;
{*      *       *       *       *}
BEGIN
     input;
     qhd;
     output;
END.
