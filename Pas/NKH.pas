Const   inp = '';
        out = '';
        maxn = 101;
Var     fi,fo   :       text;
        n,m,k   :       integer;
        s,s1,s2,s3 :       string;
        x       :       array [0..maxn] of integer;
        d       :       array [1..2*maxn] of boolean;
{*      *       *       *       *}
Procedure Output;
Var k : integer;
BEGIN
    Assign(fo,out);rewrite(fo);
    For k:=1 to m do
     if d[k] then write(fo,2)
       else write(fo,1);
    close(fo);
    halt;
END;
{*      *       *       *       *}
Procedure Kiemtra;
Var k : integer;
BEGIN
    s3:='';
    For k:=1 to m do
      if d[k] then s3:=s3 + s[k];
    if s3=s2 then output;
END;
{*      *       *       *       *}
Procedure Try(i : integer);
Var j : integer;
BEGIN
    For j:=x[i-1] + 1 to m do
      if (s[j] = s1[i]) and d[j]  then
        BEGIN
            x[i] := j;
            d[j]:=false;
            if i=n then kiemtra
              else try(i+1);
            d[j]:=true;
        END;
END;
{*      *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,s1);
    readln(fi,s2);
    readln(fi,s);
    close(fi);
    x[0]:=0;
    fillchar(d,sizeof(d),true);
    n := length(s1);
    m := length(s);
    Try(1);
END.