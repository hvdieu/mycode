Const   inp = '';
        out = '';
        maxs = 1001;
        maxn = 101;
Var     fi,fo   :       text;
        n,s,i,max,dem,j     :       longint;
        a       :       array [1..maxn] of longint;
        f       :       array [0..maxs] of longint;
{*      *       *       *       *}
Function min(xx,yy : longint) : longint;
BEGIN    if xx > yy then min:=yy
      else min:=xx;
END;
{*      *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n,s);
    max:=0;
    For i:=1 to n do
       BEGIN
           read(fi,a[i]);
           if a[i] > max then max := a[i];
       END;
    close(fi);
    f[0]:=0;
    dem:=0;
    While s > 1000 do
      BEGIN
          s:=s-max;
          inc(dem);
      END;
    For j:=1 to s do
     f[j] := maxlongint;
    For i:=1 to n do
      For j:=1 to s do
         if a[i] <= j then
           f[j] := min (f[j], f[j- a[i]] +1);
    dem:=dem + f[s];
    Assign(fo,out);rewrite(fo);
    write(fo,dem);
    close(fo);

END.

