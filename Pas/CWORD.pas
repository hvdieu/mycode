Const     inp = 'CWORD.INP';
          out = 'CWORD.OUT';
          maxn = 31;
Var       fi,fo  :      text;
          n     :       integer;
          a,x     :       array [1..maxn] of string;
          cx    :       array [1..maxn] of boolean;
          dem   :       integer;
          s1,s2 :       string;
          ok    :       boolean;
{*        *     *       *       *}
procedure input;
var i : integer;
BEGIN
    Assign(fi,inp);reset(fi);
    Readln(fi,n);
    For i:=1 to n do
      readln(fi,a[i]);
    Close(fi);
END;
{*      *       *       *       *}
procedure solve;
Var i,j,k : integer;
BEGIN
    fillchar(cx,sizeof(cx),true);
    For i:=1 to n do
      if cx[i] then
        BEGIN
            Inc(dem);
            s1:=a[i];
            For j:=1 to n do
              if cx[j] and (length(s1) = length(a[j])) then
                BEGIN
                    s2:=a[j];
                    ok:=true;
                    For k:=1 to length(s1) do
                      if (s1[k]<> '*') and (s2[k] <> '*') and (s1[k] <> s2[k]) then
                          BEGIN
                              ok:=false;
                              break;
                          END;
                      if ok then cx[j]:=false;
                END;
        END;

END;
{*      *       *       *       *}
procedure output;
BEGIN
    assign(fo,out);rewrite(fo);
    write(fo,dem);
    close(fo);
END;
{*      *       *       *       *}
BEGIN
    input;
    solve;
    output;
END.

