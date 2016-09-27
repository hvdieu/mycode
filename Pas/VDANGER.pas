Const   inp = '';
        out = '';
        maxn = 101;
Var     fi,fo   :       text;
        a       :       array [1..maxn,1..maxn] of longint;
        n,m,i,j,k,res :       longint;
        pos     :       array [1..10001] of integer;
{*      *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n,m);
    For i:=1 to m do
     readln(fi,pos[i]);
    For i:=1 to n do
     for j:=1 to n do
       read(fi,a[i,j]);
     close(fi);
     For k:=1 to n do
      For i:=1 to n do
       for j:=1 to n do
        if a[i,j] > a[i,k] + a[k,j] then
         a[i,j] := a[i,k] + a[k,j];
        res:=0;
      For i:=1 to m-1 do
       res:=res+ a[ pos[i], pos[i+1] ];
      Assign(fo,out);rewrite(fo);
      write(fo,res);
      close(fo);

END.