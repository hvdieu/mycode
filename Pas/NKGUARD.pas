Const   inp = '';
        out = '';
        h       :       array [1..8] of integer = (-1,-1,-1,0,1,1,1,0);
        c       :       array [1..8] of integer = (-1,0,1,1,1,0,-1,-1);
        maxn = 701;
Var     fi,fo   :       text;
        a       :       array [0..maxn,0..maxn] of integer;
        cx      :       array [0..maxn,0..maxn] of boolean;
        i,j,dem,left,right,m,n,max,ax,ay,res     :       longint;
        qx,qy   :       array [1..maxn*maxn] of integer;
        ok      :       boolean;
{*      *       *       *       *}
Procedure BFS;
Var px,py,k : integer;
BEGIN
    While left < right do
      BEGIN
          inc(left);
          px:=qx[left];
          py:=qy[left];
          cx[px,py]:=false;
          For k:=1 to 8 do
            BEGIN
                if cx[px + h[k], py + c[k]] and (a[px,py] >= a[px + h[k], py + c[k] ]) then
                   BEGIN
                       cx[px + h[k], py + c[k] ] := false;
                       Inc(right);
                       qx[right]:= px + h[k];
                       qy[right]:= py + c[k];
                       dec(res);
                   END;
            END;
      END;
END;
{*      *       *       *       *}
Procedure Solve;
Var i,j,k : integer;
BEGIN
  res:=m*n;
  For i:=1 to n do
    For j:=1 to m do
      BEGIN
          if cx[i,j] then
                 BEGIN
                   ok:=true;
                   For k:=1 to 8 do
                     if a[i,j] < a[i+ h[k] , j+ c[k] ] then ok:=false;
                   if ok then
                   BEGIN
                   Inc(right);
                   qx[right]:=i;
                   qy[right]:=j;
                   bfs;
                   END;

                  END;
      END;

END;
{*      *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n,m);
    fillchar(cx,sizeof(cx),false);
    For i:=1 to n do
      For j:=1 to m do
      BEGIN
        read(fi,a[i,j]);
        cx[i,j]:=true;
      END;
    close(fi);
    Solve;
    Assign(fo,out);rewrite(fo);
    write(fo,res);
    close(fo);
END.
