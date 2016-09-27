Program VSTEPS;
Const   inp = '';
        out = '';
        maxn = 100010;
Var     fi,fo   :       text;
        n,k     :       longint;
        f       :       array [0..maxn] of longint;
        d       :       array [0..maxn] of boolean;
{*      *       *       *}
Procedure Input;
Var i,j : longint;
BEGIN
    fillchar(d,sizeof(d),true);
    Assign(fi,inp);reset(fi);
    readln(fi,n,k);
    for i:=1 to k do
      BEGIN
          read(fi,j);
          d[j]:=false;
      END;
    Close(fi);
END;
{*      *       *       *}
Procedure QHD;
Var i : longint;
BEGIN
    f[0]:=0;
    f[1]:=1;
    For i:=2 to n do
      BEGIN
          if d[i] then
            BEGIN
              f[i]:=f[i-1]+f[i-2];
              f[i]:=f[i] mod 14062008;
            END;
      END;
END;
{*      *       *       *}
Procedure Output;
BEGIN
    assign(fo,out);rewrite(fo);
    write(fo,f[n]);
    close(fo);
END;
{*      *       *       *}
BEGIN
    input;
    qhd;
    output;
END.