Const   inp = '';
        out = '';
        maxn = 101;
Var     fi,fo   :       text;
        a,tt,trace       :       array [1..maxn,1..maxn] of longint;
        canh    :       array [1..20000] of integer;
        d        :       array [1..maxn,1..maxn] of boolean;
        m,n,u,v,c,min,x,dem     :       longint;
{*      *       *       *       *}
Procedure Input;
Var i,j : longint;
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n,m);
    For i:=1 to n do
     For j:=1 to n do
      trace[i,j]:=j;
    For i:=1 to n do
      For j:=1 to n do
        if i=j then a[i,j]:=0
          else a[i,j] := maxint;
    For i:=1 to m do
        BEGIN
                readln(fi,u,v,c);
                if a[u,v] = 0 then
                  BEGIN
                     a[u,v]:=c;
                     a[v,u]:=c;
                     tt[u,v]:=i;
                     tt[v,u]:=i;
                  END
                  else if a[u,v] <> 0 then
                        if c < a[u,v] then
                           BEGIN
                             a[u,v]:=c;
                             a[v,u]:=c;
                             tt[u,v]:=i;
                             tt[v,u]:=i;
                           END;
        END;
    Close(fi);

END;
{*      *       *       *       *}
Procedure Solve;
Var u,v,k : longint;
BEGIN
    For k:=1 to n do
      For u:=1 to n do
        For v:=1 to n do
           BEGIN
                  if a[u,v] > a[u,k] + a[k,v] then
                   BEGIN
                      a[u,v]:= a[u,k] + a[k,v];
                      trace[u,v]:=trace[u,k];
                   END;

           END;
END;
{*      *       *       *       *}
Procedure truyvet(s,f : integer);
Var temp,u : integer;
BEGIN
    if s=f then exit;
    if s <> f then
      repeat
         u:=trace[s,f];
         inc(dem);
         canh[dem]:=tt[s,u];
         s:=u;
      until (s=f) ;
END;
{*      *       *       *       *}
Procedure Output;
Var u,v,s,f : longint;
BEGIN
    min:=maxlongint;
    For u:=1 to n do
      if min > a[1,u] + a[2,u] + a[3,u] then
        BEGIN
            x:=u;
            min:= a[1,u] + a[2,u] + a[3,u];
        END;
    dem:=0;
    truyvet(1,x);
    truyvet(2,x);
    truyvet(3,x);
    Assign(fo,out);
    rewrite(fo);
    writeln(fo,min);
    writeln(fo,dem);
    For u:=1 to dem do
     write(fo,canh[u],' ');
    close(fo);
END;
{*      *       *       *       *}
BEGIN
     Input;
     Solve;
     Output;
END.