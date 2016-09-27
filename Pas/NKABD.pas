Program NKABD;
Const    inp = 'NKABD.INP';
         out = 'NKABD.OUT';
         max = 100050;
Var      fi,fo :        text;
         L,R,dem    :       longint;
         a      :       array [2..max] of longint;
{*       *      *       *       *}
Procedure input;
BEGIN
    assign(fi,inp);reset(fi);
    readln(fi,l,r);
    close(fi);
END;
{*      *       *       *       *}
Function mu ( g,h : longint) : int64;
Var tmp : int64;
   l : longint;
BEGIN
    tmp:=1;
    For l:=1 to h do
      BEGIN
          tmp:=tmp*g;
      END;
    mu:=tmp;
END;
{*      *       *       *       *}
Function Tonguoc( i : longint) : boolean;
Var j,x: longint;
   m,k : int64;
   ok : boolean;
BEGIN
    ok:=false;
    x:=i;
    m:=1;
    fillchar(a,sizeof(a),0);
    j:=2;
    While i>1 do
      BEGIN
         While i mod j = 0 do
            BEGIN
              Inc(a[j]);
              i:=i div j;
            END;
                a[x]:=0;
                 If a[j]<>0 then
                   BEGIN
                k:=(mu(j,a[j]+1)-1) div (j-1);
                m:=m*k;
                if m>x then exit(true);
                END;
         Inc(j);
      END;
    tonguoc:=ok;
END;
{*      *       *       *       *}
Procedure Xuly;
Var u : longint;
BEGIN
    dem:=0;
    For u:=l to r do
      BEGIN
           If tonguoc(u) then inc(dem);
      END;
END;
{*      *       *       *       *}
Procedure Output;
BEGIN
    Assign(fo,out);rewrite(fo);
    Write(fo,dem);
    Close(fo);
END;
{*       *       *       *       *}
BEGIN
    Input;
    xuly;
    Output;
END.
