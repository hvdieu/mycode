Program NKNUMFREE;
Const    inp = '';
         out = '';
Var      fi,fo :        text;
         a,b,dem    :       longint;
{*       *      *       *       *}
Procedure Input;
BEGIN
    Assign(fi,inp);reset(fi);
    read(fi,a,b);
    Close(fi);
END;
{*      *       *       *       *}
Function Daoso(x : longint) : longint;
Var k,n : longint;
BEGIN
    k:=0;
    n:=x;
    While n>0 do
      BEGIN
          k:=k*10+n mod 10;
          n:=n div 10;
      END;
    Daoso:=k;
END;
{*      *       *       *       *}
Function UCLN (x,y : longint) : longint;
Var tmp : longint;
BEGIN
      While y>0 do
        BEGIN
            x:=x mod y;
            tmp:=x;
            x:=y;
            y:=tmp;
        END;
      exit(x);
END;
{*      *       *       *       *}
Procedure Xuly;
Var i : longint;
BEGIN
    dem:=0;
    For i:=a to b do
      If UCLN(i,daoso(i))=1 then Inc(dem);
END;
{*      *       *       *       *}
Procedure Output;
BEGIN
    Assign(fo,out);rewrite(fo);
    Write(fo,dem);
    Close(fo);
END;
{*       *       *       *       *}
BEGIN
  input;
  xuly;
  output;
END.
