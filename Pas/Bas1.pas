Const   inp = 'BAS.INP';
        out = 'BAS.OUT';
        maxn = 40;
Var     fi,fo   :       text;
        a       :       array [1..maxn,1..maxn] of integer;
        n,m,ni     :       integer;
        d,cx       :       array [1..maxn] of boolean;
        x       :       array [0..maxn] of integer;
        dem,i     :       integer;
        ok      :       boolean;
{*      *       *       *       *}
Procedure input;
Var i,xx,yy : integer;
BEGIN
    assign(fi,inp);reset(fi);
    readln(fi,n,m);
    fillchar(d,sizeof(d),false);
    For i:=1 to m do
        BEGIN
            Readln(fi,xx,yy);
            a[xx,yy]:=1;
            a[yy,xx]:=1;
            d[xx]:=true;
            d[yy]:=true;
        END;
    Close(fi);

END;
{*      *       *       *       *}
Procedure Init;
Var i : integer;
BEGIN
    dem:=0;
    For i:=1 to n do
      if d[i]=false then inc(dem);
    x[0]:=0;
    ni:=n - dem;
END;
{*      *       *       *       *}
procedure xuly( k : integer);
Var u,v : integer;
BEGIN
   cx:=d;
   ok:=true;
   For u:=1 to k do
     BEGIN
         cx[ x[u] ]:=false;
         For v:=1 to n do
           BEGIN

               if (a[ x[u],v] =1) then
                 BEGIN
                     cx[ v ] := false;
                 END;
           END;
     END;
   For u:=1 to n do
     if cx[u] then
       BEGIN
           ok:=false;
           break;
       END;
     if ok then
       BEGIN
           assign(fo,out);rewrite(fo);
           writeln(fo,dem+k);
           close(fo);
           halt;
       END;
END;
{*      *       *       *       *}
Procedure Try(i,k : integer);
Var j : integer;
BEGIN
      For j:= x[i-1] + 1 to n - k + i do
        if d[j] then
          BEGIN
              x[i]:=j;
              if i=k then xuly(k)
                   else Try(i+1,k)
          END;
END;
{*      *       *       *       *}
BEGIN
    Input;
    init;
    For i:=1 to ni do
      Try(1,i);
END.
