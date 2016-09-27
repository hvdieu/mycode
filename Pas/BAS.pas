Const   inp = '';
        out = '';
        maxn = 35;
Var     fi,fo   :       text;
        x,kq       :       array [1..maxn] of integer;
        a       :       array [1..maxn,1..maxn] of integer;
        d,cx    :       array [1..maxn] of boolean;
        n,m,dem,k,min     :       integer;
        ok      :     boolean;
{*      *       *               *}
Procedure Input;
Var i,xx,yy  : integer;
BEGIN
    Assign(fi,inp);reset(fi);
    fillchar(d,sizeof(d),true);
    readln(fi,n,m);
    For i:=1 to m do
      BEGIN
          readln(fi,xx,yy);
          a[xx,yy]:=1;
          a[yy,xx]:=1;
          d[xx]:=false;
          d[yy]:=false;
      END;
    close(fi);
END;
{*      *       *       *       *}
Procedure Init;
Var i : integer;
BEGIN
     For i:=1 to n do
      if d[i] then
        BEGIN
          x[i]:=1;
          inc(k);
        END;
      min:=n;
END;
{*      *       *       *       *}
Procedure Kiemtra;
Var u,v : integer;
BEGIN

    cx:=d;
    dem:=0;
    for u:=1 to n do
            if x[u]=1 then inc(dem);
    if dem<min then
    BEGIN
    For u:=1 to n do
      BEGIN
          if d[u]=false then
             BEGIN
                 if x[u]=1 then
                    BEGIN
                        cx[u]:=true;
                        For v:=1 to n do
                          if a[u,v]=1 then cx[v]:=true;

                    END;
             END;
      END;
      ok:=true;
    For u:=1 to n do
      if cx[u]=false then
        BEGIN
           ok:=false;
           break;
        END;
        if ok then
        begin
           if dem<min then

               BEGIN
                 kq:=x;
                 min:=dem;
               END;
        end;
      END;

END;
{*      *       *       *       *}
Procedure Try(i : integer);
Var j : integer;
BEGIN
    if d[i] and (i<n) then try(i+1)
      else if i=n then kiemtra
       else if i<n then
        BEGIN
            For j:=0 to 1 do
              BEGIN
                  x[i]:=j;
                  if i=n then kiemtra
                    else Try(i+1);
              END;
        END;
END;
{*      *       *       *       *}
procedure output;
Var u : integer;
BEGIN
    assign(fo,out);rewrite(fo);
    dem:=0;
    For u:=1 to n do
     if kq[u]=1 then inc(dem);
     writeln(fo,min);
     close(fo);

END;
{*      *       *       *       *}
BEGIN
    Input;
    init;
    Try(1);
    output;
END.
