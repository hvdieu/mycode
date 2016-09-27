Program QBSTR;
Const   inp = '';
        out = '';
        maxn = 255;
Var     fi,fo : text;
        a,b     :       string;
        l       :       array [0..maxn,0..maxn] of longint;
{*      *       *       *       *       *}
Procedure Input;
BEGIN
    assign(fi,inp);reset(fi);
    readln(fi,a);
    read(fi,b);
    Close(fi);
END;
{*      *       *       *       *       *}
Function Max(x,y,z : longint) : longint;
Var tmp,k : longint;
BEGIN
   tmp:=x;
   if tmp<y then tmp:=y;
   if tmp<z then tmp:=z;
   max:=tmp;
END;
{*      *       *       *       *       *}
Procedure QHD;
Var i,j : longint;
BEGIN
    For i:=1 to length(a) do
       l[i,0]:=0;
    For j:=1 to length(b) do
       l[0,j]:=0;
    For i:=1 to length(a) do
      For j:=1 to length(b) do
       if a[i]=b[j] then
        l[i,j]:=max(l[i-1,j],l[i,j-1],l[i-1,j-1]+1)
         else l[i,j]:=max(l[i-1,j],l[i,j-1],l[i-1,j-1]);
END;
{*      *       *       *       *       *}
Procedure Output;
BEGIN
    assign(fo,out);rewrite(fo);
    write(fo,l[length(a),length(b)]);
    close(fo);
END;
{*      *       *       *       *       *}
BEGIN
    input;
    qhd;
    output;
END.