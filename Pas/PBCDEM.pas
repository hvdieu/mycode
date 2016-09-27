Const   inp = '';
        out = '';
        maxn = 4001;
Var     fi,fo           :       text;
        n,i,j,k,dd               :       longint;
        f               :       array [0..maxn,0..maxn] of ansistring;
        a               :       array [0..8] of char;
        res             :       ansistring;
        ch      :       char;
{*      *               *       *       *       *}
Function add(xx,yy : ansistring) : ansistring;
Var i,j,carry,so1,so2,tong : longint;
    kq,st : ansistring;
BEGIN
   While length(xx) < length(yy) do xx:='0' + xx;
   While length(xx) > length(yy) do yy:= '0' + yy;
   carry:=0;
   kq:='';
   For i:=length(xx) downto 1 do
     BEGIN
        Val(xx[i],so1);
        Val(yy[i],so2);
        tong:=so1 + so2 + carry;
        carry:=tong div 10;
        tong:= tong mod 10;
        str(tong,st);
        kq:=st+kq;
     END;
   if carry=1 then kq:= '1' + kq;
   add:=kq;
EnD;
{*      *       *       *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n);
    close(fi);
    a[0]:='0';
    a[1]:='1';
    a[2]:='2';a[3]:='3';
    a[4]:='4';a[5]:='5';
    a[6]:='6';a[7]:='7';
    a[8]:='8';
    f[0,0]:='1';
    for i:=1 to n do
      For j:=0 to n do
        if i>j then f[i,j]:=f[i-1,j]
          else f[i,j]:= add(f[i-1,j],f[i-1,j-i]);
      res:=f[n,n];
      dd:=length(res);
      ch:= res[dd];
      val(ch,k);
      While k=0 do
        BEGIN
            res[dd]:='9';
            dec(dd);
            ch:=res[dd];
            val(ch,k);
        END;
      k:=k-1;
      ch:=a[k];
      res[dd]:=ch;
    Assign(fo,out);rewrite(fo);
    write(fo,res);
    close(fo);
END.
