program STAIR;
const   inp = 'STAIR.INP';
        out = 'STAIR.out';
        maxn  = 800;
Var     fi,fo :         text;
        f       :       array [0..maxn,0..maxn] of longint;
        n       :       longint;
{*      *       *       *}
Procedure Input;
BEGIN
    assign(fi,inp);reset(fi);
    read(fi,n);
    close(fi);
END;
{*      *       *       *}
Procedure QHD;
Var i,j,k : longint;
BEGIN
    fillchar(f,sizeof(f),0);
    f[0,0]:=1;
    For i:=1 to n do
      for j:=1 to n do
        for k:=1 to j-1 do
        f[i,j]:=f[i,j]+f[i-j,k];
END;
{*      *       *       *}
Procedure output;
BEGIN
    assign(fo,out);rewrite(fo);
    write(fo,f[n,n]);
    close(fo);
END;
{*      *       *       *}
BEGIN
       input;
       qhd;
       output;
END.