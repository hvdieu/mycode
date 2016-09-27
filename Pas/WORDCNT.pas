Const     inp = '';
          out = '';
          maxn = 1001;
Var       fi,fo :       text;
          s     :       ansistring;
          a     :       array [1..maxn] of integer;
          n,t,i,dem,m,p,j     :       integer;
{*        *     *   *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,t);
    Assign(fo,out);rewrite(fo);
    For i:=1 to t do
      BEGIN
          readln(fi,s);
          While s[1]=' ' do delete(s,1,1);
          if length(s)=0 then writeln(fo,0)
           else
        BEGIN
          j:=1;
          dem:=0;
          n:=0;
          m:=length(s);
          s:=s+ '2';
          While j <= m do
            BEGIN
                While (s[j] in ['a'..'z']) and (j <= m) do
                 BEGIN
                     inc(j);
                     inc(dem);
                 END;
                inc(n);
                a[n]:=dem;
                While (s[j] = ' ' ) and (j <= m) do
                      inc(j);
                dem:=0;
            END;
          a[n+1]:=21;
          j:=1;
          dem:=1;
          p:=0;
          While j < n do
            BEGIN
                While a[j]=a[j+1] do
                  BEGIN
                      inc(j);
                      inc(dem);
                  END;
                if dem > p then p:=dem;
                dem:=1;
                inc(j);
            END;
          writeln(fo,p);
        END;
      END;
    close(fi);
    close(fo);
END.

