Program NKPALIN;
Const   inp = '';
        out = '';
        maxn = 2050;
Var     fi,fo   :       text;
        a,b,t       :      ansistring;
        f       :       array [0..maxn,0..maxn] of integer;
        n,l,r       :       integer;
{*      *       *       *       *       *}
Procedure Input;
Var i : integer;
BEGIN
    assign(fi,inp);reset(fi);
    read(fi,a);
    close(fi);
    fillchar(f,sizeof(f),0);
    n:=length(a);b:='';
    for i:=n downto 1 do
      BEGIN
          b:=b+a[i];
      END;
    for i:=1 to n do
      BEGIN
          f[0,i]:=0;
          f[i,0]:=0;
      END;
END;
{*      *       *       *       *       *}
Function max (x,y,z : integer) : integer;
Var temp : integer;
BEGIN
   temp:=x;
   if temp< y then temp:=y;
   if temp<z then temp:=z;
   max:=temp;
END;
{*      *       *       *       *       *}
procedure QHD;
Var i,j,k : integer;
BEGIN
    For i:=1 to n do
       For j:=1 to n do
         BEGIN
         if a[i]=b[j] then
          BEGIN
           f[i,j]:=max(f[i-1,j],f[i,j-1],f[i-1,j-1]+1);
          END
            else f[i,j]:=max(f[i-1,j],f[i,j-1],f[i-1,j-1]);

         END;

END;
{*      *       *       *       *       *}
Procedure Output;
Var k,i,j,u,v : integer;
BEGIN
    assign(fo,out);rewrite(fo);
    i:=n;j:=n;
    k:=0;
    While (i>0) and (j>0) do
      BEGIN
          if a[i]=b[j] then
            BEGIN
                inc(k);
                t:=t+a[i];
                dec(i);
                dec(j);
            END
             else if f[i,j]=f[i,j-1] then dec(j)
               else if f[i,j]=f[i-1,j] then dec(i);
      END;
         write(fo,t);
    close(fo);

END;
{*      *       *       *       *       *}
BEGIN
    input;
    qhd;
    output;
END.
