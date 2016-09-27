Const    inp = 'PERMUTE.INP';
         out = 'PERMUTE.OUT';
         maxn = 10;
Var      fi,fo  :       text;
         s      :       string;
         d      :       array ['A'..'Z'] of integer;
         x      :       array [1..maxn] of char;
         max,n    :       longint;
{*       *      *       *       *}
{*      *       *       *       *}
Procedure Output;
Var j : integer;
BEGIN
     For j:=1 to n do write(fo,x[j]);
     writeln(fo);
END;
{*      *       *       *       *}
Procedure try(i : integer);
Var k : char;
BEGIN
    For k:='A' to 'Z' do
      if d[k]>0 then
        BEGIN
            x[i]:=k;
            Dec(d[k]);
            if i=n then output
              else try(i+1);
            Inc(d[k]);
        END;
END;
{*      *       *       *       *}
Procedure input;
Var i : integer;
    j : char;
BEGIN
    assign(fi,inp);reset(fi);
    read(fi,s);
    Close(fi);
    n:=length(s);
    fillchar(d,sizeof(d),0);
    for i:=1 to n do inc(d[s[i]]);
    assign(fo,out);rewrite(fo);
    max:=1;
    For i:=2 to n do
      max:=max*i;
    For j:='A' to 'Z' do
      if d[j]>0 then max:=max div d[j];
    writeln(fo,max);
    try(1);
    close(fo);
END;

{*      *       *       *       *}
BEGIN
    input;
END.
