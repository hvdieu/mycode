Const    inp = '';
         out = '';
         maxn = 16;
Var      fi,fo  :       text;
         n,i,j  :       integer;
         f      :       array [1..65550,1..maxn] of longint;
         a      :       array [1..maxn,1..maxn] of integer;
         min    :       int64;
{*       *      *       *       *}
Function bat(n : longint;i : integer) : longint;
BEGIN
    bat:= n or (1 shl i);
END;
{*      *       *       *       *}
Function tat(n : longint;i : integer) : longint;
BEGIN
    tat:=n and (not (1 shl i) );
END;
{*      *       *       *       *}
Function lay(n : longint;i : integer) : integer;
BEGIN
    lay:=(n shr i) and 1;
END;
{*      *       *       *       *}
Function getmin(xx ,yy : longint) : longint;
BEGIN
    if xx>yy then min:=yy
     else getmin:=xx;
END;
{*      *       *       *       *}
Procedure Solve;
Var i,j,k,x : longint;
BEGIN
    For i:=1 to 1 shl n - 1 do
     For j:=1 to n do
      BEGIN
          f[i,j]:=100000000;
      END;
     f[1,1]:=0;
     For i:=1 to n-1 do
       f[1 shl i,i+1]:=0;
     For i:=1 to 1 shl n - 1 do
       For j:=1 to n do
         BEGIN
             if f[i,j] >=0 then
               for k:=1 to n do
                if k <> j then
                  BEGIN
                      x:=bat(i,k-1);
                      if lay(i,k-1)=0 then
                        BEGIN
                            f[x,k]:=getmin(f[x,k],f[i,j]+ a[j,k]);
                        END;
                  END;
         END;
       min:=10000000;
       For i:=1 to n do
         if (min > f[1 shl n -1,i]) and (f[1 shl n-1,i]>=0) then min:=f[1 shl n-1,i];

END;
{*      *       *       *       *}
BEGIN
        Assign(fi,inp);reset(fi);
        readln(fi,n);
        For i:=1 to n do
          For j:=1 to n do
           read(fi,a[i,j]);
        close(fi);
        solve;
        assign(fo,out);rewrite(fo);
        write(fo,min);
        close(fo);

END.