Const   inp = 'IOIBIN.INP';
        out = 'IOIBIN.OUT';
        maxn = 10000;
Var     fi,fo   :       text;
        a,b       :       array [1..maxn,1..maxn] of boolean;
        n,x,y,z,k,u,v       : longint;
{*      *       *     * *}
BEGIN
    Assign(fi,inp);reset(fi);
    Assign(fo,out);rewrite(fo);
    readln(fi,n);
    fillchar(a,sizeof(a),false);
    While not eof(fi) do
      BEGIN
          readln(fi,x,y,z);
          if z=1 then
          BEGIN
                a[x,y]:=true;
                a[y,x]:=true;
                for k:=1 to n do
                  For u:=1 to n do
                    For v:=1 to n do
                      a[u,v] := a[u,v] or (a[u,k] and a[k,v]);
          END
           else if z=2 then
                BEGIN
                        if a[x,y] then writeln(fo,1)
                         else writeln(fo,0);
                END;
      END;
    close(fi);
    close(fo);
END.
