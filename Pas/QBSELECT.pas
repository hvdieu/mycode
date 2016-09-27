Const   inp = '';
        out = '';
        maxn = 10001;
Var     fi,fo   :       text;
        a       :       array [1..4,1..maxn] of longint;
        f       :       array [0..maxn,0..15] of longint;
        tm      :       array [0..15] of boolean;
        n,i,j,res   :       longint;
{*      *       *       *       *}
Function lay(n : longint;i : integer) : integer;
BEGIN
    lay:=(n shr i) and 1;
END;
{*      *       *       *       *}
Function max(xx,yy : longint) : longint;
BEGIN
    if xx > yy then max := xx
       else max := yy;
END;
{*      *       *       *       *}
Procedure Init;
Var k : integer;
    s : longint;
BEGIN
    fillchar(tm,sizeof(tm),false);
    tm[0]:=true;
    tm[1]:=true;
    tm[2]:=true;
    tm[4]:=true;
    tm[5]:=true;
    tm[8]:=true;
    tm[9]:=true;
    tm[10]:=true;
    For i:=1 to n do
      For j:=0 to 15 do
        f[i,j]:= -maxlongint;
      f[1,0]:=-maxlongint;
    For i:=1 to 15 do
      if tm[i] then
        BEGIN
            s:=0;
            For k:=0 to 3 do
              if lay(i,k)=1 then s:= s+ a[k+1,1];
            f[1,i]:=s;
        END;
END;
{*      *       *       *       *}
Function kiemtra(xx,yy : longint) : boolean;
Var u : integer;
    ok : boolean;
BEGIN
    ok:=true;
    For u:=0 to 3 do
      if ( lay(xx,u)=1 ) and ( lay(yy,u) =1 ) then ok:=false;
    kiemtra := ok;
END;
{*      *       *       *       *}
Procedure Solve;
Var i,j,k,s,t  : longint;
BEGIN
    For i:=2 to n do
       For j:=0 to 15 do
         if tm[j] then
            BEGIN
                For k:=0 to 15 do
                     if tm[k] then
                         BEGIN
                             if kiemtra(j,k) and (f[i-1,k] > -maxlongint) then
                                BEGIN
                                    s:=0;
                                    For t:=0 to 3 do
                                      if lay(j,t)=1 then s:=s + a[t+1,i];
                                    f[i,j]:= max( f[i,j], f[i-1,k] + s);
                                END;
                         END;
            END;
    res:=-maxlongint;
    For i:=0 to 15 do
     if tm[i] then
      if res < f[n,i] then res:= f[n,i];
END;
{*      *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n);
    For i:=1 to 4 do

       BEGIN
       For j:=1 to n do
        read(fi,a[i,j]);
        readln(fi);
       END;
       res:=-maxlongint;
        close(fi);
    for i:=1 to 4 do
      For j:=1 to n do
        if a[i,j] > res then res := a[i,j];
    if res < 0 then
      BEGIN
          Assign(fo,out);rewrite(fo);
          write(fo,res);
          close(fo);
          halt;

      END;

    init;
    solve;
    Assign(fo,out);rewrite(fo);
    writeln(fo,res);
    close(fo);

END.
