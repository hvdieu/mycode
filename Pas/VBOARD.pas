Const    inp = '';
         out = '';
         maxn = 501;
Var      fi,fo  :       text;
         n,i,j,k,i1,j1,i2,j2,q     :       integer;
         a      :   array [1..maxn,1..maxn] of integer;
         den,trang  :   array [0..maxn,0..maxn] of longint;
         s1,s2  :       longint;
{*       *      *   *   * *}
Procedure Solve;
Var i,j : integer;
BEGIN
    For i:=1 to n do
      For j:=1 to n do
        BEGIN
            if (i mod 2 = 1) and (j mod 2 = 1) then
                BEGIN
                    trang[i,j]:=trang[i,j-1] + trang[i-1,j] + a[i,j] - trang[i-1,j-1];
                    den[i,j]:=den[i-1,j] + den[i,j-1] -  den[i-1,j-1];
                END;
            if (i mod 2 = 1) and (j mod 2 = 0) then
                BEGIN
                    trang[i,j]:=trang[i,j-1] + trang[i-1,j] - trang[i-1,j-1];
                    den[i,j]:=den[i-1,j] + den[i,j-1] +a[i,j] -  den[i-1,j-1];
                END;
            if (i mod 2 = 0) and (j mod 2 = 1) then
                BEGIN
                    trang[i,j]:=trang[i,j-1] + trang[i-1,j] - trang[i-1,j-1];
                    den[i,j]:=den[i-1,j] + den[i,j-1] +a[i,j] -  den[i-1,j-1];
                END;
            if (i mod 2 = 0) and ( j mod 2 = 0) then
                BEGIN
                    trang[i,j]:=trang[i,j-1] + trang[i-1,j] + a[i,j] - trang[i-1,j-1];
                    den[i,j]:=den[i-1,j] + den[i,j-1] -  den[i-1,j-1];
                END;
        END;
END;
{*      *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    Assign(fo,out);rewrite(fo);
    readln(fi,n);
    For i:=1 to n do
     For j:=1 to n do
      read(fi,a[i,j]);
     solve;
    readln(fi);
    readln(fi,q);
    For k:=1 to q do
      BEGIN
         readln(fi,i1,j1,i2,j2);
         s1:= den[i2,j2] - den[i1-1,j2] - den[i2,j1-1] + den[i1-1,j1-1];
         s2:= trang[i2,j2] - trang[i1-1,j2] - trang[i2,j1-1] + trang[i1-1,j1-1];
         writeln(fo,abs(s1-s2));

      END;
    close(fi);
    close(fo);
END.