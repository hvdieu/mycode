Program Doanxe;
Const         inp = 'DOANXE.INP';
              out = 'DOANXE.OU1';
              maxn = 1010;
Var           fi,fo :       text;
              p,l, n : integer;
              t :       array [1..maxn] of real;
              w,v       :array [1..maxn] of integer;
              f :       array [0..maxn] of real;
              d :       array [1..maxn] of integer;
              kt : array [0..maxn] of boolean;
{***********************}
Procedure Input;
Var i : integer;
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n,p,l);
    For i:=1 to n do readln(fi,w[i],v[i]);
    Close(fi);
    f[0]:=0;
    For i:=1 to n do t[i]:=l / v[i];
END;
{*************************}
Procedure QHD;
Var i,j,weight : integer;
max : real;
BEGIN
    For i:=1 to n do
      BEGIN
         weight:=w[i];
         max:=t[i];
         f[i]:=f[i-1]+t[i];
         d[i]:=i-1;
         For j:=i-1 downto 1 do
           BEGIN
               If max<t[j] then max:=t[j];
               If (weight+w[j]<=p) then
                 BEGIN
                   If f[i] > f[j-1]+ max then
                     BEGIN
                       f[i]:=f[j-1]+max;
                       d[i]:=j-1;
                     END;
                   weight:=weight+w[j];
                 END
                   else break;

           END;
      END;
END;
{***********************}
Procedure Output;
var i : integer;
BEGIN
    Assign(fo,out);rewrite(fo);
    Writeln(fo,f[n]:0:2);
    fillchar(kt,sizeof(kt),false);
    i:=n;
    While i>0 do
      BEGIN
          kt[i]:=true;
          i:=d[i];
      END;
      For i:=1 to n do if kt[i] then Write(fo,i,' ');
    Close(fo);
END;
{*************************}
BEGIN
     Input;
     QHD;
     Output;
END.
