Const   inp = 'LQDFIBO.INP';
        out = 'LQDFIBO.OUT';
        maxn = 10;
Var     fi,fo   :       text;
        n,d1,d2,d3,d4       :       longint;
        f       :       array [1..maxn] of ansistring;
        s1,s2,s,t1,t2,num,truoc,sau,giua : ansistring;
{*      *       *       *       *       *}
Function dem(s,t : ansistring) : longint;
Var d : longint;
BEGIN
    d:=0;
    While pos(s,t) <> 0 do
      BEGIN
          inc(d);
          delete(t,1,pos(s,t));
      END;
    dem:=d;
END;
{*      *       *       *       *       *}
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
{*      *       *       *       *       *}
Function bigmod(s: ansistring;t : longint) : ansistring;
Var i,hold,so : longint;
    st : ansistring;
BEGIN
      hold:=0;
      For i:=1 to length(s) do
        BEGIN
           val(s[i],so);
           hold:=(so+hold *10) mod t;
        END;
     str(hold,st);
     bigmod:=st;
END;
{*      *       *       *       *       *}
procedure Solve;
Var i,j : longint;
BEGIN
    t1:=s1;
    t2:=s2;
    d1:=dem(s,s1);
    Str(d1,num);
    f[1]:=num;
    d2:=dem(s,s2);
    Str(d2,num);
    f[2]:=num;
    t1:=s2 + s1;
    d3:=d3 - d1 -d2;
    d3:=dem(s,t1);
    str(d3,num);
    f[3]:=num;
    if n=3 then
      BEGIN
        write(fo,bigmod(f[3],15111992));
        exit;
      END;
    t1:=s1 + s2;
    d3:=dem(s,t1);
    d3:=d3 - d1 - d2;
    str(d3,t1);

    t2:= s2 + s2;
    d4:=dem(s,t2);
    d4:=d4 - 2*d2;
    str(d4,t2);
    giua:=f[3];
    truoc:=f[2];
    For i:=4 to n do
     if i mod 2 = 0 then
       BEGIN
           sau:=add(giua,truoc);
           sau:=add(sau,t1);
           sau:=bigmod(sau,15111992);
           truoc:=giua;
           giua:=sau;
       END
          else
            BEGIN
                sau:=add(giua,truoc);
                sau:=add(sau,t2);
                sau:=bigmod(sau,15111992);
                truoc:=giua;
                giua:=sau;
            END;


END;
{*      *       *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n);
    readln(fi,s1);
    readln(fi,s2);
    readln(fi,s);
    close(fi);
    Solve;
    Assign(fo,out);rewrite(fo);
    write(fo,bigmod(sau,151111992));
    close(fo);
END.