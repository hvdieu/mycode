Const   inp = '';
        out = '';
        maxn = 101;
Var     fi,fo   :       text;
        a       :       array [1..maxn,1..maxn] of longint;
        x       :       array [1..4] of integer;
        u,v,c,k,i,res,n,s     :       longint;
{*      *       *       *       *}
Function min( xx,yy : longint) : longint;
BEGIN
    if xx > yy then min := yy
      else min := xx;
END;
{*      *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n);
    For u:=1 to 4 do read(fi,x[u]);
    readln(fi);
    For u:=1 to n do
      For v:=1 to n do
       if u=v then a[u,v] := 0
         else
            a[u,v]:=maxint;
    While not eof(fi) do
      BEGIN
          readln(fi,u,v,c);
          a[u,v]:=c;
          a[v,u]:=c;
      END;
    close(fi);
   For k:=1 to n do
     For u:=1 to n do
       For v:=1 to n do
         if a[u,v] > a[u,k] + a[k,v] then a[u,v] := a[u,k] + a[k,v];
   res:=maxlongint;
   For u:=1 to n do
     For v:=1 to n do
       BEGIN
           s:= a[x[1],u] + a[ x[3],u] + a[u,v] + a[x[2],v] + a[ x[4],v];
           if res > s then res:=s;
           s:= a[x[1],u] + a[ x[4],u] + a[u,v] + a[x[2],v] + a[ x[3],v];
           if res > s then res:=s;
           s:= a[x[1],u] + a[ x[2],u] + a[u,v] + a[x[4],v] + a[ x[3],v];
           if res > s then res:=s;
       END;
     assign(fo,out);rewrite(fo);
     write(fo,res);
     close(fo);

END.
