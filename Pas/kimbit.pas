Program Kimbits;
Const   inp = 'kimbits.inp';
        out = 'kimbits.out';
        maxn = 34;
Var     fi,fo   :       text;
        f       :       array [0..maxn,0..maxn] of int64;
        n,l     :       integer;
        k       :       int64;
        x       :       array [1..maxn] of integer;
{*      *       *       *       *}
Procedure Input;
BEGIN
    assign(fi,inp);reset(fi);
    readln(fi,n,l,k);
    close(fi);
END;
{*      *       *       *       *}
Procedure Init;
Var i : integer;
BEGIN
    For i:=1 to n do
        f[i,0]:=1;
    For i:=1 to l do
        f[0,i]:=1;
    f[0,0]:=1;
END;
{*      *       *       *       *}
Procedure Solve;
Var i,j : integer;
BEGIN
    For i:=1 to n do
      For j:=1 to l do
        if i>=j then f[i,j]:=f[i-1,j]+f[i-1,j-1]
          else f[i,j]:=f[i,j-1];
END;
{*      *       *       *       *}
Procedure Output;
Var i,j,t : integer;
BEGIN
    Assign(fo,out);rewrite(fo);
    i:=n;
    j:=l;
    t:=0;
    While (k>1) do
      BEGIN
          if k>f[i-1,j] then
            BEGIN
                Inc(t);
                x[t]:=1;
                k:=k-f[i-1,j];
                i:=i-1;
                j:=j-1;
            END
              else BEGIN
                       inc(t);
                       i:=i-1;
                   END;

      END;
      For i:=1 to n do write(fo,x[i]);
      close(fo);
END;
{*      *       *       *       *}
BEGIN
       input;
       init;
       solve;
       output;
END.
