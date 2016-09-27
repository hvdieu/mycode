program countpl;
const   inp = '';
        out = '';
Var     fi,fo : text;
        s       :       string;
        l       :       array [0..300] of integer;
        n       :       integer;
        s1,s2   :       string;
{*      *       *       *       *}
procedure input;
BEGIN
    assign(fi,inp);reset(fi);
    read(fi,s);
    close(fi);
    n:=length(s);
END;
{*      *       *       *       *}
Function palin(x,y : integer) : boolean;
Var ok : boolean;
    k : integer;
BEGIN
    ok:=true;
    s1:='';s2:='';
    for k:=x to y do s1:=s1+s[k];
    for k:=y downto x do s2:=s2+s[k];
    if s1=s2 then ok:=true
      else ok:=false;
    palin:=ok;
END;
{*      *       *       *       *}
Function min(a,b : integer) : integer;
BEGIN
    If a>=b then min:=b
     else min:=a;
END;
{*      *       *       *       *}
procedure QHD;
Var i,j : integer;
BEGIN
    l[1]:=1;
    l[0]:=0;
    for i:=2 to n do l[i]:=maxint;
    For i:=2 to n do
      For j:=i downto 1 do
        if palin(j,i) then l[i]:=min(l[i],l[j-1]+1);
END;
{*      *       *       *       *}
procedure output;
BEGIN
    assign(fo,out);rewrite(fo);
    write(fo,l[length(s)]);
    close(fo);
END;
{*      *       *       *       *}
BEGIN
  input;
  qhd;
  output;
END.
