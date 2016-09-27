Const    inp = '';
         out = '';
         maxn = 21;
Var      fi,fo  :       text;
         n,k,s,i,j  :       integer;
         a      :       array [1..maxn,1..maxn] of longint;
         x      :       array [0..maxn] of longint;
{*       *      *       *       *}
Procedure Try(j : integer;sum : longint);
Var i,u : integer;
BEGIN
    For i:=1 to n do
         if (a[i,j] >= x[j-1]) and (sum + a[i,j] * (k-j-1) <= s)then
         BEGIN
             x[j]:= a[i,j];

             if j=k then
                  BEGIN
                      if sum + a[i,j] = s then
                         BEGIN
                             writeln(fo,'YES');
                             For u:=1 to k do
                               write(fo,x[u],' ');
                             close(fo);
                             halt;
                         END;
                  END
                    else Try(j+1,sum + a[i,j]);
         END;
END;
{*      *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,s,k,n);
    For i:=1 to n do
      For j:=1 to k do
       read(fi,a[i,j]);
      x[0]:=-maxint;
    close(fi);
    Assign(fo,out);rewrite(fo);
    Try(1,0);
    Write(fo,'NO');
    close(fo);
END.
