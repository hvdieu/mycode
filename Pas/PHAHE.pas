Program PHAHE;
Const    inp = 'PHAHE.INP';
         out = 'PHAHE.OUT';
         maxn = 250;
         maxk = 150;
Var      fi,fo  :       text;
         n,k    :       integer;
         l,t      :       array [0..maxn,0..maxk] of longint;
{*       *      *       *       *}
procedure Input;
var i : longint;
BEGIN
    assign(fi,inp);reset(fi);
    read(fi,n,k);
    close(fi);
    fillchar(l,sizeof(l),0);
    fillchar(t,sizeof(t),0);
    l[0,0]:=1;
    t[0,0]:=1;
    for i:=1 to k do
     BEGIN
      l[1,i]:=1;
      t[1,i]:=1;
     END;
END;
{*      *       *       *       *}
procedure QHD;
Var i,j,u : integer;
BEGIN
    If n mod 2 = 0 then exit
      else BEGIN
               For i:=1 to n do
                 For j:=1 to k do
                   BEGIN
                       For u:=1 to i-1 do
                       l[i,j]:=l[u,j-1]*t[i-u-1,j-1]+t[u,j-1]*l[i-u-1,j-1]+l[u,j-1]*l[i-u-1,j-1];
                       t[i,j]:=t[i-1,j-1]+l[i,j];
                   END;
           END;
END;
{*      *       *       *       *}
procedure Output;
BEGIN
    Assign(fo,out);rewrite(fo);
    if n mod 2 = 0 then write(fo,0)
      else Write(fo,l[n,k]);
      Close(fo);
END;
{*      *       *       *       *}
BEGIN
   input;
   qhd;
   output;
END.
